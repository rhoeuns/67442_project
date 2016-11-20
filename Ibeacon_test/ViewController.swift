//
//  ViewController.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 11/7/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
//class ViewController: UIViewController, CLLocationManagerDelegate {

//    let locationManager = CLLocationManager()
//    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString("") , identifier: "Estimotes"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        locationManager.delegate = self
//        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.startRangingBeaconsInRegion(region)
        
        MockData()
        ServerRequestor().testGET()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [AnyObject], inRegion region: CLBeaconRegion) {
//        print(beacons)
//    }
}

