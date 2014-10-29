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
    
    @IBOutlet weak var foundWalkerCopy: UILabel!
    @IBOutlet weak var walkerImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var viewWalkButton: UIButton!
    @IBOutlet weak var findingWalkerCopy: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    var defaults = NSUserDefaults.standardUserDefaults()
    var dogName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walkerImageView.hidden = true
        walkerImageView.frame.origin.y = -150
        viewWalkButton.hidden = true
        
        
        dogName = defaults.stringForKey("dogName")
        
        findingWalkerCopy.text = "Finding a Walker for \(dogName)"
        foundWalkerCopy.text = "Jim will walk \(self.dogName)!"
        
        foundWalkerCopy.transform = CGAffineTransformMakeScale(0.7, 0.7)
        foundWalkerCopy.hidden = true

        // Do any additional setup after loading the view.
        dogImage.frame.origin.x = -90
    }
    
    override func viewDidAppear(animated: Bool) {
        animateDog()
    
        
        delay(4, closure: { () -> () in
            self.walkerImageView.hidden = false
            self.dogImage.hidden = true
            self.cancelButton.hidden = true
            self.findingWalkerCopy.hidden = true
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.findingWalkerCopy.layer.opacity = 0
                }, completion: { (Finished: Bool) -> Void in
                self.findingWalkerCopy.hidden = true
                    self.foundWalkerCopy.hidden = false
                    
                    UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                        self.foundWalkerCopy.transform = CGAffineTransformMakeScale(1, 1)
                        }, completion: { (Finished: Bool) -> Void in
                        //
                    })
            })
            
            UIView.animateWithDuration(0.5, delay: 0.8, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: nil, animations: { () -> Void in
                self.walkerImageView.frame.origin.y = 150
                }, completion: { (Finished: Bool) -> Void in
                    
                    self.findingWalkerCopy.layer.opacity = 1
                    self.viewWalkButton.hidden = false
            })
        })
    }
    
    func animateDog() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0,y: 229))
        path.addCurveToPoint(CGPoint(x: 360, y: 220), controlPoint1: CGPoint(x: 136, y: 220), controlPoint2: CGPoint(x: 179, y: 220))

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
