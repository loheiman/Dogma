//
//  ActiveWalkViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import MapKit

class ActiveWalkViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {


    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var card1Image: UIImageView!
    @IBOutlet weak var card2Image: UIImageView!
    @IBOutlet weak var card3Image: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var card1Label: UILabel!
    @IBOutlet weak var card2Label: UILabel!
    @IBOutlet weak var card3Label: UILabel!
    var defaults = NSUserDefaults.standardUserDefaults()
    var dogName: String!
    var walkerName: String!
    var walkTimeStart: NSString!
    var walkTimeEnd = "8:30pm"
    var checkin2Location = "Dolores Park"
    var clickedIndex = 0
    var isPresenting: Bool = true
    var cardImageToPass: UIImageView = UIImageView()
    var walkDuration: String!

    var walkData: NSDictionary! //contains the Create Walk Data
    
    
    var checkinsRef = Firebase(url:"https://dogma.firebaseio.com/checkins")
    var checkin1Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin1")
    var checkin2Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin2")
    var checkin3Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin3")

    var walkCheckins = [
        [
            "image": "checkin-blank",
            "lat": 44,
            "lng": 44,
            "details": "Jim will pickup Spike at ",
            "done": false

        ],
        [
            "image": "checkin-blank",
            "lat": 44,
            "lng": 44,
            "details": "Jim will take a photo of Spike during the walk",
            "done": false
        ],
        [
            "image": "checkin-blank",
            "lat": 44,
            "lng": 44,
            "details": "Jim will drop Spike off at around",
            "done": false
        ]
    ]
    
    
    var checkin1 = [
        "status" : "incomplete",
        "location" : "location",
        "imageURL": "imageURL",
        "lat": 23,
        "lng": 22,
        "imageString": "imageString"
    ]
    
    var checkin2 = [
        "status" : "incomplete",
        "location" : "location",
        "imageURL": "imageURL",
        "lat": 23,
        "lng": 22,
        "imageString": "imageString"
    ]
    
