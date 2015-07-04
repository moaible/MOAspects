//
//  MOARuntime.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/02/12.
//  Copyright (c) 2015 MOAI. All rights reserved
//

#import "MOARuntime.h"

#import <objc/runtime.h>
#import <objc/message.h>

#define MOARuntimeErrorLog(...) do { NSLog(__VA_ARGS__); }while(0)

typedef NS_OPTIONS(int, MOABlockFlags) {
    MOABlockFlagsHasCopyDisposeHelpers = (1 << 25),
    MOABlockFlagsHasSignature          = (1 << 30)
};

typedef struct _MOABlock {
    __unused Class isa;
    MOABlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct _MOABlock *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires MOABlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires MOABlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *MOABlockRef;

@implementation MOARuntime

#pragma mark - Public

+ (NSString *)stringWithClass:(Class)clazz
{
    return [NSString stringWithCString:object_getClassName(clazz)
                              encoding:NSUTF8StringEncoding];
}

+ (Class)classWithString:(NSString *)string
{
    return objc_getClass([string cStringUsingEncoding:NSUTF8StringEncoding]);
}

+ (NSArray *)classNames
{
    return [self classNamesForRegexPattern:nil];
}

+ (NSArray *)classNamesForRegexPattern:(NSString *)pattern
{
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    NSMutableArray *classNames = [@[] mutableCopy];
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            NSString *className = [NSString stringWithCString:class_getName(classes[i])
                                                     encoding:NSUTF8StringEncoding];
            if (!pattern || [className rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound) {
                [classNames addObject:className];
            }
        }
        free(classes);
    }
    
    return classNames;
}

+ (Class)metaClassWithClass:(Class)clazz
{
    return objc_getMetaClass(class_getName(clazz));
}

+ (void)exchangeImplementationsWithClass:(Class)clazz
              fromInstanceMethodSelector:(SEL)fromSEL
                toInstanceMethodSelector:(SEL)toSEL
{
    NSAssert([clazz instancesRespondToSelector:fromSEL],
             @"not responds to selector is %@", NSStringFromSelector(fromSEL));
    NSAssert([clazz instancesRespondToSelector:toSEL],
             @"not responds to selector is %@", NSStringFromSelector(toSEL));
    
    Method fromMethod = class_getInstanceMethod(clazz, fromSEL);
    Method toMethod = class_getInstanceMethod(clazz, toSEL);
    method_exchangeImplementations(fromMethod, toMethod);
}

+ (void)exchangeImplementationsWithClass:(Class)clazz
                 fromClassMethodSelector:(SEL)fromSEL
                   toClassMethodSelector:(SEL)toSEL
{
    NSAssert([clazz respondsToSelector:fromSEL],
             @"not responds to selector is %@", NSStringFromSelector(fromSEL));
    NSAssert([clazz respondsToSelector:toSEL],
             @"not responds to selector is %@", NSStringFromSelector(toSEL));
    
    Method fromMethod = class_getClassMethod(clazz, fromSEL);
    Method toMethod = class_getClassMethod(clazz, toSEL);
    method_exchangeImplementations(fromMethod, toMethod);
}

+ (NSArray *)propertyNamesWithClass:(Class)clazz
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(clazz, &propertyCount);
    NSMutableArray *propertyNames = [@[] mutableCopy];
    for(NSUInteger i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:NSUTF8StringEncoding];
            [propertyNames addObject:propertyName];
        }
    }
    free(properties);
    
    return propertyNames;
}

+ (NSArray *)propertyNamesWithClass:(Class)clazz depth:(BOOL)depth
{
    if (depth) {
        return [self propertyNamesWithClass:clazz depthForClass:[NSObject class]];
    } else {
        return [self propertyNamesWithClass:clazz];
    }
}

