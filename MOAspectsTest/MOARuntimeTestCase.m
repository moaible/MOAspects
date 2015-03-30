//
//  MOARuntimeTestCase.m
//  MOAspects
//
//  Created by Hiromi Motodera on 2015/02/15.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MOARuntime.h"

@interface MOARuntimeTestObject : NSObject

@property (nonatomic) NSString *testProperty1;

@property (nonatomic) NSString *testProperty2;

@end

@implementation MOARuntimeTestObject

- (NSInteger)oneValue
{
    return 1;
}

- (NSInteger)twoValue
{
    return 2;
}

+ (NSInteger)oneValue
{
    return 1;
}

+ (NSInteger)twoValue
{
    return 2;
}

- (NSInteger)calcA:(NSInteger)A toB:(NSInteger)B
{
    return A + B;
}

+ (void)forwardTargetMethod
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)forwardTargetMethod
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end

@interface MOARuntimeTestObject2 : MOARuntimeTestObject
@end
@implementation MOARuntimeTestObject2
@end


@interface MOARuntimeTestCase : XCTestCase

@end

@implementation MOARuntimeTestCase

- (void)testClassNames
{
    BOOL ret = YES;
    NSArray *classNames = [MOARuntime classNames];
    for (NSString *className in classNames) {
        Class clazz = NSClassFromString(className);
        if (!clazz) {
            ret = NO;
            break;
        }
    }
    
    XCTAssertTrue(ret);
    XCTAssertTrue(classNames.count > 1000);
}

- (void)testClassNamesForRegexPattern
{
    NSArray *classNames = [MOARuntime classNamesForRegexPattern:@"^UI"];
    BOOL ret = YES;
    for (NSString *className in classNames) {
        if (![className hasPrefix:@"UI"]) {
            ret = NO;
            break;
        }
    }
    
    XCTAssertTrue(ret);
}

- (void)testExchangeImplementationsInstanceMethod
{
    MOARuntimeTestObject *object = [[MOARuntimeTestObject alloc] init];
    XCTAssertTrue([object oneValue] == 1 && [object twoValue] == 2);
    
    [MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                      fromInstanceMethodSelector:@selector(oneValue)
                        toInstanceMethodSelector:@selector(twoValue)];
    
    XCTAssertTrue([object oneValue] == 2 && [object twoValue] == 1);
    
    [MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                      fromInstanceMethodSelector:@selector(oneValue)
                        toInstanceMethodSelector:@selector(twoValue)];
    
    XCTAssertTrue([object oneValue] == 1 && [object twoValue] == 2);
}

- (void)testCatchAssertionExchangeImplementationsInstanceMethod
{
    XCTAssertThrows([MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                                      fromInstanceMethodSelector:@selector(oneValue)
                                        toInstanceMethodSelector:NSSelectorFromString(@"threeValue")]);
}

- (void)testExchangeImplementationsClassMethod
{
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 1 && [MOARuntimeTestObject twoValue] == 2);
    
    [MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                         fromClassMethodSelector:@selector(oneValue)
                           toClassMethodSelector:@selector(twoValue)];
    
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 2 && [MOARuntimeTestObject twoValue] == 1);
    
    [MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                         fromClassMethodSelector:@selector(oneValue)
                           toClassMethodSelector:@selector(twoValue)];
    
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 1 && [MOARuntimeTestObject twoValue] == 2);
}

- (void)testCatchAssertionExchangeImplementationsClassMethod
{
    XCTAssertThrows([MOARuntime exchangeImplementationsWithClass:[MOARuntimeTestObject class]
                                         fromClassMethodSelector:@selector(oneValue)
                                           toClassMethodSelector:NSSelectorFromString(@"threeValue")]);
}

- (void)testObjcEncoding
{
    const char *objcEncoding = [MOARuntime objcTypeEncodingWithClass:[MOARuntimeTestObject class]
                                              instanceMethodSelector:@selector(calcA:toB:)];
    NSMethodSignature *signature = [NSMethodSignature
                                    signatureWithObjCTypes:objcEncoding];
    NSString *returnType = [NSString stringWithCString:signature.methodReturnType encoding:NSUTF8StringEncoding];
    
    const char *objcEncoding2 = [MOARuntime objcTypeEncodingWithBlock:^(NSInteger a1, NSInteger a2){
        return a1+a2;
    }];
    NSMethodSignature *signature2 = [NSMethodSignature signatureWithObjCTypes:objcEncoding2];
    NSString *returnType2 = [NSString stringWithCString:signature2.methodReturnType encoding:NSUTF8StringEncoding];
    
    XCTAssertTrue([returnType isEqualToString:returnType2]);
    XCTAssertTrue(strcmp([signature getArgumentTypeAtIndex:2], [signature2 getArgumentTypeAtIndex:1]) == 0);
    XCTAssertTrue(strcmp([signature getArgumentTypeAtIndex:3], [signature2 getArgumentTypeAtIndex:2]) == 0);
}