    var checkin3 = [
        "status" : "incomplete",
        "location" : "location",
        "imageURL": "imageURL",
        "lat": 23,
        "lng": 22,
        "imageString": "imageString"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkin1Ref.setValue(checkin1)
        checkin2Ref.setValue(checkin2)
        checkin3Ref.setValue(checkin3)
        
        checkinsRef.observeEventType(FEventType.Value, withBlock: { (snapshot: FDataSnapshot!) -> Void in
           
            self.checkin1 = snapshot.value.valueForKeyPath("checkin1") as Dictionary
            self.checkin2 = snapshot.value.valueForKeyPath("checkin2") as Dictionary
            self.checkin3 = snapshot.value.valueForKeyPath("checkin3") as Dictionary
           
            
            if self.checkin1["status"] == "complete" {
                self.walkCheckin1done(self.checkin1)
            }
            
            if self.checkin2["status"] == "complete" {
                self.walkCheckin2done(self.checkin2)
            }
            
            if self.checkin3["status"] == "complete" {
                self.walkCheckin3done(self.checkin3)
            }
            
            
        })

        
        
        dogName = defaults.stringForKey("dogName")
        walkerName = defaults.stringForKey("walkerName")
        rateButton.setTitle("Rate \(walkerName)", forState: UIControlState.Normal)
        
        callButton.setTitle("Contact \(walkerName)", forState: UIControlState.Normal)
        walkDuration = walkData["duration"] as String
        
        card1Image.hidden = true
        card2Image.hidden = true
        card3Image.hidden = true
        
       
        
        walkTimeStart = walkData["time"] as String
        
        
        walkCheckins[0]["details"] = "\(walkerName) will pickup \(dogName) at \(walkTimeStart)"
       
        walkCheckins[1]["details"] = "\(walkerName) will take another photo of \(dogName) mid-walk"
        
        walkCheckins[2]["details"] = "\(walkerName) will drop \(dogName) off \(walkDuration) later"
        
        rateButton.hidden = true
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12

        card1Label.text = walkCheckins[0]["details"] as? String
        card2Label.text = walkCheckins[1]["details"] as? String
        card3Label.text = walkCheckins[2]["details"] as? String
        
        

    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func walkCheckin1done(checkin: NSDictionary) {
      //  walkCheckins[0]["image"] = checkin.valueForKey("imageURL") as? String
        walkCheckins[0]["lat"] = checkin.valueForKey("lat") as Double
        walkCheckins[0]["lng"] = checkin.valueForKey("lng") as Double
        
        var imageString = checkin.valueForKey("imageString") as String
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions(0))
        var decodedImage = UIImage(data: decodedData!)
        card1Image.image = decodedImage as UIImage!
        card1Image.contentMode = UIViewContentMode.ScaleAspectFill
        card1Image.hidden = false
        
        //card1Image.image = UIImage(data: imageData!)!
        
        walkCheckins[0]["details"] = "\(walkerName) picked up \(dogName)"
         card1Label.text = walkCheckins[0]["details"] as? String
        walkCheckins[0]["done"] = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = 0
        })

    }
    
    
    func walkCheckin2done(checkin: NSDictionary) {
       // walkCheckins[1]["image"] = checkin.valueForKey("imageURL") as? String
       // walkCheckins[1]["pickupPlaceID"] = checkin.valueForKey("location") as String
        walkCheckins[1]["lat"] = checkin.valueForKey("lat") as Double
        walkCheckins[1]["lng"] = checkin.valueForKey("lng") as Double
        
        var imageString = checkin.valueForKey("imageString") as String
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions(0))
        var decodedImage = UIImage(data: decodedData!)
        card2Image.image = decodedImage as UIImage!
        card2Image.contentMode = UIViewContentMode.ScaleAspectFill
        
        card2Image.hidden = false
        walkCheckins[1]["details"]! = "\(walkerName) took a second photo of \(dogName)"
        card2Label.text = walkCheckins[1]["details"] as? String
        walkCheckins[1]["done"] = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width)
        })
    }
    
    
    func walkCheckin3done(checkin: NSDictionary) {
       // walkCheckins[2]["image"] = checkin.valueForKey("imageURL") as? String
        walkCheckins[2]["lat"] = checkin.valueForKey("lat") as Double
        walkCheckins[2]["lng"] = checkin.valueForKey("lng") as Double
        
        var imageString = checkin.valueForKey("imageString") as String
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions(0))
        var decodedImage = UIImage(data: decodedData!)
        card3Image.image = decodedImage as UIImage!
        card3Image.contentMode = UIViewContentMode.ScaleAspectFill
        
        card3Image.hidden = false
        walkCheckins[2]["details"]  = "\(walkerName) returned \(dogName) home safely"
        card3Label.text = walkCheckins[2]["details"] as? String
        walkCheckins[2]["done"] = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width * 2)
        })
    }

    
    
    
    @IBAction func onCheckinTap(sender: UITapGestureRecognizer) {
        clickedIndex = sender.view!.tag
        performSegueWithIdentifier("PhotoDetailSegue", sender: self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.x

        switch offset {
        case 0:
            pageControl.currentPage = 0

        case scrollView.frame.size.width:
            pageControl.currentPage = 1

        case scrollView.frame.size.width * 2:
            pageControl.currentPage = 2
            
            if walkCheckins[2]["done"] == 1 {
                rateButton.hidden = false
                activateButton(rateButton)
                callButton.hidden = true
            }
        default:
            pageControl.currentPage = pageControl.currentPage
        }

    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if segue.identifier == "PhotoDetailSegue" {
            var destinationVC = segue.destinationViewController as PhotoDetailViewController
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationVC.transitioningDelegate = self
            
            var checkin = walkCheckins[clickedIndex]

        //    destinationVC.pickupPlaceID = walkData["pickupPlaceID"]! as String
            destinationVC.lat = walkCheckins[clickedIndex]["lat"]! as Double
            destinationVC.lng = walkCheckins[clickedIndex]["lng"]! as Double
            
            
            
            switch clickedIndex {
                case 0:
                    
                    destinationVC.walkImage.image = card1Image.image!
                    cardImageToPass.image = card1Image.image!
                    
                    var window = UIApplication.sharedApplication().keyWindow!
                    var frame = window.convertRect(card1Image.frame, fromView: card1Image.superview)
                    cardImageToPass.frame = frame
                case 1:
                    destinationVC.walkImage.image = card2Image.image!
                    cardImageToPass.image = card2Image.image!
                    
                   // destinationVC.pickupPlaceID = walkCheckins[1]["pickupPlaceID"]! as String
                    
                    var window = UIApplication.sharedApplication().keyWindow!
                    var frame = window.convertRect(card2Image.frame, fromView: card2Image.superview)
                    cardImageToPass.frame = frame
                case 2:
                    destinationVC.walkImage.image = card3Image.image!
                    cardImageToPass.image = card3Image.image!
                
                    var window = UIApplication.sharedApplication().keyWindow!
                    var frame = window.convertRect(card3Image.frame, fromView: card3Image.superview)
                    cardImageToPass.frame = frame
                default:
                    destinationVC.walkImage.image = card1Image.image!
                    cardImageToPass.image = card1Image.image!
                    cardImageToPass.frame = card1Image.frame
            }
            destinationVC.details = checkin["details"] as String
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var window = UIApplication.sharedApplication().keyWindow!
        var newImageView: UIImageView = UIImageView(frame: cardImageToPass.frame)
        
        newImageView.image = cardImageToPass.image
        
        var finalFrame = CGRect(x: 0, y: 0, width: 320, height: 320)
    
        newImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        if (isPresenting) {
            window.addSubview(newImageView)
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                newImageView.frame = finalFrame
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    newImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            newImageView.frame = finalFrame
            window.addSubview(newImageView)
            fromViewController.view.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                newImageView.frame = self.cardImageToPass.frame
                newImageView.contentMode = UIViewContentMode.ScaleAspectFit
                
                }) { (finished: Bool) -> Void in
                    newImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }

    @IBAction func onCallButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://4155356806")!)
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


