//
//  ViewController.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 11/7/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController{
    
    @IBOutlet weak var beaconStatus: UILabel!

    let dataStore = DataStore()
    let beacon = Beacon()
    let myBTManager = CBPeripheralManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Do any additional setup after loading the view, typically from a nib.
//        locationManager.delegate = self
//        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.startRangingBeaconsInRegion(region)
        
//        MockData()
//        ServerRequestor().testGET()
        
//        dataStore.updateRestaurants() {
//            print("Callback function inside ViewController worked! yay!")
////            self.test()
//            
//            let restaurant1 = self.dataStore.restaurants[0]
//            self.dataStore.updateRestaurant(restaurant1) {
//                print("How do I test this? I'd need the server to change")
//            }
//        }

        
//        let requestor = ServerRequestor()
//        
//        requestor.makeReservation(1, party_size: 2) { _, _ in
//            requestor.makeReservation(1, party_size: 3) {_,_ in 
//                requestor.cancelReservation() {_,_ in
//                    requestor.cancelReservation() {_,_ in
//                        print("ALL CALLBACKS COMPLETED")
//                    }
//                }
//            }
//        }
        
        // Define in iBeacon.swift
//        self.beacon.viewController = self
//        self.beacon.beaconStatus = beaconStatus
//        self.beacon.setupBeacon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [AnyObject], inRegion region: CLBeaconRegion) {
//        print(beacons)
//    }
    

    
}
