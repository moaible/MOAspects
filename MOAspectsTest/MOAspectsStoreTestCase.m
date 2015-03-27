//
//  MOAspectsStoreTestCase.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/03/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MOAspectsStore.h"

@interface MOAspectsStoreTestCase : XCTestCase

@end

@implementation MOAspectsStoreTestCase

- (void)testKeyForTarget
{
    // Class method
    {
        XCTAssertTrue([[MOAspectsStore keyWithClass:[NSString class]
                                          methodType:MOAspectsTargetMethodTypeClass
                                            selector:@selector(defaultCStringEncoding)]
                       isEqualToString:@"+[NSString defaultCStringEncoding]"]);
    }
    
    // Instance method
    {
        XCTAssertTrue([[MOAspectsStore keyWithClass:[NSString class]
                                          methodType:MOAspectsTargetMethodTypeInstance
                                            selector:@selector(length)]
                       isEqualToString:@"-[NSString length]"]);
    }
}

@end
