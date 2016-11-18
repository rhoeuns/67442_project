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
    let time_open: String
    let time_closed: String
    let generalEstimatedSeatingTime: NSDate
    
    init(id: Int, name: String, description: String, phone: String, picture: String,
         address: String, latitude: Float, longitude: Float, time_open: String, time_closed: String,
         generalEstimatedSeatingTime: NSDate) {
        self.id = id
        self.name = name
        self.description = description
        self.phone = phone
        self.picture = picture
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.time_open = time_open
        self.time_closed = time_closed
        self.generalEstimatedSeatingTime = generalEstimatedSeatingTime
    }
    
    /**
     Get the estimated wait time that everyone sees.
     (Note: NSTimeInterval is an alias for Double)
     
     - returns: Seconds between now and the estimated seating time.
     */
    func waitTime() -> NSTimeInterval {
        return generalEstimatedSeatingTime.timeIntervalSinceNow
    }
}
