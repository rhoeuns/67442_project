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

    
    func updateRestaurants(completionHandler: (() -> Void)?) {
        serverRequestor.getRestaurants() { json, error in
            let restaurants = self.jsonParser.parseRestaurants(json!)
            self.restaurants = restaurants
            
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
    func updateRestaurants(uuids: [String], completionHandler: (() -> Void)?) {
        serverRequestor.getRestaurants(uuids) { json, error in
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
            let resultRestaurant = restaurant // this will hold the final result that is returned
            
            //// Specifically checking and updating the wait times only
            
            // Check if general time was updated
            if self.timeWasUpdated(restaurant.generalEstimatedSeatingTime, newTime: updatedRestaurant.generalEstimatedSeatingTime) {
                resultRestaurant.generalEstimatedSeatingTime = updatedRestaurant.generalEstimatedSeatingTime
            }
            
            // Check if personal time is updated
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
                    // if the time was updated since last
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
    
    func updateMakeReservation(restaurant: Restaurant, party_size: Int, completionHandler: (() -> Void)?) {
        serverRequestor.makeReservation(restaurant.id, party_size: party_size) { json, error in
            if let _ = error {
                // TODO: not sure what to do when error happens
            }
            else if let json = json {
                let personalTime = self.jsonParser.parseMakeReservationResponse(json)
                restaurant.personal_estimated_seating_time = personalTime
                
                if completionHandler != nil {
                    completionHandler!()
                }
            }
        }
    }
    
    func updateCancelReservation(restaurant: Restaurant, completionHandler: (() -> Void)?) {
        serverRequestor.cancelReservation() { json, error in
            if let _ = error {
                // TODO: not sure what to do when error happens
            }
            else {
                // There is no body, so nothing to parse here.
                restaurant.personal_estimated_seating_time = nil
                
                if completionHandler != nil {
                    completionHandler!()
                }
            }
        }
    }
    
    func findReservedRestaurant() -> Restaurant? {
        // Should only ever have one reservation at a time.
        let myReservations = restaurants.filter{
            $0.personal_estimated_seating_time != nil
        }
        
        if (myReservations.count > 0) {
            return myReservations[0]
        }
        else {
            return nil
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
