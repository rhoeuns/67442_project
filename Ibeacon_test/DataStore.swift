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
    var restaurants = [Restaurant]()
    var restaurantsInLineFor = [InLineFor]()
    
    
    // The way I'm doing this right now, Alamofire returns the result and I save it
    // However, there's no way to tell the rest of the app that the data has changed.
    // The idea I had was to basically chain callbacks, but I'm not 100% sure how to do that here.
    
    // Implemented something below, let's see if it does what I want lol
    
    
    /**
     Fetches json data payload from the server.
     Then parses the JSON into model objects that will be stored here.
     You can include a callback that will run after parsing is complete.
     
     - Parameter completionHandler: Optional callback that is called after data is returned and parsed.
     */
    func fetchServerData(completionHandler: (() -> Void)?) {
        let serverRequestor = ServerRequestor()
        serverRequestor.getPayload(storeResults(completionHandler))
    }
    

    // Callback completion handler
//    func storeResults(json: JSON?, error: NSError?) {
//        let jsonParser = JSONParser()
//        let models = jsonParser.parseJSON(json!)
//        
//        restaurants = models.0
//        restaurantsInLineFor = models.1
//    }
    
    
    /**
     Creates a function to be the completion handler.
     You can include a callback that will trigger afterwards.
     
     - Parameter completionHandler: Optional callback that is called after data is returned and parsed.
     
     - Returns: A function that will be the completion handler for JSONParser
     */
    func storeResults(completionHandler: (() -> Void)?) -> (JSON?, NSError?) -> Void {
        return { json, error in
            let jsonParser = JSONParser()
            let models = jsonParser.parseJSON(json!)
            
            self.restaurants = models.0
            self.restaurantsInLineFor = models.1
            
            if completionHandler != nil {
                completionHandler!()
            }
        }
    }
    
}
