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
    var beaconStatus: UILabel?

    
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
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        // Tells the delegate that the user entered in iBeacon range or area.
        
        simpleAlert("Welcom", message: "Welcome to our store")
        
        // This method called because
        // beaconRegion.notifyOnEntry = true
        // in setupBeacon() function
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        // Tells the delegate that the user exit the iBeacon range or area.
        
        simpleAlert("Good Bye", message: "Have a nice day")
        
        // This method called because
        // beaconRegion.notifyOnExit = true
        // in setupBeacon() function
    }
    
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
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        // Tells the delegate that one or more beacons are in range.
        let foundBeacons = beacons
        
        if foundBeacons.count > 0 {
            
            if let closestBeacon = foundBeacons[0] as? CLBeacon {
                
                var proximityMessage: String!
                if lastStage != closestBeacon.proximity {
                    
                    lastStage = closestBeacon.proximity
                    
                    switch  lastStage {
                        
                    case .Immediate:
                        proximityMessage = "Very close"
                        viewController!.view.backgroundColor = UIColor.greenColor()
                        
                    case .Near:
                        proximityMessage = "Near"
                        viewController!.view.backgroundColor = UIColor.grayColor()
                        
                    case .Far:
                        proximityMessage = "Far"
                        viewController!.view.backgroundColor = UIColor.blackColor()
                        
                    default:
                        proximityMessage = "Where's the beacon?"
                        viewController!.view.backgroundColor = UIColor.redColor()
                        
                    }
                    var makeString = "Beacon Details:n"
                    makeString += "UUID = \(closestBeacon.proximityUUID.UUIDString)n"
                    makeString += "Identifier = \(region.identifier)n"
                    makeString += "Major Value = \(closestBeacon.major.intValue)n"
                    makeString += "Minor Value = \(closestBeacon.minor.intValue)n"
                    makeString += "Distance From iBeacon = \(proximityMessage)"
                    
                    self.beaconStatus!.text = makeString
                    if proximityMessage == "Very close"{
                        let alert = UIAlertController(title: "Hi, there!", message: "Do you want to hop in the line for Union Grill?" , preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                        viewController!.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
}
