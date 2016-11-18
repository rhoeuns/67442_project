//
//  Restaurant.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

struct Restaurant {
    let id: Int
    let name: String
    let description: String
    let phone: String
    let picture: String
    let address: String
    let latitude: Float
    let longitude: Float
    let time_open: NSDate
    let time_closed: NSDate
    let generalEstimatedSeatingTime: NSDate
    
    /**
     Get the estimated wait time that everyone sees.
     (Note: NSTimeInterval is an alias for Double)
     
     - returns: Seconds between now and the estimated seating time.
     */
    func waitTime() -> NSTimeInterval {
        return generalEstimatedSeatingTime.timeIntervalSinceNow
    }
}
