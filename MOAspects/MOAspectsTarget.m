//
//  MOAspectsTarget.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
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
              aspectsSelector:(SEL)aspectsSelector

{
    NSParameterAssert(clazz);
    NSParameterAssert(selector);
    NSParameterAssert(aspectsSelector);
    
    self = [super init];
    if (self) {
        _class = clazz;
        _selector = selector;
        _aspectsSelector = aspectsSelector;
        _methodType = methodType;
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
    self.selectorClassInfo[NSStringFromSelector(selector)] = NSStringFromClass(clazz);
}

- (void)addAfterSelector:(SEL)selector forClass:(Class)clazz
{
    NSValue *selectorValue = [NSValue valueWithPointer:selector];
    [self.afterSelectors addObject:selectorValue];
    self.selectorClassInfo[NSStringFromSelector(selector)] = NSStringFromClass(clazz);
}

- (Class)classForSelector:(SEL)selector
{
    return NSClassFromString(self.selectorClassInfo[NSStringFromSelector(selector)]);
}

#pragma mark - Private

@end
