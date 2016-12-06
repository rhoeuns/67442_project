//
//  Timer.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/6/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

class Timer {
    let date: NSDate
    
    // create a timer, pass it a date
    // countdown function with a certain time interval
    // then have a callback that you can let the caller do their own updates?
    
    // or I can have one function that is the timer for the reservation
    // and another function that handles
    init(date: NSDate) {
        self.date = date
    }
    
    func countdownTilSeating() {
//        let userCalendar = NSCalendar.currentCalendar()
//        let competitionDay = userCalendar.dateFromComponents(competitionDate)!
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: NSDate(), toDate: date, options: [])
//        daysLabel.text = String(components.day)
//        hoursLabel.text = String(components.hour)
//        minutesLabel.text = String(components.minute)
//        secondsLabel.text = String(components.second)
        
        print("---- should be printing time here ----")
        print(components.hour)
        print(components.minute)
        print(components.second)
        print("----------")
        
        var _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)

    }
    
    func loop(callbackHandler: () -> Void) -> NSTimer {
        callback = callbackHandler
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(runCallback), userInfo: nil, repeats: true)
        
        return timer
    }
    
    var count = 10
    dynamic func update() {
        if(count > 0) {
            print(count)
            count -= 1
        }
    }
    
    var callback: (() -> Void)?
    dynamic func runCallback(callbackHandler: () -> Void) {
        callback?()
    }
}