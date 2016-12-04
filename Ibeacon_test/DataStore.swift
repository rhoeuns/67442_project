//
//  DataStore.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/20/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataStore {
    let serverRequestor = ServerRequestor()
    let jsonParser = JSONParser()
    
    var restaurants = [Restaurant]()

    /**
     Fetches json data payload from the server.
     Then parses the JSON into model objects that will be stored here.
     You can include a callback that will run after parsing is complete.
     
     - Parameter completionHandler: Optional callback that is called after data is returned and parsed.
     */
    func fetchServerData(completionHandler: (() -> Void)?) {
        serverRequestor.getRestaurants(storeResults(completionHandler))
    }
    
    /**
     Creates a function to be the completion handler.
     You can include a callback that will trigger afterwards.
     
     - Parameter completionHandler: Optional callback that is called after data is returned and parsed.
     
     - Returns: A function that will be the completion handler for JSONParser
     */
    private func storeResults(completionHandler: (() -> Void)?) -> (JSON?, NSError?) -> Void {
        return { json, error in
            
            let restaurants = self.jsonParser.parseRestaurants(json!)
            
            self.restaurants = restaurants
            
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
    
    func updateRestaurants(completionHandler: (() -> Void)?) {
        serverRequestor.getRestaurants() { json, error in
            let restaurants = self.jsonParser.parseRestaurants(json!)
            self.restaurants = restaurants
            
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
    func updateRestaurant(restaurant: Restaurant, completionHandler: (() -> Void)?) {
        serverRequestor.getRestaurant(restaurant.id) { json, error in
            let updatedRestaurant = self.jsonParser.parseRestaurant(json!)
            var resultRestaurant = restaurant // this will hold the final result that is returned
            
            // Specifically checking and updating the wait times only
            
            //// check general time updated
            //// check personal time null
            //// check personal time updated
            //// NOTE: time that is in the future is an update, any time before now is NOT
            if self.timeWasUpdated(restaurant.generalEstimatedSeatingTime, newTime: updatedRestaurant.generalEstimatedSeatingTime) {
                resultRestaurant.generalEstimatedSeatingTime = updatedRestaurant.generalEstimatedSeatingTime
            }
            
            if restaurant.personal_estimated_seating_time == nil && updatedRestaurant.personal_estimated_seating_time != nil {
                // if there has been a reservation made since last time
                resultRestaurant.personal_estimated_seating_time = updatedRestaurant.personal_estimated_seating_time
            }
            else if restaurant.personal_estimated_seating_time != nil && updatedRestaurant.personal_estimated_seating_time == nil {
                // if there has been a cancelled reservation since last time
                resultRestaurant.personal_estimated_seating_time = nil
            }
            else {
                if let oldPersonal = restaurant.personal_estimated_seating_time,
                    newPersonal = updatedRestaurant.personal_estimated_seating_time {
                    if self.timeWasUpdated(oldPersonal, newTime: newPersonal) {
                        resultRestaurant.personal_estimated_seating_time = updatedRestaurant.personal_estimated_seating_time
                    }
                }
            }
            
            // TODO: probably need to have a specific way format for the completion handler
            //       so that you know IF an update happened, and if so what kind
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
    private func timeWasUpdated(oldTime: NSDate, newTime: NSDate) -> Bool {
        if oldTime.timeIntervalSinceNow < 0 && newTime.timeIntervalSinceNow < 0 {
            // if both times are earlier than the current date and time
            // that is equivalent to there being no wait then and no wait now
            return false
        }
        else if oldTime.timeIntervalSinceDate(newTime) != 0 {
            // if there is a difference between the times
            return true
        }
        else {
            return false
        }
    }
    
}
