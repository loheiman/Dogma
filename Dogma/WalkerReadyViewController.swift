//
//  WalkerReadyViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 11/5/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class WalkerReadyViewController: UIViewController {

    @IBOutlet weak var dogSpinnerImageView: UIImageView!
    @IBOutlet weak var activateWalkingButton: UIButton!
    @IBOutlet weak var readyToWalkCopy: UILabel!
    @IBOutlet weak var waitingForWalkRequestCopy: UILabel!
    @IBOutlet weak var doneWalkingButton: UIButton!
    
    var firebaseRef = Firebase(url:"https://dogma.firebaseio.com")
    
    var lat: CLLocationDegrees!
    var lng: CLLocationDegrees!
   
    
    var walkStatus: String!
    var userType: String!
    
    var walkDetails = [
        "pickupPlaceID": "sldkgjsg",
        "walkDuration": "6 hours",
        "walkFee": "$22",
        "walkLocation": "Bolvia boo",
        "walkTime": "4:44pm"
    ]
    
    var dogDetails = [
        "dogImageString" : "dogImageString",
        "dogrName" : "dogName"
    ]
    
    
    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogSpinnerImageView.alpha = 0.5
        // Do any additional setup after loading the view.
        
        userType = defaults.valueForKey("userType") as String
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        deactivateWalking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
        firebaseRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
            
            self.dogDetails = snapshot.value.valueForKey("dogDetails") as Dictionary
            self.walkDetails = snapshot.value.valueForKey("walkDetails") as Dictionary
            
            self.walkStatus = snapshot.value.valueForKey("walkStatus") as? String
            
            
            var pickupPlaceID = self.walkDetails["pickupPlaceID"]
            
            print("PICKUP PLACE ID \(pickupPlaceID!)")
            
          
            if self.walkStatus == "requested" && self.userType == "walker" {
            
                
                var url = NSURL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + pickupPlaceID! + "&key=AIzaSyBR25mbykImkoIribmzpCFXLAuvPkfqCio")
                var request = NSURLRequest(URL: url!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                    var objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    var result = objects["result"] as NSDictionary
                    var geometry = result["geometry"] as NSDictionary
                    var locations = geometry["location"] as NSDictionary
                    
                    self.lat = locations["lat"] as CLLocationDegrees
                    self.lng = locations["lng"] as CLLocationDegrees
                    
                    println(self.lat)
                    println(self.lng)
                }
                
               // if self.lat != nil && self.lng != nil {
                    
                    self.performSegueWithIdentifier("toWalkRequestInboundSegue", sender: self)
               // }
                
                
            }
        })
    }

    
    
    
    @IBAction func onActivateWalkingButtonTap(sender: AnyObject) {
        activateWalking()
        spinDog()
        
    }
    
    @IBAction func onDoneWalkingButtonTap(sender: AnyObject) {
        deactivateWalking()
    }
    
    func activateWalking() {
        readyToWalkCopy.hidden = true
        activateWalkingButton.hidden = true
        doneWalkingButton.hidden = false
        waitingForWalkRequestCopy.hidden = false
        dogSpinnerImageView.hidden = false
    }
    
    func deactivateWalking() {
        readyToWalkCopy.hidden = false
        activateWalkingButton.hidden = false
        doneWalkingButton.hidden = true
        waitingForWalkRequestCopy.hidden = true
        dogSpinnerImageView.hidden = true
    }
    
    func spinDog() {
        
        UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
           //self.dogSpinnerImageView.transform = CGAffineTransformRotate(self.dogSpinnerImageView.transform, 6 )
            self.dogSpinnerImageView.transform = CGAffineTransformMakeRotation(-0.5)
            }) { (Finished: Bool) -> Void in
        
        }
        
    }

    func activateButton (sender: UIButton) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            sender.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }) { (Finished: Bool) -> Void in
                sender.enabled = true
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }) { (Finished: Bool) -> Void in
                        //
                }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            var destinationVC = segue.destinationViewController as WalkRequestInboundViewController
            destinationVC.walkDetails = walkDetails
            destinationVC.dogDetails = dogDetails
            destinationVC.lat = lat
            destinationVC.lng = lng
        
    }
    
    
    
}
