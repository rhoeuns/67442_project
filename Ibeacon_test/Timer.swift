//
//  Timer.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/6/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

class Timer {
    var date: NSDate? = nil
    var count = 10
    var callback: (() -> Void)?

    
    // create a timer, pass it a date
    // countdown function with a certain time interval
    // then have a callback that you can let the caller do their own updates?
    
    // or I can have one function that is the timer for the reservation
    // and another function that handles

    
    func countdownTilSeating(date: NSDate) {
//        self.date = date
        
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
        
        var _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
    
    func loop(interval interval: Double, callbackHandler: () -> Void) -> NSTimer {
        callback = callbackHandler
        let timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(runCallback), userInfo: nil, repeats: true)
        
        // Fire immediately the first time
        timer.fire()
        
        return timer
    }
    
    dynamic func update() {
        if(count > 0) {
            print(count)
            count -= 1
        }
    }
    
    dynamic func runCallback() {
        callback?()
    }
}
