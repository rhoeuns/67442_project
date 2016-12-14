//
//  DateDifferenceTest.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/14/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Ibeacon_test

class DateDifferenceTest: XCTestCase {

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Difference() {
        //Setup 2 dateDifference
        let date1 = NSDate(timeIntervalSinceNow: 60*2)
        let dateDiff = DateDifference(date: date1)
        let date2 = NSDate(timeIntervalSinceNow: 60*61)
        let dateDiff2 = DateDifference(date: date2)
        XCTAssertEqual(date1, dateDiff.date)
        XCTAssertEqual(date2, dateDiff2.date)
    }
    
    
    func test_waitingTimeText() {
        let date3 = NSDate(timeIntervalSinceNow: 60*3)
        let dateDiff3 = DateDifference(date: date3)
        let date4 = NSDate(timeIntervalSinceNow: 60*62)
        let dateDiff4 = DateDifference(date: date4)
        //this is a minute shorter than the dates create because of time passing
        XCTAssertEqual(dateDiff3.waitingTimeText(), "0 hours and 2 minutes")
        XCTAssertEqual(dateDiff4.waitingTimeText(), "1 hour and 1 minute")
    }

    func test_isWaitingNow() {
        let date5 = NSDate(timeIntervalSinceNow: 60*3)
        let dateDiff5 = DateDifference(date: date5)
        let date6 = NSDate(timeIntervalSinceNow: 60*62)
        let dateDiff6 = DateDifference(date: date6)
        XCTAssertFalse(dateDiff5.isAvailableNow())
        XCTAssertFalse(dateDiff6.isAvailableNow())
    }

    private func stringToJSON(jsonString: String) -> JSON? {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return JSON(data: dataFromString)
        }
        else {
            return nil
        }
    }

}
