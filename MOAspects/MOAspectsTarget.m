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

{
    NSParameterAssert(clazz);
    NSParameterAssert(selector);
    
    self = [super init];
    if (self) {
        _class = clazz;
        _selector = selector;
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
    self.selectorClassInfo[NSStringFromSelector(selector)] = [NSString stringWithCString:object_getClassName(clazz) encoding:NSUTF8StringEncoding];
}

- (void)addAfterSelector:(SEL)selector forClass:(Class)clazz
{
    NSValue *selectorValue = [NSValue valueWithPointer:selector];
    [self.afterSelectors addObject:selectorValue];
    self.selectorClassInfo[NSStringFromSelector(selector)] = [NSString stringWithCString:object_getClassName(clazz) encoding:NSUTF8StringEncoding];
}

- (Class)classForSelector:(SEL)selector
{
    NSString *className = self.selectorClassInfo[NSStringFromSelector(selector)];
    return objc_getClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