- (void)testPropertyNames
{
    NSSet *propertyNameSet1 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:[MOARuntimeTestObject class]]];
    NSSet *propertyNameSet2 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:[MOARuntimeTestObject2 class]]];
    NSSet *propertyNameSetForTest = [NSSet setWithArray:@[@"testProperty1", @"testProperty2"]];
    
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet1]);
    XCTAssertFalse([propertyNameSetForTest isSubsetOfSet:propertyNameSet2]);
}

- (void)testPropertyNamesDepthNO
{
    NSSet *propertyNameSet1 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject class] depth:NO]];
    NSSet *propertyNameSet2 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject2 class] depth:NO]];
    NSSet *propertyNameSetForTest = [NSSet setWithArray:@[@"testProperty1", @"testProperty2"]];
    
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet1]);
    XCTAssertFalse([propertyNameSetForTest isSubsetOfSet:propertyNameSet2]);
}

- (void)testPropertyNamesDepthYES
{
    NSSet *propertyNameSet1 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject class] depth:YES]];
    NSSet *propertyNameSet2 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject2 class] depth:YES]];
    NSSet *propertyNameSetForTest = [NSSet setWithArray:@[@"testProperty1", @"testProperty2"]];
    
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet1]);
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet2]);
}

- (void)testPropertyNamesDepthForNSObject
{
    NSSet *propertyNameSet1 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject class] depthForClass:[NSObject class]]];
    NSSet *propertyNameSet2 = [NSSet setWithArray:[MOARuntime propertyNamesWithClass:
                                                   [MOARuntimeTestObject2 class] depthForClass:[NSObject class]]];
    NSSet *propertyNameSetForTest = [NSSet setWithArray:@[@"testProperty1", @"testProperty2"]];
    
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet1]);
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet2]);
}

- (void)testPropertyNamesDepthForMOARuntimeTestObject
{
    NSSet *propertyNameSet1 = [NSSet setWithArray:
                               [MOARuntime propertyNamesWithClass:[MOARuntimeTestObject class]
                                                    depthForClass:[MOARuntimeTestObject class]]];
    NSSet *propertyNameSet2 = [NSSet setWithArray:
                               [MOARuntime propertyNamesWithClass:[MOARuntimeTestObject2 class]
                                                    depthForClass:[MOARuntimeTestObject class]]];
    NSSet *propertyNameSetForTest = [NSSet setWithArray:@[@"testProperty1", @"testProperty2"]];
    
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet1]);
    XCTAssertTrue([propertyNameSetForTest isSubsetOfSet:propertyNameSet2]);
}

- (void)testHasPropertyNameAtClass
{
    XCTAssertTrue([MOARuntime hasPropertyName:@"testProperty1"
                                      atClass:[MOARuntimeTestObject class]]);
    XCTAssertFalse([MOARuntime hasPropertyName:@"testProperty3"
                                       atClass:[MOARuntimeTestObject class]]);
}

- (void)testSelectorWithSelectorPrefix
{
    SEL moaSelector = [MOARuntime selectorWithSelector:@selector(oneValue) prefix:@"moa_"];
    XCTAssertTrue([MOARuntime selector:NSSelectorFromString(@"moa_oneValue") isEqualToSelector:moaSelector]);
    XCTAssertFalse([MOARuntime selector:@selector(oneValue) isEqualToSelector:moaSelector]);
}

- (void)testSelectorIsEqualToSelector
{
    XCTAssertTrue([MOARuntime selector:@selector(oneValue) isEqualToSelector:@selector(oneValue)]);
    XCTAssertFalse([MOARuntime selector:@selector(oneValue) isEqualToSelector:@selector(twoValue)]);
    XCTAssertTrue([MOARuntime selector:nil isEqualToSelector:nil]);
}

- (void)testhasInstanceMethodForClassAndSelector
{
    XCTAssertTrue([MOARuntime hasInstanceMethodForClass:[MOARuntimeTestObject class]
                                               selector:@selector(oneValue)]);
    XCTAssertFalse([MOARuntime hasInstanceMethodForClass:[MOARuntimeTestObject class]
                                                selector:NSSelectorFromString(@"threeValue")]);
    XCTAssertTrue([MOARuntime hasInstanceMethodForClass:[MOARuntimeTestObject2 class]
                                               selector:@selector(oneValue)]);
}

- (void)testhasClassMethodForClassAndSelector
{
    XCTAssertTrue([MOARuntime hasClassMethodForClass:[MOARuntimeTestObject class]
                                            selector:@selector(oneValue)]);
    XCTAssertFalse([MOARuntime hasClassMethodForClass:[MOARuntimeTestObject class]
                                             selector:NSSelectorFromString(@"threeValue")]);
    XCTAssertTrue([MOARuntime hasClassMethodForClass:[MOARuntimeTestObject2 class]
                                            selector:@selector(oneValue)]);
}

