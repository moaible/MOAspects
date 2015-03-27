//
//  MOARuntime.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/02/12.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOARuntime : NSObject

+ (NSArray *)classNames;

+ (NSArray *)classNamesForRegexPattern:(NSString *)pattern;

+ (Class)metaClassWithClass:(Class)clazz;

+ (NSArray *)propertyNamesWithClass:(Class)clazz;

+ (NSArray *)propertyNamesWithClass:(Class)clazz depth:(BOOL)depth;

+ (NSArray *)propertyNamesWithClass:(Class)clazz depthForClass:(Class)depthClazz;

+ (const char *)objcTypeEncodingWithClass:(Class)clazz
                      classMethodSelector:(SEL)classMethodSelector;

+ (const char *)objcTypeEncodingWithClass:(Class)clazz
                   instanceMethodSelector:(SEL)instanceMethodSelector;

+ (const char *)objcTypeEncodingWithBlock:(id)block;

+ (BOOL)hasPropertyName:(NSString *)name atClass:(Class)clazz;

+ (BOOL)hasInstanceMethodInClass:(Class)clazz selector:(SEL)selector;

+ (Class)rootClassForInstanceRespondsToClass:(Class)clazz selector:(SEL)selector;

+ (Class)rootClassForClassRespondsToClass:(Class)clazz selector:(SEL)selector;

+ (BOOL)hasClassMethodInClass:(Class)clazz selector:(SEL)selector;

+ (SEL)selectorWithSelector:(SEL)selector prefix:(NSString *)prefix;

+ (BOOL)selector:(SEL)leftSelector isEqualToSelector:(SEL)rightSelector;

+ (NSMethodSignature *)classMethodSignatureWithClass:(Class)clazz selector:(SEL)selector;

+ (NSMethodSignature *)instanceMethodSignatureWithClass:(Class)clazz selector:(SEL)selector;

+ (void)exchangeImplementationsWithClass:(Class)clazz
              fromInstanceMethodSelector:(SEL)fromSEL
                toInstanceMethodSelector:(SEL)toSEL;

+ (void)exchangeImplementationsWithClass:(Class)clazz
                 fromClassMethodSelector:(SEL)fromSEL
                   toClassMethodSelector:(SEL)toSEL;

+ (void)overwritingClassMethodInClass:(Class)clazz
                             selector:(SEL)selector
                  implementationBlock:(id)implementationBlock;

+ (void)overwritingInstanceMethodInClass:(Class)clazz
                                selector:(SEL)selector
                     implementationBlock:(id)implementationBlock;

+ (void)overwritingMessageForwardInstanceMethodInClass:(Class)clazz
                                              selector:(SEL)selector;

+ (void)overwritingMessageForwardClassMethodInClass:(Class)clazz
                                           selector:(SEL)selector;

+ (BOOL)addInstanceMethodInClass:(Class)clazz
                        selector:(SEL)selector
             implementationBlock:(id)implementationBlock;

+ (BOOL)addClassMethodInClass:(Class)clazz
                     selector:(SEL)selector
          implementationBlock:(id)implementationBlock;

+ (BOOL)copyInstanceMethodInClass:(Class)clazz
                       atSelector:(SEL)selector
                       toSelector:(SEL)copySelector;

+ (BOOL)copyClassMethodInClass:(Class)clazz
                    atSelector:(SEL)selector
                    toSelector:(SEL)copySelector;

@end
