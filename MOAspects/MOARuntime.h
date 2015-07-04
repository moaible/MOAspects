//
//  MOARuntime.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/02/12.
//  Copyright (c) 2015 MOAI. All rights reserved
//

#import <Foundation/Foundation.h>

@interface MOARuntime : NSObject

+ (NSString *)stringWithClass:(Class)clazz;

+ (Class)classWithString:(NSString *)string;

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

+ (BOOL)hasInstanceMethodForClass:(Class)clazz selector:(SEL)selector;

+ (BOOL)hasClassMethodForClass:(Class)clazz selector:(SEL)selector;

+ (Class)rootClassForInstanceRespondsToClass:(Class)clazz selector:(SEL)selector;

+ (Class)rootClassForClassRespondsToClass:(Class)clazz selector:(SEL)selector;

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

+ (void)overwritingClassMethodForClass:(Class)clazz
                              selector:(SEL)selector
                   implementationBlock:(id)implementationBlock;

+ (void)overwritingInstanceMethodForClass:(Class)clazz
                                 selector:(SEL)selector
                      implementationBlock:(id)implementationBlock;

+ (void)overwritingMessageForwardInstanceMethodForClass:(Class)clazz
                                               selector:(SEL)selector;

+ (void)overwritingMessageForwardClassMethodForClass:(Class)clazz
                                            selector:(SEL)selector;

+ (BOOL)addInstanceMethodForClass:(Class)clazz
                         selector:(SEL)selector
              implementationBlock:(id)implementationBlock;

+ (BOOL)addClassMethodForClass:(Class)clazz
                      selector:(SEL)selector
           implementationBlock:(id)implementationBlock;

+ (BOOL)copyInstanceMethodForClass:(Class)clazz
                        atSelector:(SEL)selector
                        toSelector:(SEL)copySelector;

+ (BOOL)copyClassMethodForClass:(Class)clazz
                     atSelector:(SEL)selector
                     toSelector:(SEL)copySelector;

@end
