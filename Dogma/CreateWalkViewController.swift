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
    
    var times = [ "30 minutes", "1 hour", "1.5 hours"]
    
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
    
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int {
        println("at numberOfComponents")
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
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
        println(strDate)
        timeLabel.text = dateFormatter.stringFromDate(strDate)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return times[row]
    }

    @IBAction func onPickDoneButton(sender: AnyObject) {
        lengthPickerView.hidden = true
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        datePickerView.hidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
