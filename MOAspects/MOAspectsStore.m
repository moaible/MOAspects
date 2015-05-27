//
//  MOAspectsStore.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import "MOAspectsStore.h"

@interface MOAspectsStore()

@property (nonatomic) NSMutableDictionary *targetStore;

@end

@implementation MOAspectsStore

NSString * const MOAspectsStoreKeyFormat = @"%@[%@ %@]";

+ (instancetype)sharedStore
{
    static MOAspectsStore *sharedStore;
    @synchronized(self) {
        if (!sharedStore) {
            sharedStore = [[MOAspectsStore alloc] init];
        }
    }
    return sharedStore;
}

- (NSMutableDictionary *)targetStore
{
    if (!_targetStore) {
        _targetStore = [@{} mutableCopy];
    }
    return _targetStore;
}

+ (NSString *)keyWithClass:(Class)clazz
                  selector:(SEL)selector
                methodType:(MOAspectsTargetMethodType)methodType
{
    return [NSString stringWithFormat:MOAspectsStoreKeyFormat,
            methodType == MOAspectsTargetMethodTypeClass ? @"+" : @"-",
            [NSString stringWithCString:object_getClassName(clazz) encoding:NSUTF8StringEncoding],
            NSStringFromSelector(selector)];
}

- (void)setTarget:(MOAspectsTarget *)target forKey:(NSString *)key
{
    [self.targetStore setValue:target forKey:key];
}

- (MOAspectsTarget *)targetForKey:(NSString *)key
{
    return [self.targetStore valueForKey:key];
}

@end
