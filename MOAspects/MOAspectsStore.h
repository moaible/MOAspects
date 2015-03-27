//
//  MOAspectsStore.h
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOAspectsTarget.h"

@interface MOAspectsStore : NSObject

+ (instancetype)sharedStore;

+ (NSString *)keyWithClass:(Class)clazz
                methodType:(MOAspectsTargetMethodType)methodType
                  selector:(SEL)selector
           aspectsSelector:(SEL)aspectsSelector;

- (void)setTarget:(MOAspectsTarget * )target forKey:(NSString *)key;

- (MOAspectsTarget *)targetForKey:(NSString *)key;

@end
