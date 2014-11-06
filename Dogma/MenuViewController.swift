//
//  MenuViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/26/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var walkerButton: UIButton!
    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if defaults.boolForKey("isWalker") == true {
          //  walkerButton.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logUserOut(sender: AnyObject) {
        FBSession.activeSession().closeAndClearTokenInformation()
        self.performSegueWithIdentifier("backToStart", sender: self)
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onClearDefaultsButton(sender: AnyObject) {
        defaults.removeObjectForKey("dogName")
        defaults.removeObjectForKey("dogImage")
        defaults.removeObjectForKey("phoneNumberCreditCardEntered")
        defaults.removeObjectForKey("dogInfoEntered")
        
    }
    
    @IBAction func onWalkerButtonTap(sender: AnyObject) {
        defaults.setBool(true, forKey: "isWalker")
    }
}
