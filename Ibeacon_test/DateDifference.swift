//
//  DateDifference.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/8/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

class DateDifference {
    
    let date: NSDate
    var diff: NSDateComponents? = nil
    
    init(date: NSDate) {
        self.date = date
        self.diff = difference()
    }
    
    func difference() -> NSDateComponents {
        let currentDate = NSDate()
    
        let diffDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: currentDate, toDate: date, options: .MatchFirst)
    
        return diffDateComponents
    }
    
    func waitingTimeText() -> String {
        var output = ""
        
        if diff!.hour == 1 {
            output += "\(diff!.hour) hour"
        }
        else {
            output += "\(diff!.hour) hours"
        }
        
        output += " and "
        
        if diff!.minute == 1 {
            output += "\(diff!.minute) minute"
        }
        else {
            output += "\(diff!.minute) minutes"
        }
        
        return output
    }
    
    func isAvailableNow() -> Bool {
        if diff!.hour < 1 && diff!.minute < 1 {
            return true
        }
        else {
            return false
        }
    }
}
