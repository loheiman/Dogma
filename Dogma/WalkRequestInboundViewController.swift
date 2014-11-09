//
//  WalkRequestInboundViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 11/5/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import Mapkit

class WalkRequestInboundViewController: UIViewController {

 
   
@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var walkFeeField: UILabel!
    @IBOutlet weak var walkLocationField: UILabel!
    @IBOutlet weak var walkDurationField: UILabel!
    @IBOutlet weak var walkTimeField: UILabel!
    @IBOutlet weak var dogNameField: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    
   
    var walkDetailsRef = Firebase(url:"https://dogma.firebaseio.com/walkDetails")
    var dogDetailsRef = Firebase(url:"https://dogma.firebaseio.com/dogDetails")
    var walkStatusRef = Firebase(url:"https://dogma.firebaseio.com/walkStatus")
    
    
    override func viewWillAppear(animated: Bool) {
        walkDetailsRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
            self.walkFeeField.text = snapshot.value.valueForKey("walkFee") as? String
            self.walkLocationField.text = snapshot.value.valueForKey("walkLocation") as? String
            self.walkDurationField.text = snapshot.value.valueForKey("walkDuration") as? String
            self.walkTimeField.text = snapshot.value.valueForKey("walkTime") as? String
        })
        
        
        dogDetailsRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
            self.dogNameField.text = snapshot.value.valueForKey("dogName") as? String
            
        })
        
        
        dogImage.layer.cornerRadius = dogImage.frame.size.width/2
        dogImage.clipsToBounds = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        walkDetailsRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
            self.walkFeeField.text = snapshot.value.valueForKey("walkFee") as? String
             self.walkLocationField.text = snapshot.value.valueForKey("walkLocation") as? String
             self.walkDurationField.text = snapshot.value.valueForKey("walkDuration") as? String
             self.walkTimeField.text = snapshot.value.valueForKey("walkTime") as? String
        })
        
        
        ownerDetailsRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
            self.dogNameField.text = snapshot.value.valueForKey("dogName") as? String

        })
        

        dogImage.layer.cornerRadius = dogImage.frame.size.width/2
        dogImage.clipsToBounds = true
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func onAcceptWalkButtonTap(sender: AnyObject) {
        walkStatusRef.setValue("accepted")
    }

}
