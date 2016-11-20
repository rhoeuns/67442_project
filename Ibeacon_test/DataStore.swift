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
    
    /**
     Creates a function to be the completion handler.
     You can include a callback that will trigger afterwards.
     
     - Parameter completionHandler: Optional callback that is called after data is returned and parsed.
     
     - Returns: A function that will be the completion handler for JSONParser
     */
    private func storeResults(completionHandler: (() -> Void)?) -> (JSON?, NSError?) -> Void {
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
