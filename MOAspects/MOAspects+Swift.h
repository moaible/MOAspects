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

+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
             usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock0:(MOAspectsParameterBlock0)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock1:(MOAspectsParameterBlock1)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock2:(MOAspectsParameterBlock2)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock3:(MOAspectsParameterBlock3)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock4:(MOAspectsParameterBlock4)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock5:(MOAspectsParameterBlock5)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock6:(MOAspectsParameterBlock6)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock7:(MOAspectsParameterBlock7)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock8:(MOAspectsParameterBlock8)block;
+ (BOOL)hookInstanceMethodForClass:(Class)clazz
                          selector:(SEL)selector
                          position:(MOAspectsPosition)position
              usingParameterBlock9:(MOAspectsParameterBlock9)block;

+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
          usingNoParameterBlock:(MOAspectsNoParameterBlock)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock0:(MOAspectsParameterBlock0)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock1:(MOAspectsParameterBlock1)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock2:(MOAspectsParameterBlock2)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock3:(MOAspectsParameterBlock3)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock4:(MOAspectsParameterBlock4)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock5:(MOAspectsParameterBlock5)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock6:(MOAspectsParameterBlock6)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock7:(MOAspectsParameterBlock7)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock8:(MOAspectsParameterBlock8)block;
+ (BOOL)hookClassMethodForClass:(Class)clazz
                       selector:(SEL)selector
                       position:(MOAspectsPosition)position
           usingParameterBlock9:(MOAspectsParameterBlock9)block;

@end
