//
//  CreateWalkViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class CreateWalkViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var findWalkerCopy: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var lengthPickerView: UIView!
    @IBOutlet weak var lengthPicker: UIPickerView!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var estimateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var scheduleButton: UIButton!
    var dogName: String!
    var defaults = NSUserDefaults.standardUserDefaults()
    var estimatedPrice = "$20.00"
    

    var walkDetailsRef = Firebase(url:"https://dogma.firebaseio.com/walkDetails")
    var ownerDetailsRef = Firebase(url:"https://dogma.firebaseio.com/ownerDetails")
    var firebaseRef = Firebase(url:"https://dogma.firebaseio.com")
    var walkStatusRef = Firebase(url:"https://dogma.firebaseio.com/walkStatus")

    
    
    var walkDetails = [
        "walkLocation" : "539 bryant st",
        "walkDuration" : "1hr",
        "walkTime": "7pm",
        "walkFee" : "20"
    ]

    
    var times = [ "30 minute walk", "1 hour walk", "1.5 hour walk"]
    var walkData = [
        "address": "Pickup address",
        "pickupPlaceID": "",
        "time": "",
        "duration": ""
        ]
    
    var ownerDetails = [
        "ownerImageURL" : "ownerImageURL",
        "ownerName" : "ownerName"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        defaults.setValue("dogOwner", forKey: "userType")
    
        
        ownerDetails["ownerName"] = defaults.valueForKey("ownName") as String
       // println("owner is")
      //  println(ownerDetails["ownerName"])
        
        ownerDetailsRef.setValue(ownerDetails)

        // Do any additional setup after loading the view.
        dogName = defaults.stringForKey("dogName")
        
        findWalkerCopy.text = "Find a Walker for \(dogName)"

        
        datePicker.datePickerMode = UIDatePickerMode.Time
        datePicker.minuteInterval = 15
        datePickerView.hidden = true
        lengthPickerView.hidden = true
        lengthPicker.delegate = self
        datePicker.timeZone = NSTimeZone(abbreviation: "PDT")
        
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        
        walkStatusRef.setValue("inputting")
        
        addressLabel.text = walkData["address"]
        if addressLabel.text != "Pickup address" {
            addressLabel.font = UIFont(name: addressLabel.font.fontName, size: 16)
        }
        
        checkFields()
    }
    
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }

    @IBAction func onAddressTap(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("addressSearchSegue", sender: self)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lengthLabel.text = times[row]
        
        switch row {
            case 0:
            estimatedPrice = "$20.00"
            case 1:
            estimatedPrice = "$35.00"
        case 2:
            estimatedPrice = "$50.00"
        default:
            estimatedPrice = "$20.00"
        }
        estimateLabel.text = estimatedPrice
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLengthButton(sender: AnyObject) {
        lengthPickerView.hidden = false
        datePickerView.hidden = true
        
    }
    
    @IBAction func onTimeButton(sender: AnyObject) {
        datePickerView.hidden = false
        lengthPickerView.hidden = true
        

    }
    
    func datePickerChanged(datePicker: UIDatePicker) {
        var strDate = datePicker.date
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        timeLabel.text = dateFormatter.stringFromDate(strDate)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return times[row]
    }

    @IBAction func onPickDoneButton(sender: AnyObject) {
        lengthPickerView.hidden = true
        checkFields()
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        datePickerView.hidden = true
        checkFields()
    }
    
    func checkFields() {
        if addressLabel.text != "Pickup address" && timeLabel.text != "Pickup time" {
            activateButton(scheduleButton)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FindingSegue" {
            var destinationVC = segue.destinationViewController as CreateWalkSearchViewController
            
            
            if lengthLabel.text == "30 minute walk" {
                walkData["duration"] = "30 mins"
            } else if lengthLabel.text == "1 hour walk" {
                walkData["duration"] = "1 hour"
            } else if lengthLabel.text == "1.5 hour walk" {
                walkData["duration"] = "1.5 hours"
            }
             walkData["address"] = addressLabel.text
            
            var walkDetails = [
                "walkLocation" : "25 bryant",
                "walkDuration" : "2 hours",
                "walkTime": "8:30pm",
                "walkFee" : "$200"
            ]
            
            
            //Saving walk details for sending to firebase
            walkDetails["walkLocation"] = addressLabel.text
            walkDetails["walkDuration"] = walkData["duration"]
            walkDetails["pickupPlaceID"] = walkData["pickupPlaceID"]
            walkDetails["walkFee"] = estimatedPrice
            walkDetails["walkTime"] = timeLabel.text
            
             walkDetailsRef.setValue(walkDetails)
            walkStatusRef.setValue("requested")
            
            walkData["time"] = timeLabel.text
           
            destinationVC.walkData = walkData
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

}
