//
//  RestaurantTest.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/13/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Ibeacon_test

class RestaurantTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRestaurantJSONConstructor() {
        let restaurantJSONString = "{\"id\":1,\"name\":\"Union Grill\",\"description\":\"Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.\",\"phone\":\"(412) 681-8620\",\"picture\":\"http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg\",\"address\":\"413 S Craig St, Pittsburgh, PA 15213\",\"latitude\":40.444835,\"longitude\":-79.948529,\"time_open\":\"11:30am\",\"time_closed\":\"10pm\",\"general_estimated_seating_time\":\"2016/12/13 13:47\",\"personal_estimated_seating_time\":\"2016/12/13 13:00\",\"position_in_line\":1}"
        
        if let restaurantJSON = stringToJSON(restaurantJSONString) {
            let restaurant = Restaurant(json: restaurantJSON)
            
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
    
    func testRestaurantConstructor() {
            let restaurant = Restaurant(id: 1, name: "Union Grill", description: "Bustling spot popular with the college crowd & known for piled-high burgers & waffle-cut fries.", phone: "(412) 681-8620", picture: "http://theuniongrill.com/wp-content/uploads/2012/09/banner2.jpg", address: "413 S Craig St, Pittsburgh, PA 15213", latitude: 40.444835, longitude: -79.948529, time_open: "11:30am", time_closed: "10pm", generalEstimatedSeatingTime: DateParser().parseDate("2016/12/13 13:47"), personal_estimated_seating_time: DateParser().parseDate("2016/12/13 13:00"), position_in_line: 1)
            
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
    
    private func stringToJSON(jsonString: String) -> JSON? {
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return JSON(data: dataFromString)
        }
        else {
            return nil
        }
    }

}
