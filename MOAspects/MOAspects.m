//
//  MOAspects.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import "MOAspects.h"

#import "MOAspectsStore.h"
#import "MOARuntime.h"

#define MOAspectsErrorLog(...) do { NSLog(__VA_ARGS__); }while(0)

@implementation MOAspects

NSString * const MOAspectsPrefix = @"__moa_aspects_";

#pragma mark - Public

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                        usingBlock:(id)block
{
    if (![MOARuntime hasInstanceMethodForClass:clazz selector:selector]) {
        MOAspectsErrorLog(@"-[%@ %@] unrecognized selector",
                          NSStringFromClass(clazz),
                          NSStringFromSelector(selector));
        return NO;
    }
    
    if ([NSStringFromSelector(selector) hasPrefix:MOAspectsPrefix]) {
        MOAspectsErrorLog(@"-[%@ %@] can not hook \"__moa_aspects_\" prefix selector",
                          NSStringFromClass(clazz),
                          NSStringFromSelector(selector));
        return NO;
    }
    
    Class rootClass = [MOARuntime rootClassForInstanceRespondsToClass:clazz selector:selector];
    SEL aspectsSelector = [MOARuntime selectorWithSelector:selector prefix:MOAspectsPrefix];
    if (![MOARuntime hasInstanceMethodForClass:rootClass selector:aspectsSelector]) {
        if ([MOARuntime copyInstanceMethodForClass:rootClass atSelector:selector toSelector:aspectsSelector]) {
            [MOARuntime overwritingMessageForwardInstanceMethodForClass:rootClass selector:selector];
        } else {
            MOAspectsErrorLog(@"-[%@ %@] failed copy method",
                              NSStringFromClass(clazz),
                              NSStringFromSelector(selector));
        }
    }
    
    MOAspectsTarget *target = [self targetInStoreWithClass:rootClass
                                                methodType:MOAspectsTargetMethodTypeInstance
                                                  selector:selector
                                           aspectsSelector:aspectsSelector];
    [self addHookMethodWithTarget:target class:clazz aspectsPosition:aspectsPosition usingBlock:block];
    
    SEL aspectsForwardInovcationSelector = [MOARuntime selectorWithSelector:@selector(forwardInvocation:)
                                                                     prefix:MOAspectsPrefix];
    if (![MOARuntime hasInstanceMethodForClass:clazz selector:aspectsForwardInovcationSelector]) {
        [MOARuntime copyInstanceMethodForClass:clazz
                                    atSelector:@selector(forwardInvocation:)
                                    toSelector:aspectsForwardInovcationSelector];
    }
    
    __weak typeof(self) weakSelf = self;
    [MOARuntime overwritingInstanceMethodForClass:clazz
                                         selector:@selector(forwardInvocation:)
                              implementationBlock:^(id object, NSInvocation *invocation) {
                                  Class rootClass = [MOARuntime rootClassForInstanceRespondsToClass:[object class]
                                                                                           selector:invocation.selector];
                                  NSString *key = [MOAspectsStore keyWithClass:rootClass
                                                                    methodType:MOAspectsTargetMethodTypeInstance
                                                                      selector:invocation.selector];
                                  MOAspectsTarget *target = [[MOAspectsStore sharedStore] targetForKey:key];
                                  if (target) {
                                      [weakSelf invokeWithTarget:target toObject:object invocation:invocation];
                                  } else {
                                      SEL aspectsForwardInovcationSelector = [MOARuntime
                                                                              selectorWithSelector:@selector(forwardInvocation:)
                                                                              prefix:MOAspectsPrefix];
                                      [invocation setSelector:aspectsForwardInovcationSelector];
                                      [invocation invoke];
                                  }
                              }];
    
    return YES;
}

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block
{
    if (![MOARuntime hasClassMethodForClass:clazz selector:selector]) {
        MOAspectsErrorLog(@"+[%@ %@] unrecognized selector",
                          NSStringFromClass(clazz),
                          NSStringFromSelector(selector));
        return NO;
    }
    
    if ([NSStringFromSelector(selector) hasPrefix:MOAspectsPrefix]) {
        MOAspectsErrorLog(@"+[%@ %@] can not hook \"__moa_aspects_\" prefix selector",
                          NSStringFromClass(clazz),
                          NSStringFromSelector(selector));
        return NO;
    }
    
    Class rootClass = [MOARuntime rootClassForClassRespondsToClass:clazz selector:selector];
    SEL aspectsSelector = [MOARuntime selectorWithSelector:selector prefix:MOAspectsPrefix];
    if (![MOARuntime hasClassMethodForClass:clazz selector:aspectsSelector]) {
        if ([MOARuntime copyClassMethodForClass:clazz atSelector:selector toSelector:aspectsSelector]) {
            [MOARuntime overwritingMessageForwardClassMethodForClass:clazz selector:selector];
        } else {
            MOAspectsErrorLog(@"+[%@ %@] failed copy method",
                              NSStringFromClass(clazz),
                              NSStringFromSelector(selector));
        }
    }
    
    MOAspectsTarget *target = [self targetInStoreWithClass:rootClass
                                                methodType:MOAspectsTargetMethodTypeClass
                                                  selector:selector
                                           aspectsSelector:aspectsSelector];
    [self addHookMethodWithTarget:target class:clazz aspectsPosition:aspectsPosition usingBlock:block];
    
    SEL aspectsForwardInovcationSelector = [MOARuntime selectorWithSelector:@selector(forwardInvocation:)
                                                                     prefix:MOAspectsPrefix];
    if (![MOARuntime hasClassMethodForClass:clazz selector:aspectsForwardInovcationSelector]) {
        [MOARuntime copyClassMethodForClass:clazz
                                 atSelector:@selector(forwardInvocation:)
                                 toSelector:aspectsForwardInovcationSelector];
    }
    
    __weak typeof(self) weakSelf = self;
    [MOARuntime overwritingClassMethodForClass:clazz
                                      selector:@selector(forwardInvocation:)
                           implementationBlock:^(id object, NSInvocation *invocation) {
                               Class rootClass = [MOARuntime rootClassForClassRespondsToClass:[object class]
                                                                                     selector:invocation.selector];
                               NSString *key = [MOAspectsStore keyWithClass:rootClass
                                                                 methodType:MOAspectsTargetMethodTypeClass
                                                                   selector:invocation.selector];
                               MOAspectsTarget *target = [[MOAspectsStore sharedStore] targetForKey:key];
                               if (target) {
                                   [weakSelf invokeWithTarget:target toObject:object invocation:invocation];
                               } else {
                                   SEL aspectsForwardInovcationSelector = [MOARuntime
                                                                           selectorWithSelector:@selector(forwardInvocation:)
                                                                           prefix:MOAspectsPrefix];
                                   [invocation setSelector:aspectsForwardInovcationSelector];
                                   [invocation invoke];
                               }
                           }];
    
    return YES;
}

