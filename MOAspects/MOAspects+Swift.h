//
//  MOAspects+Swift.h
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/06.
//  Copyright (c) 2015年 HiromiMotodera. All rights reserved.
//

#import "MOAspects.h"

typedef void (^MOAspectsNoParameterBlock) (void);
typedef void (^MOAspectsParameterBlock0) (id t);

@interface MOAspects (Swift)

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
                             range:(MOAspectsHookRange)range
             usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
                             range:(MOAspectsHookRange)range
              usingParameterBlock0:(MOAspectsParameterBlock0)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
                          range:(MOAspectsHookRange)range
          usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
                          range:(MOAspectsHookRange)range
           usingParameterBlock0:(MOAspectsParameterBlock0)block;

@end
