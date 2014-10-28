//
//  CreateWalkSearchViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class CreateWalkSearchViewController: UIViewController {

    var walkData:NSDictionary!
    
    @IBOutlet weak var findingWalkerCopy: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    var defaults = NSUserDefaults.standardUserDefaults()
    var dogName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dogName = defaults.stringForKey("dogName")
        
        findingWalkerCopy.text = "Finding a Walker for \(dogName)"


        // Do any additional setup after loading the view.
        dogImage.frame.origin.x = -90
    }
    
    override func viewDidAppear(animated: Bool) {
        animateDog()
        delay(3, closure: { () -> () in
            self.performSegueWithIdentifier("foundWalkerSegue", sender: self)
        })
    }
    
    func animateDog() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0,y: 179))
        path.addCurveToPoint(CGPoint(x: 360, y: 170), controlPoint1: CGPoint(x: 136, y: 170), controlPoint2: CGPoint(x: 179, y: 170))

        let anim = CAKeyframeAnimation(keyPath: "position")

        anim.path = path.CGPath

        //anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 1.0
        dogImage.layer.addAnimation(anim, forKey: "animate position along path")
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as FoundWalkerViewController
        
        
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
