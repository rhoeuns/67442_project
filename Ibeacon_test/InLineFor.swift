//
//  RestaurantsInLineFor.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import SwiftyJSON

struct InLineFor {
    let id: Int
    let restaurant: Restaurant
    let personalEstimatedSeatingTime: NSDate
    
    init(id: Int, restaurant: Restaurant, personalEstimatedSeatingTime: NSDate) {
        self.id = id
        self.restaurant = restaurant
        self.personalEstimatedSeatingTime = personalEstimatedSeatingTime
    }
    
    init(json: JSON, restaurantsList: [Restaurant]) {
        let id = json["id"].intValue
        
        let restaurantID = json["restaurant_id"].intValue
        let restaurant = restaurantsList.filter { $0.id == restaurantID }[0]
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let time = formatter.dateFromString(json["personalEstimatedSeatingTime"].string!)!
        
        self.init(id: id,
                  restaurant: restaurant,
                  personalEstimatedSeatingTime: time)
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
