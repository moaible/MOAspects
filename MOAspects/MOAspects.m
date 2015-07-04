//
//  MOAspects.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015 MOAI. All rights reserved
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
    return [self hookInstanceMethodForClass:clazz
                                   selector:selector
                            aspectsPosition:aspectsPosition
                                  hookRange:MOAspectsHookRangeSingle
                                 usingBlock:block];
}

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                         hookRange:(MOAspectsHookRange)hookRange
                        usingBlock:(id)block
{
    return [self hookMethodForClass:clazz
                           selector:selector
                         methodType:MOAspectsTargetMethodTypeInstance
                    aspectsPosition:aspectsPosition
                          hookRange:hookRange
                         usingBlock:block];
}

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block
{
    return [self hookClassMethodForClass:clazz
                                selector:selector
                         aspectsPosition:aspectsPosition
                               hookRange:MOAspectsHookRangeSingle
                              usingBlock:block];
}

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                      hookRange:(MOAspectsHookRange)hookRange
                     usingBlock:(id)block
{
    return [self hookMethodForClass:clazz
                           selector:selector
                         methodType:MOAspectsTargetMethodTypeClass
                    aspectsPosition:aspectsPosition
                          hookRange:hookRange
                         usingBlock:block];
}

#pragma mark - Private

+ (BOOL)hookMethodForClass:(Class)clazz
                  selector:(SEL)selector
                methodType:(MOAspectsTargetMethodType)methodType
           aspectsPosition:(MOAspectsPosition)aspectsPosition
                 hookRange:(MOAspectsHookRange)hookRange
                usingBlock:(id)block
{
    if (![self isValidClass:clazz selector:selector methodType:methodType]) {
        return NO;
    }
    
    Class rootResponderClassForForwardInvocation = [self rootClassForResponodsToClass:clazz
                                                                             selector:@selector(forwardInvocation:)
                                                                           methodType:methodType];
    
    if (![self putMethodForClass:rootResponderClassForForwardInvocation
                        selector:@selector(forwardInvocation:)
                      methodTyoe:methodType]) {
        return NO;
    }
    
    Class rootResponderClass = [self rootClassForResponodsToClass:clazz
                                                         selector:selector
                                                       methodType:methodType];
    
    if ([self putMethodForClass:rootResponderClass selector:selector methodTyoe:methodType]) {
        [self overwritingMessageForwardMethodForClass:rootResponderClass selector:selector methodType:methodType];
    } else {
        return NO;
    }
    
    MOAspectsTarget *target = [self targetInStoreWithClass:rootResponderClass
                                                  selector:selector
                                                methodType:methodType
                                                 hookRange:hookRange];
    [self addHookMethodWithTarget:target class:clazz aspectsPosition:aspectsPosition usingBlock:block ?: (id)^{
        MOAspectsErrorLog(@"%@[%@ %@] block parameter is nil",
                          methodType == MOAspectsTargetMethodTypeClass ? @"+" : @"-",
                          [MOARuntime stringWithClass:clazz],
                          NSStringFromSelector(selector));
    }];
    
    __weak typeof(self) weakSelf = self;
    [self overwritingMethodForClass:rootResponderClassForForwardInvocation
                           selector:@selector(forwardInvocation:)
                         methodType:methodType
                implementationBlock:^(id object, NSInvocation *invocation) {
                    Class rootResponderClass = [weakSelf rootClassForResponodsToClass:[object class]
                                                                             selector:invocation.selector
                                                                           methodType:methodType];
                    NSString *key = [MOAspectsStore keyWithClass:rootResponderClass
                                                        selector:invocation.selector
                                                      methodType:methodType];
                    MOAspectsTarget *target = [[MOAspectsStore sharedStore] targetForKey:key];
                    if (target) {
                        [weakSelf invokeWithTarget:target toObject:object invocation:invocation];
                    } else {
                        // invoke original "forwardInvocation:"
                        SEL aspectsForwardInovcationSelector = [MOARuntime
                                                                selectorWithSelector:@selector(forwardInvocation:)
                                                                prefix:MOAspectsPrefix];
                        [invocation setSelector:aspectsForwardInovcationSelector];
                        [invocation invoke];
                    }
                }];
    
    return YES;
}

+ (BOOL)putMethodForClass:(Class)clazz selector:(SEL)selector methodTyoe:(MOAspectsTargetMethodType)methodType
{
    SEL aspectsSelector = [MOARuntime selectorWithSelector:selector prefix:MOAspectsPrefix];
    if (![self hasMethodForClass:clazz selector:aspectsSelector methodType:methodType]) {
        if (![self copyMethodForClass:clazz atSelector:selector toSelector:aspectsSelector methodType:methodType]) {
            MOAspectsErrorLog(@"%@[%@ %@] failed copy method",
                              methodType == MOAspectsTargetMethodTypeClass ? @"+" : @"-",
                              [MOARuntime stringWithClass:clazz],
                              NSStringFromSelector(aspectsSelector));
            return NO;
        }
    }
    
    return YES;
}

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
                           selector:beforeSelector
                         methodType:target.methodType
                              block:block];
            [target addBeforeSelector:beforeSelector forClass:clazz];
        }
            break;
        case MOAspectsPositionAfter:
        {
            SEL afterSelector = [self afterSelectorWithTarget:target];
            [self addMethodForClass:target.class
                           selector:afterSelector
                         methodType:target.methodType
                              block:block];
            [target addAfterSelector:afterSelector forClass:clazz];
        }
            break;
    }
}

