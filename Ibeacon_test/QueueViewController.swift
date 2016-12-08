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
    
    var haveReservataion:Bool?
    var timer: NSTimer?
    var dataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let reservation = self.dataStore.findReservedRestaurant() {
            self.haveReservataion = true
            updateLabels(reservation)
        }
        else{
            self.haveReservataion = false
            self.updateLabelsForNoReservation()
        }

        
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
                self.haveReservataion = false
                self.updateLabels(reservation)
            }
        }
    }
    
    private func reloadDataAndLabels(){
        dataStore.updateRestaurants(){
            if let reservation = self.dataStore.findReservedRestaurant() {
                self.haveReservataion = true
                self.updateLabels(reservation)
            }
            else{
                self.haveReservataion = false
                self.updateLabelsForNoReservation()
            }
        }
    }
    
    private func updateLabels(myReservation: Restaurant) {
        if self.haveReservataion == true{
            self.thankYouMessage.text = "Thank you for reserving at \(myReservation.name)"
            self.status.text = "Your waiting time is"
            
            self.ActualWaitingTime.text = waitingTimeText(myReservation.personal_estimated_seating_time!)
            
            self.CancelButton.hidden = false
            self.CallButton.hidden = false
        }
        else{
            self.updateLabelsForNoReservation()
        }
        
    }
    
    private func updateLabelsForNoReservation(){
        self.thankYouMessage.text = ""
        self.status.text = "You do not have any reservations"
        self.ActualWaitingTime.text = ""
        self.CancelButton.hidden = true
        self.CallButton.hidden = true
    }
    
    private func waitingTimeText(date: NSDate) -> String {
        let difference = DateDifference().difference(date)
        
        if difference.hour < 1 && difference.minute < 1 {
            self.status.text = "Your table is available now!"
            self.ActualWaitingTime.hidden = true
        }
        var output = ""

        if difference.hour == 1 {
            output += "\(difference.hour) hour"
        }
        else {
            output += "\(difference.hour) hours"
        }
        
        output += " and "
        
        if difference.minute == 1 {
            output += "\(difference.minute) minute"
        }
        else {
            output += "\(difference.minute) minutes"
        }
        
        return output
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
