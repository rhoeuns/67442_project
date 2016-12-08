//
//  NBRestaurantViewController.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/2/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit

class NBRestaurantViewController: UITableViewController {

    var dataStore = DataStore()
    
//    @IBOutlet weak var refreshButton: UIBarButtonItem!

    @IBOutlet var restaurantTableView: UITableView!
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
//        let restaurants = dataStore.restaurants
        self.dataStore.updateRestaurants() {
            self.restaurantTableView.reloadData()
        }
=======
        
//        reloadDataAndTable()
>>>>>>> 65ce3af4770c5f8207290927bd9c8369a38a766a

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
//        let oneHourFromNow = NSDate(timeIntervalSinceNow: 3600)
//        let timer = Timer(date: oneHourFromNow)
//        timer.countdownTilSeating()
//        timer.loop() {
//            print("loop~")
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.timer = Timer().loop(interval: 3.0) {
            self.reloadDataAndTable()
            print("loop")
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

<<<<<<< HEAD
 //   @IBAction func refreshTapped(sender: AnyObject) {
 //       dataStore.updateRestaurants() {
 //           self.restaurantTableView.reloadData()
 //       }
 //   }
=======
    @IBAction func refreshTapped(sender: AnyObject) {
        reloadDataAndTable()
    }
    
    func reloadDataAndTable() {
        dataStore.updateRestaurants() {
            self.restaurantTableView.reloadData()
        }
    }
>>>>>>> 65ce3af4770c5f8207290927bd9c8369a38a766a

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\(self.dataStore.restaurants[indexPath.row].name)"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
