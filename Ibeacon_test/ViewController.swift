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

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet weak var beaconStatus: UILabel!
    let dataStore = DataStore()
    
    let locationManager = CLLocationManager()
    let myBTManager = CBPeripheralManager()
    var lastStage = CLProximity.Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        // Define in iBeacon.swift
        self.setupBeacon()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [AnyObject], inRegion region: CLBeaconRegion) {
//        print(beacons)
//    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        
        if peripheral.state == CBPeripheralManagerState.PoweredOff {
            
            simpleAlert("Beacon", message: "Turn On Your Device Bluetooh")
        }
    }
}