//
//  WalkerActiveWalkViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 11/5/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class WalkerActiveWalkViewController: UIViewController, UIScrollViewDelegate {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var walkLocationField: UILabel!
    @IBOutlet weak var walkDurationField: UILabel!
    @IBOutlet weak var walkTimeField: UILabel!
    @IBOutlet weak var dogNameField: UILabel!
    @IBOutlet weak var callOwnerButton: UIButton!
 
    @IBOutlet weak var dogImage: UIImageView!
    
    //var walkDetailsRef = Firebase(url:"https://dogma.firebaseio.com/walkDetails")
   // var dogDetailsRef = Firebase(url:"https://dogma.firebaseio.com/dogDetails")
    var checkinsRef = Firebase(url:"https://dogma.firebaseio.com/checkins")
    var checkin1Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin1")
    var checkin2Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin2")
    var checkin3Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin3")

    var checkin1 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/1742640_741562002591024_935929873_n.jpg"
    ]
    
    var checkin2 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-d.ak.instagram.com/hphotos-ak-xaf1/10632327_364503633708115_229544745_n.jpg"
    ]
    
    var checkin3 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-e.ak.instagram.com/hphotos-ak-xaf1/10735332_1712337005658708_1599530669_n.jpg"
    ]
  
    
    var ownerName: String!
    var dogName: String!
    var walkLocation: String!
    var walkTime: String!
    var walkDuration: String!
    var defaults = NSUserDefaults.standardUserDefaults()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         checkin1Ref.setValue(checkin1)
        checkin2Ref.setValue(checkin2)
       checkin3Ref.setValue(checkin3)
        
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12
        
        dogName = defaults.stringForKey("dogName")
        walkDuration = defaults.stringForKey("walkDuration")
        walkTime = defaults.stringForKey("walkTime")
        walkLocation = defaults.stringForKey("walkLocation")
        
        dogNameField.text = dogName
        walkDurationField.text = walkDuration
        walkTimeField.text = walkTime
        walkLocationField.text = walkLocation
        
       callOwnerButton.setTitle("Contact \(dogName)'s owner", forState: UIControlState.Normal)
        
       
        
        dogImage.layer.cornerRadius = dogImage.frame.size.width/2
        dogImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
