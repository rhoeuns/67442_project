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

    func loop(interval interval: Double, callbackHandler: () -> Void) -> NSTimer {
        callback = callbackHandler
        let timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(runCallback), userInfo: nil, repeats: true)
        
        // Fire immediately the first time
        timer.fire()
        
        return timer
    }

    dynamic func runCallback() {
        callback?()
    }
}
