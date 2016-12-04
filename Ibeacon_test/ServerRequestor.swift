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
    let jsonServerEndpoint = "http://localhost:3000/db"
    
    func getPayload(completionHandler: (JSON?, NSError?) -> ()) {
        Alamofire.request(.GET, jsonServerEndpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on \(self.jsonServerEndpoint)")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let data = JSON(value)

                    print("Data from server is:\n" + data.description)
                    
                    completionHandler(data, nil)
                }
        }
    }
}
