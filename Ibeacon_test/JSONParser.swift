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
    func parseJSON(data: JSON) -> [Restaurant] {
        let restaurantModels = data["restaurants"].map { _, subJSON in
            return Restaurant(json: subJSON)
        }

        return restaurantModels
    }
}
