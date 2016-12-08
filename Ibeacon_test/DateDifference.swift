//
//  DateDifference.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/8/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

class DateDifference {
    
    func difference(date: NSDate) -> NSDateComponents {
        let currentDate = NSDate()
    
        let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: currentDate, toDate: date, options: .MatchFirst)
    
//        let countdown = "Hours: \(diffDateComponents.hour), Minutes: \(diffDateComponents.minute), Seconds: \(diffDateComponents.second)"

        return diffDateComponents
    }
}
