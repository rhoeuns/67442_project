//
//  QueueViewController.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/6/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit

class QueueViewController: UIViewController {

    @IBOutlet weak var thankYouMessage: UILabel!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var CallButton: UIButton!
    @IBOutlet weak var ActualWaitingTime: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var timer: NSTimer?
    var dataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.timer = Timer().loop(interval: 1.5) {
            self.reloadDataAndLabels()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }

    
    @IBAction func canceltapped(sender: UIButton) {
        if let reservation = dataStore.findReservedRestaurant() {
            dataStore.updateCancelReservation(reservation) {
                self.updateLabels(reservation)
            }
        }
    }
    
    private func reloadDataAndLabels(){
        dataStore.updateRestaurants(){
            if let reservation = self.dataStore.findReservedRestaurant() {
                self.updateLabels(reservation)
            }
            else{
                self.updateLabelsForNoReservation()
            }
        }
    }
    
    private func updateLabels(myReservation: Restaurant) {
        self.thankYouMessage.text = "Thank you for reserving at \(myReservation.name)"
        self.status.text = "Your waiting time is"
        
        let diff = DateDifference(date: myReservation.personal_estimated_seating_time!)
        if diff.isAvailableNow() {
            self.status.text = ""
            self.ActualWaitingTime.text = "Your table is available now!"
        }
        else {
            self.ActualWaitingTime.text = diff.waitingTimeText()
        }
        
        self.CancelButton.hidden = false
        self.CallButton.hidden = false
    }
    
    private func updateLabelsForNoReservation(){
        self.thankYouMessage.text = ""
        self.status.text = "You do not have any reservations"
        self.ActualWaitingTime.text = ""
        self.CancelButton.hidden = true
        self.CallButton.hidden = true
    }
    
    private func calculateTime(){
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Hour, .Minute], fromDate: date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
