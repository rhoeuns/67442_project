//
//  JSONParserTest.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/13/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Ibeacon_test

class JSONParserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseRestaurants() {
        let restaurantsJSONString = "{\"restaurants\":[{\"id\":1,\"name\":\"Union Grill\",\"description\":\"Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.\",\"phone\":\"(412) 681-8620\",\"picture\":\"http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg\",\"address\":\"413 S Craig St, Pittsburgh, PA 15213\",\"latitude\":40.444835,\"longitude\":-79.948529,\"time_open\":\"11:30am\",\"time_closed\":\"10pm\",\"general_estimated_seating_time\":\"2016/12/13 13:47\",\"personal_estimated_seating_time\":null,\"position_in_line\":null},{\"id\":2,\"name\":\"The Porch\",\"description\":\"Sunny bistro for gourmet pizzas, burgers & more with a counter service lunch & full service dinner.\",\"phone\":\"(412) 687-6724\",\"picture\":\"https://media-cdn.tripadvisor.com/media/photo-s/02/d8/2f/12/the-porch-at-schenley.jpg\",\"address\":\"221 Schenley Drive, Pittsburgh, PA 15213\",\"latitude\":40.442758,\"longitude\":-79.953102,\"time_open\":\"11am\",\"time_closed\":\"11pm\",\"general_estimated_seating_time\":\"2016/12/13 13:47\",\"personal_estimated_seating_time\":\"2016/12/13 13:47\",\"position_in_line\":1}]}"
        
        if let restaurantsJSON = stringToJSON(restaurantsJSONString) {
            let restaurants = JSONParser().parseRestaurants(restaurantsJSON)
            
            // Tests for restaurant 1
            XCTAssertEqual(1, restaurants[0].id)
            XCTAssertEqual("Union Grill", restaurants[0].name)
            XCTAssertEqual("Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.", restaurants[0].description)
            XCTAssertEqual("(412) 681-8620", restaurants[0].phone)
            XCTAssertEqual("http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg", restaurants[0].picture)
            XCTAssertEqual("413 S Craig St, Pittsburgh, PA 15213", restaurants[0].address)
            XCTAssertEqual(40.444835, restaurants[0].latitude)
            XCTAssertEqual(-79.948529, restaurants[0].longitude)
            XCTAssertEqual("11:30am", restaurants[0].time_open)
            XCTAssertEqual("10pm", restaurants[0].time_closed)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 13:47"), restaurants[0].generalEstimatedSeatingTime)
            XCTAssertEqual(nil, restaurants[0].personal_estimated_seating_time)
            XCTAssertEqual(nil, restaurants[0].position_in_line)
            
            // Tests for restaurant 2
            XCTAssertEqual(2, restaurants[1].id)
            XCTAssertEqual("The Porch", restaurants[1].name)
            XCTAssertEqual("Sunny bistro for gourmet pizzas, burgers & more with a counter service lunch & full service dinner.", restaurants[1].description)
            XCTAssertEqual("(412) 687-6724", restaurants[1].phone)
            XCTAssertEqual("https://media-cdn.tripadvisor.com/media/photo-s/02/d8/2f/12/the-porch-at-schenley.jpg", restaurants[1].picture)
            XCTAssertEqual("221 Schenley Drive, Pittsburgh, PA 15213", restaurants[1].address)
            XCTAssertEqual(40.442758, restaurants[1].latitude)
            XCTAssertEqual(-79.953102, restaurants[1].longitude)
            XCTAssertEqual("11am", restaurants[1].time_open)
            XCTAssertEqual("11pm", restaurants[1].time_closed)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 13:47"), restaurants[1].generalEstimatedSeatingTime)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 13:47"), restaurants[1].personal_estimated_seating_time)
            XCTAssertEqual(1, restaurants[1].position_in_line)

        }
        else {
            XCTFail("Error parsing restaurant JSON")
        }
    }
    
    func testParseRestaurant() {
        let restaurantJSONString = "{\"restaurant\":{\"id\":1,\"name\":\"Union Grill\",\"description\":\"Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.\",\"phone\":\"(412) 681-8620\",\"picture\":\"http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg\",\"address\":\"413 S Craig St, Pittsburgh, PA 15213\",\"latitude\":40.444835,\"longitude\":-79.948529,\"time_open\":\"11:30am\",\"time_closed\":\"10pm\",\"general_estimated_seating_time\":\"2016/12/13 13:47\",\"personal_estimated_seating_time\":\"2016/12/13 13:00\",\"position_in_line\":1}}"

        if let restaurantJSON = stringToJSON(restaurantJSONString) {
            let restaurant = JSONParser().parseRestaurant(restaurantJSON)
            
            XCTAssertEqual(1, restaurant.id)
            XCTAssertEqual("Union Grill", restaurant.name)
            XCTAssertEqual("Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.", restaurant.description)
            XCTAssertEqual("(412) 681-8620", restaurant.phone)
            XCTAssertEqual("http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg", restaurant.picture)
            XCTAssertEqual("413 S Craig St, Pittsburgh, PA 15213", restaurant.address)
            XCTAssertEqual(40.444835, restaurant.latitude)
            XCTAssertEqual(-79.948529, restaurant.longitude)
            XCTAssertEqual("11:30am", restaurant.time_open)
            XCTAssertEqual("10pm", restaurant.time_closed)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 13:47"), restaurant.generalEstimatedSeatingTime)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 13:00"), restaurant.personal_estimated_seating_time)
            XCTAssertEqual(1, restaurant.position_in_line)
        }
        else {
            XCTFail("Error parsing restaurant JSON")
        }
        
    }
    
    func testParseMakeReservationResponse() {
        let jsonString = "{\"personal_estimated_seating_time\":\"2016/12/13 15:10\"}"
        
        if let timeJSON = stringToJSON(jsonString) {
            let time = JSONParser().parseMakeReservationResponse(timeJSON)
            XCTAssertEqual(DateParser().parseDate("2016/12/13 15:10"), time)
        }
        else {
            XCTFail("Error parsing restaurant JSON")
        }
    }
    
    private func stringToJSON(jsonString: String) -> JSON? {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return JSON(data: dataFromString)
        }
        else {
            return nil
        }
    }


}