#pragma mark - Private

+ (SEL)beforeSelectorWithTarget:(MOAspectsTarget *)target
{
    return NSSelectorFromString([NSString stringWithFormat:@"%@before_%d_%@",
                                 MOAspectsPrefix,
                                 (int)target.beforeSelectors.count,
                                 NSStringFromSelector(target.selector)]);
}

+ (SEL)afterSelectorWithTarget:(MOAspectsTarget *)target
{
    return NSSelectorFromString([NSString stringWithFormat:@"%@after_%d_%@",
                                 MOAspectsPrefix,
                                 (int)target.afterSelectors.count,
                                 NSStringFromSelector(target.selector)]);
}

+ (MOAspectsTarget *)targetInStoreWithClass:(Class)clazz
                                 methodType:(MOAspectsTargetMethodType)methodType
                                   selector:(SEL)selector
                            aspectsSelector:(SEL)aspectsSelector
{
    NSString *key = [MOAspectsStore keyWithClass:clazz
                                      methodType:methodType
                                        selector:selector];
    MOAspectsTarget *target = [[MOAspectsStore sharedStore] targetForKey:key];
    if (!target) {
        target = [[MOAspectsTarget alloc] initWithClass:clazz
                                              mehodType:methodType
                                         methodSelector:selector
                                        aspectsSelector:aspectsSelector];
        [[MOAspectsStore sharedStore] setTarget:target forKey:key];
    }
    return target;
}

