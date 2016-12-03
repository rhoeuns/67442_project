//
//  ServerRequestor.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 11/20/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerRequestor {
//    let endpoint = "http://localhost:3000/db"
    let endpoint = "http://localhost:3000/users/1/restaurants"

    func getPayload(completionHandler: (JSON?, NSError?) -> ()) {
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on \(self.endpoint)")
                    print(response.result.error!)
                    
                    completionHandler(nil, response.result.error)
                    return
                }
                
                if let value = response.result.value {
                    let data = JSON(value)

                    print("Data from server is:\n" + data.description)
                    
                    completionHandler(data, nil)
                }
        }
    }
    
    func makeReservation(restaurantId: Int, party_size: Int, completionHandler: (JSON?, NSError?) -> ()) {
        let makeReservationEndpoint = "\(endpoint)/\(restaurantId)/make-reservation"
        let params = buildReservationJSON(party_size: party_size)
        
        print("MAKING RESERVATION, sending request to the url: \(makeReservationEndpoint)")
        
        Alamofire.request(.POST, makeReservationEndpoint, parameters: params, encoding: .JSON)
            .validate()
            .responseData { response in
                if case .Success = response.result {
                    print("---------------------------")
                    print("Making reservation, response type DATA")
                    print("Validation Successful, reservation made!")
                    completionHandler(nil, nil)
                }
            }
            .responseJSON { response in
                // If the body is empty, quit.
                // Manually checking because AlamoFire has no good way to handle an empty response body.
                if response.response?.statusCode == 204 {
                    return
                }
                
                if case .Failure(let error) = response.result {
                    print("---------------------------")
                    print("Failed to make reservation:")
                    print(error)
                    
                    // Getting the error response from the server
                    // You have to do this manually =(
                    if let data = response.data {
                        let responseJSON = JSON(data: data)
                        
                        if let message: String = responseJSON["message"].stringValue {
                            if !message.isEmpty {
                                print(message)
                            }
                        }
                    }
                    
                    completionHandler(nil, error)
                    
                }
            }
    }
    
    func cancelReservation(completionHandler: (JSON?, NSError?) -> ()) {
        let cancelReservationEndpoint = "\(endpoint)/cancel-reservation"

        Alamofire.request(.POST, cancelReservationEndpoint)
            .validate()
            .responseData { response in
                if case .Success = response.result {
                    print("---------------------------")
                    print("Cancelling reservation, response type DATA")
                    completionHandler(nil, nil)
                }
            }
            .responseJSON { response in
                // If the body is empty, quit.
                // Manually checking because AlamoFire has no good way to handle an empty response body.
                if response.response?.statusCode == 204 {
                    return
                }
                
                if case .Failure(let error) = response.result {
                    print("---------------------------")
                    print("Failed to cancel reservation:")
                    print(error)

                    // Getting the error response from the server
                    // You have to do this manually =(
                    if let data = response.data {
                        let responseJSON = JSON(data: data)
                        
                        if let message: String = responseJSON["message"].stringValue {
                            if !message.isEmpty {
                                print(message)
                            }
                        }
                    }
                    
                    completionHandler(nil, error)
                    
                }
        }
    }
    
    private func buildReservationJSON(party_size party_size: Int) -> [String: AnyObject] {
        let dict: [String: AnyObject] = ["reservation": ["party_size": party_size] ]
//        let json = JSON(dict)
//        return json
        return dict
    }
}