+ (NSArray *)propertyNamesWithClass:(Class)clazz depthForClass:(Class)depthClazz
{
    NSArray *properties = [self propertyNamesWithClass:clazz];
    
    if (clazz == depthClazz) {
        return properties;
    }
    
    return [properties arrayByAddingObjectsFromArray:[self propertyNamesWithClass:class_getSuperclass(clazz)
                                                                    depthForClass:depthClazz]];
}

+ (const char *)objcTypeEncodingWithClass:(Class)clazz classMethodSelector:(SEL)classMethodSelector
{
    return method_getTypeEncoding(class_getClassMethod(clazz, classMethodSelector));
}

+ (const char *)objcTypeEncodingWithClass:(Class)clazz instanceMethodSelector:(SEL)instanceMethodSelector
{
    return method_getTypeEncoding(class_getInstanceMethod(clazz, instanceMethodSelector));
}

+ (const char *)objcTypeEncodingWithBlock:(id)block
{
    MOABlockRef blockRef = (__bridge void *)block;
    if (!(blockRef->flags & MOABlockFlagsHasSignature)) {
        MOARuntimeErrorLog(@"");
        return nil;
    }
    void *descriptor = blockRef->descriptor;
    descriptor += 2 * sizeof(unsigned long int);
    if (blockRef->flags & MOABlockFlagsHasCopyDisposeHelpers) {
        descriptor += 2 * sizeof(void *);
    }
    if (!descriptor) {
        MOARuntimeErrorLog(@"");
        return nil;
    }
    return (*(const char **)descriptor);
}

+ (BOOL)hasPropertyName:(NSString *)name atClass:(Class)clazz
{
    return class_getProperty(clazz, [name cStringUsingEncoding:NSUTF8StringEncoding]) != NULL;
}

+ (SEL)selectorWithSelector:(SEL)selector prefix:(NSString *)prefix
{
    NSParameterAssert(prefix);
    return NSSelectorFromString([NSString stringWithFormat:@"%@%@", prefix, NSStringFromSelector(selector)]);
}

+ (BOOL)selector:(SEL)leftSelector isEqualToSelector:(SEL)rightSelector
{
    return sel_isEqual(leftSelector, rightSelector);
}

+ (NSMethodSignature *)classMethodSignatureWithClass:(Class)clazz selector:(SEL)selector
{
    return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(class_getClassMethod(clazz, selector))];
}

+ (NSMethodSignature *)instanceMethodSignatureWithClass:(Class)clazz selector:(SEL)selector
{
    return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(class_getInstanceMethod(clazz, selector))];
}

+ (BOOL)hasInstanceMethodForClass:(Class)clazz selector:(SEL)selector
{
    return class_getInstanceMethod(clazz, selector) != nil;
}

+ (Class)rootClassForInstanceRespondsToClass:(Class)clazz selector:(SEL)selector
{
    if (![MOARuntime hasInstanceMethodForClass:clazz
                                      selector:selector]) {
        return nil;
    } else if ([MOARuntime hasInstanceMethodForClass:class_getSuperclass(clazz)
                                            selector:selector]) {
        return [self rootClassForInstanceRespondsToClass:class_getSuperclass(clazz)
                                                selector:selector];
    }
    
    return clazz;
}

+ (Class)rootClassForClassRespondsToClass:(Class)clazz selector:(SEL)selector
{
    if (![MOARuntime hasClassMethodForClass:clazz
                                   selector:selector]) {
        return nil;
    } else if ([MOARuntime hasClassMethodForClass:class_getSuperclass(clazz)
                                         selector:selector]) {
        return [self rootClassForClassRespondsToClass:class_getSuperclass(clazz)
                                             selector:selector];
    }
    
    return clazz;
}

+ (BOOL)hasClassMethodForClass:(Class)clazz selector:(SEL)selector
{
    return class_getClassMethod(clazz, selector) != nil;
}

