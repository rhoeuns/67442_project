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
    
    var dataStore = DataStore()
    
    @IBOutlet weak var teamNumber: UITextField!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var reserveButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        // navigationItem.title = "One"
        navigationItem.title = "\(self.name!)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Name \(self.name). and img url is \(self.imgName)")
        storeName.text = name
        let imgURL = imgName
        storeImage.setImageFromURl(stringImageUrl: imgURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reserveTapped(sender: UIButton) {
        self.dataStore.updateMakeReservation(self.restaurant!, party_size: Int(self.teamNumber.text!)!, completionHandler: {})
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
