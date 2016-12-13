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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
