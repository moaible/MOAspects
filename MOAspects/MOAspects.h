//
//  MOAspects.h
//  Sandbox
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MOAspectsHook)
{
    MOAspectsHookBefore,
    MOAspectsHookAfter
};

@interface MOAspects : NSObject

+ (BOOL)hookInstanceMethodInClass:(Class)clazz
                         selector:(SEL)selector
                      aspectsHook:(MOAspectsHook)aspectsHook
                       usingBlock:(id)block;

+ (BOOL)hookClassMethodInClass:(Class)clazz
                      selector:(SEL)selector
                   aspectsHook:(MOAspectsHook)aspectsHook
                    usingBlock:(id)block;

@end
