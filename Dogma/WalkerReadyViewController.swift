//
//  WalkerReadyViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 11/5/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class WalkerReadyViewController: UIViewController {

    @IBOutlet weak var dogSpinnerImageView: UIImageView!
    @IBOutlet weak var activateWalkingButton: UIButton!
    @IBOutlet weak var readyToWalkCopy: UILabel!
    @IBOutlet weak var waitingForWalkRequestCopy: UILabel!
    @IBOutlet weak var doneWalkingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogSpinnerImageView.alpha = 0.5
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        deactivateWalking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onActivateWalkingButtonTap(sender: AnyObject) {
        activateWalking()
        spinDog()
        
    }
    
    @IBAction func onDoneWalkingButtonTap(sender: AnyObject) {
        deactivateWalking()
    }
    
    func activateWalking() {
        readyToWalkCopy.hidden = true
        activateWalkingButton.hidden = true
        doneWalkingButton.hidden = false
        waitingForWalkRequestCopy.hidden = false
        dogSpinnerImageView.hidden = false
    }
    
    func deactivateWalking() {
        readyToWalkCopy.hidden = false
        activateWalkingButton.hidden = false
        doneWalkingButton.hidden = true
        waitingForWalkRequestCopy.hidden = true
        dogSpinnerImageView.hidden = true
    }
    
    func spinDog() {
        
        UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
           //self.dogSpinnerImageView.transform = CGAffineTransformRotate(self.dogSpinnerImageView.transform, 6 )
            self.dogSpinnerImageView.transform = CGAffineTransformMakeRotation(-2)
            }) { (Finished: Bool) -> Void in
            println()
        }
        
    }

    func activateButton (sender: UIButton) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            sender.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }) { (Finished: Bool) -> Void in
                sender.enabled = true
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }) { (Finished: Bool) -> Void in
                        //
                }
        }
    }
    
}