- (void)testOverwritingClassMethod
{
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 1);
    XCTAssertTrue([[[MOARuntimeTestObject alloc] init] oneValue] == 1);
    [MOARuntime overwritingClassMethodForClass:[MOARuntimeTestObject class]
                                      selector:@selector(oneValue)
                           implementationBlock:^{
                               return 3;
                           }];
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 3);
    XCTAssertFalse([[[MOARuntimeTestObject alloc] init] oneValue] == 3);
    [MOARuntime overwritingClassMethodForClass:[MOARuntimeTestObject class]
                                      selector:@selector(oneValue)
                           implementationBlock:^{
                               return 1;
                           }];
    XCTAssertTrue([MOARuntimeTestObject oneValue] == 1);
    XCTAssertTrue([[[MOARuntimeTestObject alloc] init] oneValue] == 1);
}

- (void)testOverwritingInstanceMethod
{
    XCTAssertTrue([[[MOARuntimeTestObject alloc] init] twoValue] == 2);
    XCTAssertTrue([MOARuntimeTestObject twoValue] == 2);
    [MOARuntime overwritingInstanceMethodForClass:[MOARuntimeTestObject class]
                                         selector:@selector(twoValue)
                              implementationBlock:^{
                                  return 4;
                              }];
    XCTAssertTrue([[[MOARuntimeTestObject alloc] init] twoValue] == 4);
    XCTAssertFalse([MOARuntimeTestObject twoValue] == 4);
    [MOARuntime overwritingInstanceMethodForClass:[MOARuntimeTestObject class]
                                         selector:@selector(twoValue)
                              implementationBlock:^{
                                  return 2;
                              }];
    XCTAssertTrue([[[MOARuntimeTestObject alloc] init] twoValue] == 2);
    XCTAssertTrue([MOARuntimeTestObject twoValue] == 2);
}

- (void)testOverwritingMsgForwardClassMethod
{
    [MOARuntimeTestObject forwardTargetMethod];
    [MOARuntime overwritingMessageForwardClassMethodForClass:[MOARuntimeTestObject class]
                                                    selector:@selector(forwardTargetMethod)];
    XCTAssertThrows([MOARuntimeTestObject forwardTargetMethod]);
}

- (void)testOverwritingMsgForwardInstanceMethod
{
    MOARuntimeTestObject *object = [[MOARuntimeTestObject alloc] init];
    [object forwardTargetMethod];
    [MOARuntime overwritingMessageForwardInstanceMethodForClass:[MOARuntimeTestObject class]
                                                       selector:@selector(forwardTargetMethod)];
    XCTAssertThrows([object forwardTargetMethod]);
}

- (void)testAddInstanceMethod
{
    SEL addedMethodSelector = NSSelectorFromString(@"moa_test_method_string");
    [MOARuntime addInstanceMethodForClass:[MOARuntimeTestObject class]
                                 selector:addedMethodSelector
                      implementationBlock:^{
                          return @"abc";
                      }];
    
    XCTAssertTrue([MOARuntime hasInstanceMethodForClass:[MOARuntimeTestObject class]
                                               selector:addedMethodSelector]);
    
    MOARuntimeTestObject *object = [[MOARuntimeTestObject alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *testString = [object performSelector:addedMethodSelector];
#pragma clang diagnostic pop
    XCTAssertTrue([testString isEqualToString:@"abc"]);
}

- (void)testAddClassMethod
{
    SEL addedMethodSelector = NSSelectorFromString(@"moa_test_method_string");
    [MOARuntime addClassMethodForClass:[MOARuntimeTestObject class]
                              selector:addedMethodSelector
                   implementationBlock:^{
                       return @"abc";
                   }];
    
    XCTAssertTrue([MOARuntime hasClassMethodForClass:[MOARuntimeTestObject class]
                                            selector:addedMethodSelector]);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *testString = [[MOARuntimeTestObject class] performSelector:addedMethodSelector];
#pragma clang diagnostic pop
    XCTAssertTrue([testString isEqualToString:@"abc"]);
}

- (void)testCopyInstanceMethod
{
    SEL copySelector = NSSelectorFromString(@"cp_oneValue");
    BOOL ret = [MOARuntime copyInstanceMethodForClass:[MOARuntimeTestObject class]
                                           atSelector:@selector(oneValue)
                                           toSelector:copySelector];
    XCTAssertTrue(ret);
    XCTAssertTrue([MOARuntime hasInstanceMethodForClass:[MOARuntimeTestObject class] selector:copySelector]);
}

- (void)testCopyClassMethod
{
    SEL copySelector = NSSelectorFromString(@"cp_oneValue");
    BOOL ret = [MOARuntime copyClassMethodForClass:[MOARuntimeTestObject class]
                                        atSelector:@selector(oneValue)
                                        toSelector:copySelector];
    XCTAssertTrue(ret);
    XCTAssertTrue([MOARuntime hasClassMethodForClass:[MOARuntimeTestObject class] selector:copySelector]);
}

@end
