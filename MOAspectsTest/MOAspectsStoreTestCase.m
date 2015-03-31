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
                                            selector:@selector(defaultCStringEncoding)
                                         methodType:MOAspectsTargetMethodTypeClass]
                       isEqualToString:@"+[NSString defaultCStringEncoding]"]);
    }
    
    // Instance method
    {
        XCTAssertTrue([[MOAspectsStore keyWithClass:[NSString class]
                                            selector:@selector(length)
                                         methodType:MOAspectsTargetMethodTypeInstance]
                       isEqualToString:@"-[NSString length]"]);
    }
}

@end
