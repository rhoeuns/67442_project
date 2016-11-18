//
//  RestaurantsInLineFor.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

struct InLineFor {
    let restaurant: Restaurant
    let personalEstimatedSeatingTime: NSDate
    
    init(restaurant: Restaurant, personalEstimatedSeatingTime: NSDate) {
        self.restaurant = restaurant
        self.personalEstimatedSeatingTime = personalEstimatedSeatingTime
    }
    
    /**
     Get the estimated wait time until this specific user is supposed to be seated.
     (Note: NSTimeInterval is an alias for Double)
     
     - returns: Seconds between now and the estimated seating time.
     */
    func waitTime() -> NSTimeInterval {
        return personalEstimatedSeatingTime.timeIntervalSinceNow
    }
}
