//
//  beacon.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 11/18/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Beacon: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var viewController:UIViewController?
    var lastStage = CLProximity.Unknown
    var callback: ([CLBeacon] -> Void)? = nil
    
    func setupBeacon() {
        
        locationManager.delegate = self
        
        let uuid = NSUUID(UUIDString: "b9407f30-f5f8-466e-aff9-25556b57fe6d")!
        
        // Use identifier like your company name or website
        let identifier = "67442_project_beacon"
        
        let Major:CLBeaconMajorValue = 54755
        let Minor:CLBeaconMinorValue = 43555
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: Major, minor: Minor, identifier: identifier)
    
        
        // called delegate when Enter iBeacon Range
        beaconRegion.notifyOnEntry = true
        
        // called delegate when Exit iBeacon Range
        beaconRegion.notifyOnExit = true
        
        // Requests permission to use location services
        locationManager.requestAlwaysAuthorization()
        
        // Starts monitoring the specified iBeacon Region
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
            
        case .AuthorizedAlways:
            // Starts the generation of updates that report the user’s current location.
            locationManager.startUpdatingLocation()
            
        case .Restricted:
            
            // Your app is not authorized to use location services.
            simpleAlert("Permission Error", message: "Need Location Service Permission To Access Beacon")
            
        case .Denied:
            
            // The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.
            
            simpleAlert("Permission Error", message: "Need Location Service Permission To Access Beacon")
            
        default:
            // handle .NotDetermined here
            
            // The user has not yet made a choice regarding whether this app can use location services.
            break
        }
    }
    
    
    func simpleAlert (title:String,message:String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        viewController!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        
        // Tells the delegate that a iBeacon Area is being monitored
        
        locationManager.requestStateForRegion(region)
    }
    
    
//    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        
//        // Tells the delegate that the user entered in iBeacon range or area.
//        
//        simpleAlert("Welcome", message: "Welcome to our store")
//        
//        // This method called because
//        // beaconRegion.notifyOnEntry = true
//        // in setupBeacon() function
//    }
    
//    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
//        
//        // Tells the delegate that the user exit the iBeacon range or area.
//        
//        simpleAlert("Good Bye", message: "Have a nice day")
//        
//        // This method called because
//        // beaconRegion.notifyOnExit = true
//        // in setupBeacon() function
//    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        
        switch  state {
            
        case .Inside:
            //The user is inside the iBeacon range.
            
            locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            
            break
            
        case .Outside:
            //The user is outside the iBeacon range.
            
            locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            
            break
            
        default :
            // it is unknown whether the user is inside or outside of the iBeacon range.
            break
            
        }
    }
    
    //// THIS IS THE ONE THAT DOES THE STUFF WE WANT!
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        // Tells the delegate that one or more beacons are in range.
        let foundBeacons = beacons
        
//        print("inside locationManager, num beacons is \(foundBeacons.count)")
        let nearbyBeacons = foundBeacons.filter { beacon in
            print("this beacon's proximity is \(beacon.proximity)")
            switch  beacon.proximity {
                
            case .Immediate:
                print("this beacon's proximity is IMMEDIATE")
                return true
            case .Near:
                print("this beacon's proximity is NEAR")
                return true
            case .Far:
                print("this beacon's proximity is FAR")
                return false
            default:
                print("this beacon's proximity is DEFAULT")
                return false
            }
        }
        
        if let callback = callback {
            callback(nearbyBeacons)
        }
    }

}