+ (BOOL)isValidClass:(Class)clazz selector:(SEL)selector methodType:(MOAspectsTargetMethodType)methodType
{
    if (!clazz) {
        MOAspectsErrorLog(@"class should not be nil");
        return NO;
    }
    
    if (!selector) {
        MOAspectsErrorLog(@"selector should not be nil");
        return NO;
    }
    
    if ([NSStringFromSelector(selector) hasPrefix:MOAspectsPrefix]) {
        MOAspectsErrorLog(@"%@[%@ %@] can not hook \"__moa_aspects_\" prefix selector",
                          methodType == MOAspectsTargetMethodTypeClass ? @"+" : @"-",
                          [MOARuntime stringWithClass:clazz],
                          NSStringFromSelector(selector));
        return NO;
    }
    
    if (![self hasMethodForClass:clazz selector:selector methodType:methodType]) {
        MOAspectsErrorLog(@"%@[%@ %@] unrecognized selector",
                          methodType == MOAspectsTargetMethodTypeClass ? @"+" : @"-",
                          [MOARuntime stringWithClass:clazz],
                          NSStringFromSelector(selector));
        return NO;
    }
    
    return YES;
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
        if ([self shouldInvokeTarget:target toObject:object selector:selector]) {
            [aspectsInvocation setSelector:selector];
            [aspectsInvocation invokeWithTarget:object];
        }
    }
    
    invocation.selector = [MOARuntime selectorWithSelector:target.selector prefix:MOAspectsPrefix];
    [invocation invoke];
    
    for (NSValue *value in target.afterSelectors) {
        SEL selector = [value pointerValue];
        if ([self shouldInvokeTarget:target toObject:object selector:selector]) {
            [aspectsInvocation setSelector:selector];
            [aspectsInvocation invokeWithTarget:object];
        }
    }
}

+ (MOAspectsTarget *)targetInStoreWithClass:(Class)clazz
                                   selector:(SEL)selector
                                 methodType:(MOAspectsTargetMethodType)methodType
                                  hookRange:(MOAspectsHookRange)hookRange
{
    NSString *key = [MOAspectsStore keyWithClass:clazz selector:selector methodType:methodType];
    MOAspectsTarget *target = [[MOAspectsStore sharedStore] targetForKey:key];
    if (!target) {
        target = [[MOAspectsTarget alloc] initWithClass:clazz
                                              mehodType:methodType
                                         methodSelector:selector
                                              hookRange:hookRange];
        [[MOAspectsStore sharedStore] setTarget:target forKey:key];
    }
    return target;
}

+ (BOOL)isSwiftClass:(Class)clazz
{
    return [[MOARuntime stringWithClass:clazz] componentsSeparatedByString:@"."].count > 1;
}

+ (BOOL)shouldInvokeTarget:(MOAspectsTarget *)target
                  toObject:(id)object
                  selector:(SEL)selector
{
    if (MOAspectsEqualHookRanges(target.hookRange, MOAspectsHookRangeSingle)) {
        return [object class] == [target classForSelector:selector];
    } else if (MOAspectsEqualHookRanges(target.hookRange, MOAspectsHookRangeAll)) {
        return YES;
    } else {
        NSAssert(NO, @"Not implemented custom hook range");
    }
    
    return NO;
}

#pragma mark Both interface

+ (Class)rootClassForResponodsToClass:(Class)clazz selector:(SEL)selector methodType:(MOAspectsTargetMethodType)methodType
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime rootClassForClassRespondsToClass:clazz selector:selector];
    } else {
        return [MOARuntime rootClassForInstanceRespondsToClass:clazz selector:selector];
    }
}

+ (BOOL)addMethodForClass:(Class)clazz
                 selector:(SEL)selector
               methodType:(MOAspectsTargetMethodType)methodType
                    block:(id)block
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime addClassMethodForClass:clazz selector:selector implementationBlock:block];
    } else {
        return [MOARuntime addInstanceMethodForClass:clazz selector:selector implementationBlock:block];
    }
}

+ (BOOL)hasMethodForClass:(Class)clazz selector:(SEL)selector methodType:(MOAspectsTargetMethodType)methodType
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime hasClassMethodForClass:clazz selector:selector];
    } else {
        return [MOARuntime hasInstanceMethodForClass:clazz selector:selector];
    }
}

+ (BOOL)copyMethodForClass:(Class)clazz
                atSelector:(SEL)selector
                toSelector:(SEL)copySelector
                methodType:(MOAspectsTargetMethodType)methodType
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime copyClassMethodForClass:clazz atSelector:selector toSelector:copySelector];
    } else {
        return [MOARuntime copyInstanceMethodForClass:clazz atSelector:selector toSelector:copySelector];
    }
}

+ (void)overwritingMethodForClass:(Class)clazz
                         selector:(SEL)selector
                       methodType:(MOAspectsTargetMethodType)methodType
              implementationBlock:(id)implementationBlock
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        [MOARuntime overwritingClassMethodForClass:clazz selector:selector implementationBlock:implementationBlock];
    } else {
        [MOARuntime overwritingInstanceMethodForClass:clazz selector:selector implementationBlock:implementationBlock];
    }
}

+ (void)overwritingMessageForwardMethodForClass:(Class)clazz
                                       selector:(SEL)selector
                                     methodType:(MOAspectsTargetMethodType)methodType
{
    if (methodType == MOAspectsTargetMethodTypeClass) {
        return [MOARuntime overwritingMessageForwardClassMethodForClass:clazz selector:selector];
    } else {
        return [MOARuntime overwritingMessageForwardInstanceMethodForClass:clazz selector:selector];
    }
}

@end
