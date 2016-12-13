//
//  DetailsViewController.swift
//  Ibeacon_test
//
//  Created by RhoEun Song on 12/8/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOfURL: url) {
                self.image = UIImage(data: data)
            }
        }
    }
}

class DetailsViewController: UIViewController {
    var name:String?
    var imgName:String?
    
    var restaurant:Restaurant?
    var talbeInLine:String?
    var waitingTiem:String?
    
    var timer: NSTimer?

    var dataStore = DataStore()
    
    @IBOutlet weak var teamNumber: UITextField!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var waitTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgURL = imgName
        storeImage.setImageFromURl(stringImageUrl: imgURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "\(self.name!)"
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.timer = Timer().loop(interval: 1.5) {
            self.dataStore.updateRestaurant(self.restaurant!) { updatedRestaurant in
                self.restaurant = updatedRestaurant
                self.updateLabels()
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    
    @IBAction func reserveTapped(sender: UIButton) {
        let input = self.teamNumber.text!
        self.dataStore.updateRestaurants(){
            if let reservation = self.dataStore.findReservedRestaurant(){
                let alertController = UIAlertController(title: "Sorry", message:
                    "You can only make one reservation at a time", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) in
                    print("You've pressed OK button");
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:nil)
            }
            else{
                let alertController = UIAlertController(title: "Error", message:
                    "Please type in number of people for your team. Thank you", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction) in
                    print("You've pressed OK button");
                }
                alertController.addAction(OKAction)
                if input == ""  {
                    print("no team number inputed \(input)")
                    self.presentViewController(alertController, animated: true, completion:nil)
                }
                else{
                    self.dataStore.updateMakeReservation(self.restaurant!, party_size: Int(self.teamNumber.text!)!, completionHandler: {
                        // Switch to the reservation page, and also pop the previous view
                        self.tabBarController?.selectedIndex = 1
                        self.navigationController?.popViewControllerAnimated(false)
                        self.teamNumber.text = " "

                    })
                }
            }
        }
    }
    
    func updateLabels() {
        let diff = DateDifference(date: restaurant!.generalEstimatedSeatingTime)
        
        if diff.isAvailableNow() {
            waitTimeLabel.text = "There's no wait time!"
        }
        else {
            waitTimeLabel.text = diff.waitingTimeText()
        }
    }
}
