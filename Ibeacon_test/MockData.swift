//
//  MockData.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import SwiftyJSON

class MockData {
    let jsonString = "{\"restaurants\":[{\"id\":1,\"name\":\"Union Grill\",\"description\":\"Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.\",\"phone\":\"(412) 681-8620\",\"picture\":\"http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg\",\"address\":\"413 S Craig St, Pittsburgh, PA 15213\",\"latitude\":40.444835,\"longitude\":-79.948529,\"time_open\":\"11:30am\",\"time_closed\":\"10pm\",\"generalEstimatedSeatingTime\":\"2016/11/18 22:05\"},{\"id\":2,\"name\":\"The Porch\",\"description\":\"Sunny bistro for gourmet pizzas, burgers & more with a counter service lunch & full service dinner.\",\"phone\":\"(412) 687-6724\",\"picture\":\"https://media-cdn.tripadvisor.com/media/photo-s/02/d8/2f/12/the-porch-at-schenley.jpg\",\"address\":\"221 Schenley Drive, Pittsburgh, PA 15213\",\"latitude\":40.442758,\"longitude\":-79.953102,\"time_open\":\"11am\",\"time_closed\":\"11pm\",\"generalEstimatedSeatingTime\":\"2016/11/18 21:45\"}],\"inLineFor\":[{\"restaurant_id\":1,\"personalEstimatedSeatingTime\":\"2016/11/18 21:55\"}]}"
    
    var restaurants = [Restaurant]()
    var restaurantsInLineFor = [InLineFor]()
    
    init() {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            print(json)
            
            parseJSON(json)
        }
    }
    
    func parseJSON(data: JSON) {
        for (_, subJSON):(String, JSON) in data["restaurants"] {
            restaurants.append(Restaurant(json: subJSON))
        }
        
        for (_, subJSON):(String, JSON) in data["inLineFor"] {
            restaurantsInLineFor.append(InLineFor(json: subJSON, restaurantsList: restaurants))
        }
        
        print(data)
    }
}




/**
 This is the plain JSON
 
 {
 "restaurants": [
 {
 "id": 1,
 "name": "Union Grill",
 "description": "Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.",
 "phone": "(412) 681-8620",
 "picture": "http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg",
 "address": "413 S Craig St, Pittsburgh, PA 15213",
 "latitude": 40.444835,
 "longitude": -79.948529,
 "time_open": "11:30am",
 "time_closed": "10pm",
 "generalEstimatedSeatingTime": "2016/11/18 22:05"
 },
 {
 "id": 2,
 "name": "The Porch",
 "description": "Sunny bistro for gourmet pizzas, burgers & more with a counter service lunch & full service dinner.",
 "phone": "(412) 687-6724",
 "picture": "https://media-cdn.tripadvisor.com/media/photo-s/02/d8/2f/12/the-porch-at-schenley.jpg",
 "address": "221 Schenley Drive, Pittsburgh, PA 15213",
 "latitude": 40.442758,
 "longitude": -79.953102,
 "time_open": "11am",
 "time_closed": "11pm",
 "generalEstimatedSeatingTime": "2016/11/18 21:45"
 }
 ],
 
 "inLineFor": [
 {
 "restaurant_id": 1,
 "personalEstimatedSeatingTime": "2016/11/18 21:55"
 }
 ]
 }
 */
