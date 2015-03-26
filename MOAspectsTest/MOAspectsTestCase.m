//
//  MOAspectsTestCase.m
//  Sandbox
//
//  Created by Hiromi Motodera on 2015/03/23.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MOAspects.h"

@interface MOAspectsTestObject : NSObject
+ (NSString *)stringWithBOOL:(BOOL)BOOLVar;
- (NSString *)stringWithBOOL:(BOOL)BOOLVar;
@end

@implementation MOAspectsTestObject

#pragma mark - Class methods

+ (NSString *)stringWithBOOL:(BOOL)BOOLVar
{
    return BOOLVar ? @"YES" : @"NO";
}

+ (NSString *)stringWithInt:(int)intVar
{
    return @(intVar).stringValue;
}

+ (NSString *)stringWithPoint:(CGPoint)pointVar
{
    return NSStringFromCGPoint(pointVar);
}

+ (NSString *)stringWithSize:(CGSize)sizeVar
{
    return NSStringFromCGSize(sizeVar);
}

+ (NSString *)stringWithRect:(CGRect)rectVar
{
    return NSStringFromCGRect(rectVar);
}

+ (NSString *)stringWithString:(NSString *)string
{
    return string;
}

#pragma mark - Instance methods

- (NSString *)stringWithBOOL:(BOOL)BOOLVar
{
    return BOOLVar ? @"YES" : @"NO";
}

- (NSString *)stringWithInt:(int)intVar
{
    return @(intVar).stringValue;
}

- (NSString *)stringWithPoint:(CGPoint)pointVar
{
    return NSStringFromCGPoint(pointVar);
}

- (NSString *)stringWithSize:(CGSize)sizeVar
{
    return NSStringFromCGSize(sizeVar);
}

- (NSString *)stringWithRect:(CGRect)rectVar
{
    return NSStringFromCGRect(rectVar);
}

- (NSString *)stringWithString:(NSString *)string
{
    return string;
}

@end

@interface MOAspectsTestChildObject : MOAspectsTestObject

@end

@implementation MOAspectsTestChildObject

+ (NSString *)stringWithBOOL:(BOOL)BOOLVar
{
    return BOOLVar ? @"真" : @"偽";
}

- (NSString *)stringWithBOOL:(BOOL)BOOLVar
{
    return BOOLVar ? @"真" : @"偽";
}

@end

@interface MOAspectsTestCase : XCTestCase

@end

@implementation MOAspectsTestCase

#pragma mark - Class methods parameter hook test case

- (void)testStringWithBOOLAtClassMethod
{
    NSString *string;
    string = [MOAspectsTestObject stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"YES"]);
    string = [MOAspectsTestObject stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"NO"]);
    
    __block NSString *hookedString;
    [MOAspects hookClassMethodInClass:[MOAspectsTestObject class]
                              selector:@selector(stringWithBOOL:)
                           aspectsHook:MOAspectsHookBefore
                            usingBlock:^(id target, BOOL BOOLVar){
                                hookedString = BOOLVar ? @"YES" : @"NO";
                            }];
    string = [MOAspectsTestObject stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"YES"]);
    XCTAssertTrue([hookedString isEqualToString:@"YES"]);
    string = [MOAspectsTestObject stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"NO"]);
    XCTAssertTrue([hookedString isEqualToString:@"NO"]);
}

- (void)testStringWithIntAtClassMethod
{
    NSString *string;
    string = [MOAspectsTestObject stringWithInt:0];
    XCTAssertTrue([string isEqualToString:@"0"]);
    string = [MOAspectsTestObject stringWithInt:-100];
    XCTAssertTrue([string isEqualToString:@"-100"]);
    string = [MOAspectsTestObject stringWithInt:200];
    XCTAssertTrue([string isEqualToString:@"200"]);
    
    __block NSString *hookedString;
    [MOAspects hookClassMethodInClass:[MOAspectsTestObject class]
                              selector:@selector(stringWithInt:)
                           aspectsHook:MOAspectsHookBefore
                            usingBlock:^(id target, int intVar){
                                hookedString = @(intVar).stringValue;
                            }];
    string = [MOAspectsTestObject stringWithInt:0];
    XCTAssertTrue([string isEqualToString:@"0"]);
    XCTAssertTrue([hookedString isEqualToString:@"0"]);
    string = [MOAspectsTestObject stringWithInt:-100];
    XCTAssertTrue([string isEqualToString:@"-100"]);
    XCTAssertTrue([hookedString isEqualToString:@"-100"]);
    string = [MOAspectsTestObject stringWithInt:200];
    XCTAssertTrue([string isEqualToString:@"200"]);
    XCTAssertTrue([hookedString isEqualToString:@"200"]);
}

