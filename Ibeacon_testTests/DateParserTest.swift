//
//  DateParserTest.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/14/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import XCTest
@testable import Ibeacon_test

class DateParserTest: XCTestCase {
    
    let dateParser = DateParser()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_parseDate(){
        XCTAssertTrue(dateParser.parseDate("2016/12/13 13:47") is NSDate)
    }
    
}
