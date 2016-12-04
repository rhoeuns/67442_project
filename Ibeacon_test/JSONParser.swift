//
//  JSONParser.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/20/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParser {
    func parseRestaurants(data: JSON) -> [Restaurant] {
        let restaurantModels = data["restaurants"].map { _, restaurantJSON in
            return Restaurant(json: restaurantJSON)
        }

        return restaurantModels
    }
    
    func parseRestaurant(data: JSON) -> Restaurant {
        let restaurantJSON = data["restaurant"]
        return Restaurant(json: restaurantJSON)
    }
    
    func parseMakeReservationResponse(data: JSON) -> NSDate? {
        if let dateString = data["personal_estimated_seating_time"].string {
            return DateParser().parseDate(dateString)
        }
        else {
            return nil
        }
    }

}