- (void)testStringWithPointAtClassMethod
{
    NSString *string;
    string = [MOAspectsTestObject stringWithPoint:CGPointZero];
    XCTAssertTrue([string isEqualToString:@"{0, 0}"]);
    string = [MOAspectsTestObject stringWithPoint:CGPointMake(100, 200)];
    XCTAssertTrue([string isEqualToString:@"{100, 200}"]);
    
    __block NSString *hookedString;
    [MOAspects hookClassMethodInClass:[MOAspectsTestObject class]
                              selector:@selector(stringWithPoint:)
                           aspectsHook:MOAspectsHookBefore
                            usingBlock:^(id target, CGPoint pointVar){
                                hookedString = NSStringFromCGPoint(pointVar);
                            }];
    string = [MOAspectsTestObject stringWithPoint:CGPointZero];
    XCTAssertTrue([string isEqualToString:@"{0, 0}"]);
    XCTAssertTrue([hookedString isEqualToString:@"{0, 0}"]);
    string = [MOAspectsTestObject stringWithPoint:CGPointMake(100, 200)];
    XCTAssertTrue([string isEqualToString:@"{100, 200}"]);
    XCTAssertTrue([hookedString isEqualToString:@"{100, 200}"]);
}

#pragma mark - Instance methods parameter hook test case

- (void)testStringWithBOOLAtInstanceMethod
{
    MOAspectsTestObject *object = [[MOAspectsTestObject alloc] init];
    
    NSString *string;
    string = [object stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"YES"]);
    string = [object stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"NO"]);
    
    __block NSString *hookedString;
    [MOAspects hookInstanceMethodInClass:[MOAspectsTestObject class]
                                 selector:@selector(stringWithBOOL:)
                              aspectsHook:MOAspectsHookBefore
                               usingBlock:^(id target, BOOL BOOLVar){
                                   hookedString = BOOLVar ? @"YES" : @"NO";
                               }];
    string = [object stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"YES"]);
    XCTAssertTrue([hookedString isEqualToString:@"YES"]);
    string = [object stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"NO"]);
    XCTAssertTrue([hookedString isEqualToString:@"NO"]);
}

- (void)testStringWithIntAtInstanceMethod
{
    MOAspectsTestObject *object = [[MOAspectsTestObject alloc] init];
    
    NSString *string;
    string = [object stringWithInt:0];
    XCTAssertTrue([string isEqualToString:@"0"]);
    string = [object stringWithInt:-100];
    XCTAssertTrue([string isEqualToString:@"-100"]);
    string = [object stringWithInt:200];
    XCTAssertTrue([string isEqualToString:@"200"]);
    
    __block NSString *hookedString;
    [MOAspects hookInstanceMethodInClass:[MOAspectsTestObject class]
                                 selector:@selector(stringWithInt:)
                              aspectsHook:MOAspectsHookBefore
                               usingBlock:^(id target, int intVar){
                                   hookedString = @(intVar).stringValue;
                               }];
    string = [object stringWithInt:0];
    XCTAssertTrue([string isEqualToString:@"0"]);
    XCTAssertTrue([hookedString isEqualToString:@"0"]);
    string = [object stringWithInt:-100];
    XCTAssertTrue([string isEqualToString:@"-100"]);
    XCTAssertTrue([hookedString isEqualToString:@"-100"]);
    string = [object stringWithInt:200];
    XCTAssertTrue([string isEqualToString:@"200"]);
    XCTAssertTrue([hookedString isEqualToString:@"200"]);
}

- (void)testStringWithPointAtInstanceMethod
{
    MOAspectsTestObject *object = [[MOAspectsTestObject alloc] init];
    
    NSString *string;
    string = [object stringWithPoint:CGPointZero];
    XCTAssertTrue([string isEqualToString:@"{0, 0}"]);
    string = [object stringWithPoint:CGPointMake(100, 200)];
    XCTAssertTrue([string isEqualToString:@"{100, 200}"]);
    
    __block NSString *hookedString;
    [MOAspects hookInstanceMethodInClass:[MOAspectsTestObject class]
                                 selector:@selector(stringWithPoint:)
                              aspectsHook:MOAspectsHookBefore
                               usingBlock:^(id target, CGPoint pointVar){
                                   hookedString = NSStringFromCGPoint(pointVar);
                               }];
    string = [object stringWithPoint:CGPointZero];
    XCTAssertTrue([string isEqualToString:@"{0, 0}"]);
    XCTAssertTrue([hookedString isEqualToString:@"{0, 0}"]);
    string = [object stringWithPoint:CGPointMake(100, 200)];
    XCTAssertTrue([string isEqualToString:@"{100, 200}"]);
    XCTAssertTrue([hookedString isEqualToString:@"{100, 200}"]);
}

#pragma makr - Child class test case

- (void)testChild
{
    NSString *string;
    string = [MOAspectsTestChildObject stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"真"]);
    string = [MOAspectsTestChildObject stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"偽"]);
    
    __block NSString *hookedString;
    [MOAspects hookClassMethodInClass:[MOAspectsTestChildObject class]
                              selector:@selector(stringWithBOOL:)
                           aspectsHook:MOAspectsHookBefore
                            usingBlock:^(id target, BOOL BOOLVar){
                                hookedString = BOOLVar ? @"真" : @"偽";
                            }];
    string = [MOAspectsTestChildObject stringWithBOOL:YES];
    XCTAssertTrue([string isEqualToString:@"真"]);
    XCTAssertTrue([hookedString isEqualToString:@"真"]);
    string = [MOAspectsTestChildObject stringWithBOOL:NO];
    XCTAssertTrue([string isEqualToString:@"偽"]);
    XCTAssertTrue([hookedString isEqualToString:@"偽"]);
}

@end
