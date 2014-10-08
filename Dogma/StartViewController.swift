//
//  StartViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIAlertViewDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onFacebookLoginTap(sender: AnyObject) {
        
        var loginAlertView = UIAlertView(title: "Facebook", message: "Dogma would like to access your basic profile info", delegate: self, cancelButtonTitle: "Don't Allow", otherButtonTitles: "OK")
        loginAlertView.show()
        
        }
    
    func alertView(loginAlertview: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        
        if buttonIndex == 0 {
            println("Don't Allow")
        }
        
        if buttonIndex == 1 {
            println("OK")
            performSegueWithIdentifier("toAccountCreationSegue", sender: self)
        }
        // buttonIndex is 0 for Cancel
        // buttonIndex ranges from 1-n for the other buttons.
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
