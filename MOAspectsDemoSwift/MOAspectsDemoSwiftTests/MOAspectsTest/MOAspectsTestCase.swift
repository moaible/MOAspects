//
//  MOAspectsTestCase.swift
//  MOAspectsDemoSwift
//
//  Created by HiromiMotodera on 2015/06/14.
//  Copyright (c) 2015年 HiromiMotodera. All rights reserved.
//

import XCTest

class MOAspectsTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
