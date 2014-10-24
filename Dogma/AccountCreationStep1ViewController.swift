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
    @IBOutlet weak var creditCardNumberField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // creditCardNumberField.becomeFirstResponder()
        
        scrollView.frame.size.width = 320

        scrollView.contentSize = CGSize(width: 640, height: 506)
        
        nextButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        if scrollView.contentOffset.x < scrollView.frame.size.width * 2 {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.scrollView.contentOffset.x += 320
                }) { (Finished: Bool) -> Void in
                    //
            }
        }
        
        nextButton.enabled = false
    
    }
    
    @IBAction func phoneNumberChanged(sender: AnyObject) {
        if countElements(phoneNumberField.text) == 10 {
            creditCardNumberField.becomeFirstResponder()
        }
    }
    
    @IBAction func onCreditCardChanged(sender: AnyObject) {
        if countElements(creditCardNumberField.text) == 16 {
            nextButton.enabled = true
        }
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