+ (void)overwritingClassMethodForClass:(Class)clazz
                              selector:(SEL)selector
                   implementationBlock:(id)implementationBlock
{
    NSAssert([clazz respondsToSelector:selector],
             @"not responds to selector is %@", NSStringFromSelector(selector));
    IMP blockIMP = imp_implementationWithBlock(implementationBlock);
    Method classMethod = class_getClassMethod(clazz, selector);
    method_setImplementation(classMethod, blockIMP);
}

+ (void)overwritingInstanceMethodForClass:(Class)clazz
                                 selector:(SEL)selector
                      implementationBlock:(id)implementationBlock
{
    NSAssert([clazz instancesRespondToSelector:selector],
             @"not responds to selector is %@", NSStringFromSelector(selector));
    IMP blockIMP = imp_implementationWithBlock(implementationBlock);
    Method instanceMethod = class_getInstanceMethod(clazz, selector);
    method_setImplementation(instanceMethod, blockIMP);
}

+ (void)overwritingMessageForwardInstanceMethodForClass:(Class)clazz selector:(SEL)selector
{
    Method instanceMethod = class_getInstanceMethod(clazz, selector);
    method_setImplementation(instanceMethod, [self msgForwardIMPWithMethod:instanceMethod]);
}

+ (void)overwritingMessageForwardClassMethodForClass:(Class)clazz selector:(SEL)selector
{
    Method classMethod = class_getClassMethod(clazz, selector);
    method_setImplementation(classMethod, [self msgForwardIMPWithMethod:classMethod]);
}

+ (BOOL)addInstanceMethodForClass:(Class)clazz
                         selector:(SEL)selector
              implementationBlock:(id)implementationBlock
{
    if ([self hasInstanceMethodForClass:clazz selector:selector]) {
        return NO;
    }
    
    return class_addMethod(clazz,
                           selector,
                           imp_implementationWithBlock(implementationBlock),
                           [self objcTypeEncodingWithBlock:implementationBlock]);
}

+ (BOOL)addClassMethodForClass:(Class)clazz
                      selector:(SEL)selector
           implementationBlock:(id)implementationBlock
{
    if ([self hasClassMethodForClass:clazz selector:selector]) {
        return NO;
    }
    
    return class_addMethod(objc_getMetaClass(class_getName(clazz)),
                           selector,
                           imp_implementationWithBlock(implementationBlock),
                           [self objcTypeEncodingWithBlock:implementationBlock]);;
}

+ (BOOL)copyInstanceMethodForClass:(Class)clazz
                        atSelector:(SEL)selector
                        toSelector:(SEL)copySelector
{
    return class_addMethod(clazz,
                           copySelector,
                           method_getImplementation(class_getInstanceMethod(clazz, selector)),
                           method_getTypeEncoding(class_getInstanceMethod(clazz, selector)));
}

+ (BOOL)copyClassMethodForClass:(Class)clazz
                     atSelector:(SEL)selector
                     toSelector:(SEL)copySelector
{
    return class_addMethod([self metaClassWithClass:clazz],
                           copySelector,
                           method_getImplementation(class_getClassMethod(clazz, selector)),
                           method_getTypeEncoding(class_getClassMethod(clazz, selector)));
}

#pragma mark - Private

+ (IMP)msgForwardIMPWithMethod:(Method)method
{
    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
    const char *encoding = method_getTypeEncoding(method);
    BOOL methodReturnsStructValue = encoding[0] == _C_STRUCT_B;
    if (methodReturnsStructValue) {
        @try {
            NSUInteger valueSize = 0;
            NSGetSizeAndAlignment(encoding, &valueSize, NULL);
            
            if (valueSize == 1 || valueSize == 2 || valueSize == 4 || valueSize == 8) {
                methodReturnsStructValue = NO;
            }
        } @catch (NSException *e) {}
    }
    if (methodReturnsStructValue) {
        msgForwardIMP = (IMP)_objc_msgForward_stret;
    }
#endif
    return msgForwardIMP;
}

@end
