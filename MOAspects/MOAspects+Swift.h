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
typedef void (^MOAspectsParameterBlock1) (id t, void* p1);
typedef void (^MOAspectsParameterBlock2) (id t, void* p1, void* p2);
typedef void (^MOAspectsParameterBlock3) (id t, void* p1, void* p2, void* p3);
typedef void (^MOAspectsParameterBlock4) (id t, void* p1, void* p2, void* p3, void* p4);
typedef void (^MOAspectsParameterBlock5) (id t, void* p1, void* p2, void* p3, void* p4, void* p5);
typedef void (^MOAspectsParameterBlock6) (id t, void* p1, void* p2, void* p3, void* p4, void* p5, void* p6);
typedef void (^MOAspectsParameterBlock7) (id t, void* p1, void* p2, void* p3, void* p4, void* p5, void* p6, void* p7);
typedef void (^MOAspectsParameterBlock8) (id t, void* p1, void* p2, void* p3, void* p4, void* p5, void* p6, void* p7, void* p8);
typedef void (^MOAspectsParameterBlock9) (id t, void* p1, void* p2, void* p3, void* p4, void* p5, void* p6, void* p7, void* p8, void* p9);

@interface MOAspects (Swift)

+ (BOOL)moa_hookInstanceMethodForClass:(Class)clazz
                              selector:(SEL)selector
                       aspectsPosition:(MOAspectsPosition)aspectsPosition
                 usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
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
              usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
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
