//
//  MOAspectsTarget.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015 MOAI. All rights reserved
//

#import "MOAspectsTarget.h"

#import "MOARuntime.h"

@interface MOAspectsTarget ()

@property (nonatomic) NSMutableDictionary *selectorClassInfo;

@end

@implementation MOAspectsTarget

#pragma mark - Public

#pragma mark Initialize

- (instancetype)initWithClass:(Class)clazz
                    mehodType:(MOAspectsTargetMethodType)methodType
               methodSelector:(SEL)selector
                    hookRange:(MOAspectsHookRange)hookRange

{
    NSParameterAssert(clazz);
    NSParameterAssert(selector);
    
    self = [super init];
    if (self) {
        _class = clazz;
        _selector = selector;
        _methodType = methodType;
        _hookRange = hookRange;
    }
    return self;
}

#pragma mark Property

- (NSMutableArray *)beforeSelectors
{
    if (!_beforeSelectors) {
        _beforeSelectors = [@[] mutableCopy];
    }
    return _beforeSelectors;
}

- (NSMutableArray *)afterSelectors
{
    if (!_afterSelectors) {
        _afterSelectors = [@[] mutableCopy];
    }
    return _afterSelectors;
}

- (NSMutableDictionary *)selectorClassInfo
{
    if (!_selectorClassInfo) {
        _selectorClassInfo = [@{} mutableCopy];
    }
    return _selectorClassInfo;
}

#pragma mark Add selector

- (void)addBeforeSelector:(SEL)selector forClass:(Class)clazz
{
    NSValue *selectorValue = [NSValue valueWithPointer:selector];
    [self.beforeSelectors addObject:selectorValue];
    self.selectorClassInfo[NSStringFromSelector(selector)] = [MOARuntime stringWithClass:clazz];
}

- (void)addAfterSelector:(SEL)selector forClass:(Class)clazz
{
    NSValue *selectorValue = [NSValue valueWithPointer:selector];
    [self.afterSelectors addObject:selectorValue];
    self.selectorClassInfo[NSStringFromSelector(selector)] = [MOARuntime stringWithClass:clazz];
}

- (Class)classForSelector:(SEL)selector
{
    return NSClassFromString(self.selectorClassInfo[NSStringFromSelector(selector)]);
}

@end
