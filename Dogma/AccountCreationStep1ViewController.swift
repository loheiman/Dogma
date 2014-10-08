//
//  AccountCreationStep1ViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class AccountCreationStep1ViewController: UIViewController {

    
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var creditCardNumberField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // creditCardNumberField.becomeFirstResponder()

        // Do any additional setup after loading the view.
        
        scrollView.frame.size.width = 320

        scrollView.contentSize = CGSize(width: 960, height: 480)
        
        nextButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.scrollView.contentOffset.x += 320
            }) { (Finished: Bool) -> Void in
            //
        }
        
        nextButton.hidden = true
    
    }

    @IBAction func phoneNumberChanged(sender: AnyObject) {
    
        if phoneNumberField.text == "1" {
            creditCardNumberField.becomeFirstResponder()
        }
    }
    
    
    @IBAction func creditCardNumberChanged(sender: AnyObject) {
        if countElements(creditCardNumberField.text) == 16 {
            println("good")
        }
        nextButton.hidden = false
    }
    
    @IBAction func addressChanged(sender: AnyObject) {
          nextButton.hidden = false
        println("address change")
    }
    
    @IBAction func dogNameChanged(sender: AnyObject) {
        
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
