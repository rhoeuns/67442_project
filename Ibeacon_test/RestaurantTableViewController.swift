//
//  RestaurantTableViewController.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/8/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class RestaurantTableViewController: UITableViewController {
    
    var dataStore = DataStore()
    var timer: NSTimer?
    var beaconManager: Beacon?
    var nearbyBeacons = [CLBeacon]()
    
    @IBOutlet var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor(rgb: 0xFF5733)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        beaconManager = Beacon()
        beaconManager?.setupBeacon()
        beaconManager?.viewController = self
        beaconManager?.callback = { beacons in
            self.nearbyBeacons = beacons
        }
        
        self.timer = Timer().loop(interval: 1.5) {
            self.reloadDataAndTable()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
        
        // No function to kill the beaconManager right now
        // Might need to have on in the future, not sure?
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataStore.restaurants.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCells", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "\(self.dataStore.restaurants[indexPath.row].name)"
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailsView:DetailsViewController=segue.destinationViewController as! DetailsViewController
            detailsView.restaurant = self.dataStore.restaurants[selectedRow] as Restaurant
            detailsView.name = self.dataStore.restaurants[selectedRow].name
            detailsView.imgName = self.dataStore.restaurants[selectedRow].picture
            print("restaurant name is \(self.dataStore.restaurants[selectedRow].name)")
        }
    }
    
    func reloadDataAndTable() {
        var uuids = extractUUIDs(nearbyBeacons)
        uuids.append("fakeUUID") // help populate w/ fake some fake restaurants
        
        print("Table view controller, uuids are \(uuids)")
        dataStore.updateRestaurants(uuids) {
            self.restaurantTableView.reloadData()
        }
    }
    
    func extractUUIDs(beacons: [CLBeacon]) -> [String] {
        return beacons.map() { beacon in
            return beacon.proximityUUID.UUIDString
        }
    }

}
