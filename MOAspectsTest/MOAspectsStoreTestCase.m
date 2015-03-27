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
        SEL aspectsSelector = NSSelectorFromString([NSString stringWithFormat:@"moa_testcase_%@",
                                                    @"defaultCStringEncoding"]);
        XCTAssertTrue([[MOAspectsStore keyWithClass:[NSString class]
                                          methodType:MOAspectsTargetMethodTypeClass
                                            selector:@selector(defaultCStringEncoding)
                                     aspectsSelector:aspectsSelector]
                       isEqualToString:@"+[NSString defaultCStringEncoding(moa_testcase_defaultCStringEncoding)]"]);
    }
    
    // Instance method
    {
        SEL aspectsSelector = NSSelectorFromString([NSString stringWithFormat:@"moa_testcase_%@",
                                                    @"length"]);
        XCTAssertTrue([[MOAspectsStore keyWithClass:[NSString class]
                                          methodType:MOAspectsTargetMethodTypeInstance
                                            selector:@selector(length)
                                     aspectsSelector:aspectsSelector]
                       isEqualToString:@"-[NSString length(moa_testcase_length)]"]);
    }
}

@end
