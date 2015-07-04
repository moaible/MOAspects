//
//  MOAspects.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015 MOAI. All rights reserved
//

#import <Foundation/Foundation.h>

#import "MOAspectsHookRange.h"

typedef NS_ENUM(NSInteger, MOAspectsPosition)
{
    MOAspectsPositionBefore,
    MOAspectsPositionAfter
};

@interface MOAspects : NSObject

#pragma mark - Hook instance method

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                        usingBlock:(id)block;

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                   aspectsPosition:(MOAspectsPosition)aspectsPosition
                         hookRange:(MOAspectsHookRange)hookRange
                        usingBlock:(id)block;

#pragma mark - Hook class method

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                     usingBlock:(id)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                aspectsPosition:(MOAspectsPosition)aspectsPosition
                      hookRange:(MOAspectsHookRange)hookRange
                     usingBlock:(id)block;

@end
