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
    
    var dataStore = DataStore()

    private var myReservation: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findReservedRestaurant()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func CancelTapped(sender: UIButton) {
    }
    
    private func findReservedRestaurant(){
        dataStore.updateRestaurants(){
            let restaurants = self.dataStore.restaurants
            self.myReservation = restaurants.filter{$0.personal_estimated_seating_time != nil}
            if let myReservation = self.myReservation {
                if (myReservation.count > 0) {
                    self.thankYouMessage.text = "Thank you for reserving at \(myReservation[0].name)"
                }
            }
        }
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
