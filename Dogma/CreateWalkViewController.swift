//
//  CreateWalkViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class CreateWalkViewController: UIViewController, UIPickerViewDelegate {
    
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
    
    var times = [ "30 minute walk", "1 hour walk", "1.5 hour walk"]
    var walkData = [
        "address": "Pickup address",
        "pickupPlaceID": "",
        "time": "",
        "duration": ""
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        addressLabel.text = walkData["address"]
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
        var estimatedPrice: String
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
        if addressLabel.text != "Pickup address" && timeLabel.text != "When?" {
            scheduleButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FindingSegue" {
            var destinationVC = segue.destinationViewController as CreateWalkSearchViewController
            
            walkData["address"] = addressLabel.text
            walkData["time"] = timeLabel.text
            walkData["duration"] = lengthLabel.text
           
            destinationVC.walkData = walkData
        }
    }
}