+ (void)addHookMethodWithTarget:(MOAspectsTarget *)target
                          class:(Class)clazz
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block
{
    switch (aspectsPosition) {
        case MOAspectsPositionBefore:
        {
            SEL beforeSelector = [self beforeSelectorWithTarget:target];
            [self addMethodForClass:target.class
                         methodType:target.methodType
                           selector:beforeSelector
                              block:block];
            [target addBeforeSelector:beforeSelector forClass:clazz];
        }
            break;
        case MOAspectsPositionAfter:
        {
            SEL afterSelector = [self afterSelectorWithTarget:target];
            [self addMethodForClass:target.class
                         methodType:target.methodType
                           selector:afterSelector
                              block:block];
            [target addAfterSelector:afterSelector forClass:clazz];
        }
            break;
    }
}

+ (NSMethodSignature *)methodSignatureWithTarget:(MOAspectsTarget *)target
{
    NSMethodSignature *methodSignature;
    if (target.methodType == MOAspectsTargetMethodTypeClass) {
        methodSignature = [MOARuntime classMethodSignatureWithClass:target.class
                                                           selector:target.selector];
    } else {
        methodSignature = [MOARuntime instanceMethodSignatureWithClass:target.class
                                                              selector:target.selector];
    }
    return methodSignature;
}

+ (Class)rootClassWithClass:(Class)clazz methodType:(MOAspectsTargetMethodType)methodType selector:(SEL)selector
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime rootClassForClassRespondsToClass:clazz
                                                   selector:selector];
    } else {
        return [MOARuntime rootClassForInstanceRespondsToClass:clazz
                                                      selector:selector];
    }
}

+ (BOOL)addMethodForClass:(Class)clazz
               methodType:(MOAspectsTargetMethodType)methodType
                 selector:(SEL)selector
                    block:(id)block
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime addClassMethodForClass:clazz
                                         selector:selector
                              implementationBlock:block];
    } else {
        return [MOARuntime addInstanceMethodForClass:clazz
                                            selector:selector
                                 implementationBlock:block];
    }
}

+ (NSInvocation *)invocationWithBaseInvocation:(NSInvocation *)baseInvocation
                                  targetObject:(id)object
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:baseInvocation.methodSignature];
    [invocation setArgument:(__bridge void *)(object) atIndex:0];
    void *argp = NULL;
    for (NSUInteger idx = 2; idx < baseInvocation.methodSignature.numberOfArguments; idx++) {
        const char *type = [baseInvocation.methodSignature getArgumentTypeAtIndex:idx];
        NSUInteger argSize;
        NSGetSizeAndAlignment(type, &argSize, NULL);
        
        if (!(argp = reallocf(argp, argSize))) {
            MOAspectsErrorLog(@"missing create invocation");
            return nil;
        }
        [baseInvocation getArgument:argp atIndex:idx];
        [invocation setArgument:argp atIndex:idx];
    }
    if (argp != NULL) {
        free(argp);
    }
    return invocation;
}

+ (void)invokeWithTarget:(MOAspectsTarget *)target toObject:(id)object invocation:(NSInvocation *)invocation
{
    NSInvocation *aspectsInvocation = [self invocationWithBaseInvocation:invocation
                                                            targetObject:object];
    for (NSValue *value in target.beforeSelectors) {
        SEL selector = [value pointerValue];
        if ([object class] == [target classForSelector:selector]) {
            [aspectsInvocation setSelector:selector];
            [aspectsInvocation invokeWithTarget:object];
        }
    }
    
    invocation.selector = target.aspectsSelector;
    [invocation invoke];
    
    for (NSValue *value in target.afterSelectors) {
        SEL selector = [value pointerValue];
        if ([object class] == [target classForSelector:selector]) {
            [aspectsInvocation setSelector:selector];
            [aspectsInvocation invokeWithTarget:object];
        }
    }
}

@end
