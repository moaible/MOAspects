//
//  MOAspectsTarget.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015 MOAI. All rights reserved
//

#import <Foundation/Foundation.h>

#import "MOAspectsHookRange.h"

typedef NS_ENUM(NSInteger, MOAspectsTargetMethodType)
{
    MOAspectsTargetMethodTypeClass,
    MOAspectsTargetMethodTypeInstance
};

@interface MOAspectsTarget : NSObject

@property (nonatomic, readonly) Class class;

@property (nonatomic, readonly) SEL selector;

@property (nonatomic, readonly) MOAspectsTargetMethodType methodType;

@property (nonatomic, readonly) MOAspectsHookRange hookRange;

@property (nonatomic) NSMutableArray *beforeSelectors; // NSValue array

@property (nonatomic) NSMutableArray *afterSelectors; // NSValue array

- (instancetype)initWithClass:(Class)clazz
                    mehodType:(MOAspectsTargetMethodType)methodType
               methodSelector:(SEL)selector
                    hookRange:(MOAspectsHookRange)hookRange;

- (void)addBeforeSelector:(SEL)selector forClass:(Class)clazz;

- (void)addAfterSelector:(SEL)selector forClass:(Class)clazz;

- (Class)classForSelector:(SEL)selector;

@end
