//
//  FoundWalkerViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/19/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class FoundWalkerViewController: UIViewController {

    var walkData:NSDictionary!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var walkerDetailsCopy: UILabel!
    var dogName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dogName = defaults.stringForKey("dogName")
        
        walkerDetailsCopy.text = "Jim will walk \(dogName)!"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as ActiveWalkViewController

        destinationVC.walkData = walkData
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
