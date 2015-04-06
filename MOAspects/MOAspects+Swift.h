//
//  MOAspects+Swift.h
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/04/06.
//  Copyright (c) 2015年 HiromiMotodera. All rights reserved.
//

#import "MOAspects.h"

typedef void (^MOAspectsParameterBlock0) (id t);
typedef void (^MOAspectsParameterBlock1) (id t, id p1);
typedef void (^MOAspectsParameterBlock2) (id t, id p1, id p2);
typedef void (^MOAspectsParameterBlock3) (id t, id p1, id p2, id p3);
typedef void (^MOAspectsParameterBlock4) (id t, id p1, id p2, id p3, id p4);
typedef void (^MOAspectsParameterBlock5) (id t, id p1, id p2, id p3, id p4, id p5);
typedef void (^MOAspectsParameterBlock6) (id t, id p1, id p2, id p3, id p4, id p5, id p6);
typedef void (^MOAspectsParameterBlock7) (id t, id p1, id p2, id p3, id p4, id p5, id p6, id p7);
typedef void (^MOAspectsParameterBlock8) (id t, id p1, id p2, id p3, id p4, id p5, id p6, id p7, id p8);
typedef void (^MOAspectsParameterBlock9) (id t, id p1, id p2, id p3, id p4, id p5, id p6, id p7, id p8, id p9);

@interface MOAspects (Swift)

+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock0:(MOAspectsParameterBlock0)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock1:(MOAspectsParameterBlock1)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock2:(MOAspectsParameterBlock2)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock3:(MOAspectsParameterBlock3)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock4:(MOAspectsParameterBlock4)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock5:(MOAspectsParameterBlock5)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock6:(MOAspectsParameterBlock6)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock7:(MOAspectsParameterBlock7)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock8:(MOAspectsParameterBlock8)block;
+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                  usingParameterBlock9:(MOAspectsParameterBlock9)block;

+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock0:(MOAspectsParameterBlock0)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock1:(MOAspectsParameterBlock1)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock2:(MOAspectsParameterBlock2)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock3:(MOAspectsParameterBlock3)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock4:(MOAspectsParameterBlock4)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock5:(MOAspectsParameterBlock5)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock6:(MOAspectsParameterBlock6)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock7:(MOAspectsParameterBlock7)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock8:(MOAspectsParameterBlock8)block;
+ (BOOL)moa_hookClassMethodForClass:(Class)clazz
                           selector:(SEL)selector
                    aspectsPosition:(MOAspectsPosition)aspectsPosition
               usingParameterBlock9:(MOAspectsParameterBlock9)block;

@end
