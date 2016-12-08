//
//  Restaurant.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import SwiftyJSON

class Restaurant {
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
    var generalEstimatedSeatingTime: NSDate
    var personal_estimated_seating_time: NSDate?
    var position_in_line: Int? // 0 indexed
    
    init(id: Int, name: String, description: String, phone: String, picture: String,
         address: String, latitude: Float, longitude: Float, time_open: String, time_closed: String,
         generalEstimatedSeatingTime: NSDate, personal_estimated_seating_time: NSDate?,
         position_in_line: Int?) {
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
        self.personal_estimated_seating_time = personal_estimated_seating_time
        self.position_in_line = position_in_line
    }
    
    convenience init(json: JSON) {
        let dateParser = DateParser()
        
        let general_time = dateParser.parseDate(json["general_estimated_seating_time"].string!)
        
        var personal_time: NSDate?
        if let personal_time_string = json["personal_estimated_seating_time"].string {
            personal_time = dateParser.parseDate(personal_time_string)
        }
        else {
            personal_time = nil
        }

        self.init(id: json["id"].int!, name: json["name"].string!,
                  description: json["description"].string!,
                  phone: json["phone"].string!, picture: json["picture"].string!,
                  address: json["address"].string!, latitude: Float(json["latitude"].double!),
                  longitude: Float(json["longitude"].double!), time_open: json["time_open"].string!,
                  time_closed: json["time_closed"].string!, generalEstimatedSeatingTime: general_time,
                  personal_estimated_seating_time: personal_time, position_in_line: json["position_in_line"].int)
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
