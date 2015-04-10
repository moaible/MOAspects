//
//  MOAspects+Swift.m
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/06.
//  Copyright (c) 2015年 HiromiMotodera. All rights reserved.
//

#import "MOAspects+Swift.h"

@implementation MOAspects (Swift)

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
             usingNoParameterBlock:(MOAspectsNoParameterBlock)block
{
    return [self hookInstanceMethodForClass:clazz selector:selector aspectsPosition:position usingBlock:(id)block];;
}

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock0:(MOAspectsParameterBlock0)block
{
    return [self hookInstanceMethodForClass:clazz selector:selector aspectsPosition:position usingBlock:(id)block];
}

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
          usingNoParameterBlock:(MOAspectsNoParameterBlock)block
{
    return [self hookClassMethodForClass:clazz selector:selector aspectsPosition:position usingBlock:(id)block];
}

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock0:(MOAspectsParameterBlock0)block
{
    return [self hookClassMethodForClass:clazz selector:selector aspectsPosition:position usingBlock:(id)block];
}

@end
