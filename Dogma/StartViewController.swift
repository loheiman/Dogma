//
//  StartViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var ownerDetailsRef = Firebase(url:"https://dogma.firebaseio.com/ownerDetails")
    var ownerDetails = [
        "ownerName": "ownerName",
        "ownerImage": "ownerImageURL"
    ]

    var readPermissions = ["public_profile", "email", "user_friends"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.setValue("ownName", forKey: "ownName")

        self.fbLoginView.delegate = self
        logoImage.frame.origin.y = 223
        welcomeLabel.alpha = 0
        welcomeLabel.frame.origin.y -= 100

    }

    override func viewDidAppear(animated: Bool) {

        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.logoImage.frame.origin.y = 30
            self.welcomeLabel.alpha = 1
            self.welcomeLabel.frame.origin.y += 100
            }) { (finished:Bool) -> Void in
            // done
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        println("This is where you perform a segue.")
        
        if defaults.boolForKey("dogInfoEntered") == true {
            performSegueWithIdentifier("startToCreateWalkSegue", sender: self)
        }
        
        else {
            performSegueWithIdentifier("toAccountCreationSegue", sender: self)
        }
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){

        let fullName = user.name
        let fullNameArray = fullName.componentsSeparatedByString(" ")
        let firstName = fullNameArray[0]
        defaults.setValue(firstName, forKey: "ownName")
      // println(firstName)
     /*
        var profilePictureView : FBProfilePictureView!
        profilePictureView.profileID = user.objectID
      */  
      //  var profileImage = profilePictureView.image as UIImage
 
        
    }

    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }

    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }



}
