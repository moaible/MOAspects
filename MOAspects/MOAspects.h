//
//  MOAspects.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MOAspectsPosition)
{
    MOAspectsPositionBefore,
    MOAspectsPositionAfter
};

typedef NS_ENUM(NSInteger, MOAspectsHookRange)
{
    MOAspectsHookRangeAll = -1,
    MOAspectsHookRangeTargetOnly = -2
};

@interface MOAspects : NSObject

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                        usingBlock:(id)block;

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                         hookLevel:(MOAspectsHookRange)hookRange
                        usingBlock:(id)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                      hookLevel:(MOAspectsHookRange)hookRange
                     usingBlock:(id)block;

@end
