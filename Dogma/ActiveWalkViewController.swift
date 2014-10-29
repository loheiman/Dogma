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
    var walkTimeStart: NSString!
    var walkTimeEnd = "8:30pm"
    var checkin2Location = "Dolores Park"
    var clickedIndex = 0
    var isPresenting: Bool = true
    var cardImageToPass: UIImageView = UIImageView()
    
    var walkData: NSDictionary! //contains the Create Walk Data

    var walkCheckins = [
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will pickup Spike at ",
            "done": false

        ],
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will take a photo of Spike during the walk",
            "done": false
        ],
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will drop Spike off at around",
            "done": false
        ]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card1Image.hidden = true
        card2Image.hidden = true
        card3Image.hidden = true
        
        dogName = defaults.stringForKey("dogName")
        
        walkTimeStart = walkData["time"] as String
        
        
        walkCheckins[0]["details"] = "Jim will pickup \(dogName) at \(walkTimeStart)"
       
        walkCheckins[1]["details"] = "Jim will take a photo of \(dogName) during the walk"
        
        walkCheckins[2]["details"] = "Jim will drop \(dogName) off at around \(walkTimeEnd)"
        
        rateButton.hidden = true
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12

        card1Label.text = walkCheckins[0]["details"] as? String
        card2Label.text = walkCheckins[1]["details"] as? String
        card3Label.text = walkCheckins[2]["details"] as? String
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "walkCheckin:", name: "ShowImage", object: nil)

    }
    
    func walkCheckin(notification: NSNotification) {
        println(notification)

        var data: NSDictionary = notification.valueForKey("object") as NSDictionary
        
        var walkStep = data.valueForKey("walkStep") as String
        
        switch walkStep {
            case "1":
                walkCheckin1done(data)
            case "2":
                walkCheckin2done(data)
            case "3":
                walkCheckin3done(data)
            default:
                println("invalid walkStep value")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func walkCheckin1done(data: NSDictionary) {
        walkCheckins[0]["image"] = data.valueForKey("imageURL") as String
        
        var url = NSURL(string: data.valueForKey("imageURL") as String)
        var imageData: NSData = NSData(contentsOfURL: url!)!
        card1Image.hidden = false
        card1Image.image = UIImage(data: imageData)
        walkCheckins[0]["details"] = "Jim picked up \(dogName) at \(walkTimeStart)"
         card1Label.text = walkCheckins[0]["details"] as? String
        walkCheckins[0]["done"] = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.contentOffset.x = 0
        })

    }
    
    func walkCheckin2done(data: NSDictionary) {
        walkCheckins[1]["image"] = data.valueForKey("imageURL") as String
        
        var url = NSURL(string: data.valueForKey("imageURL") as String)
        var imageData: NSData = NSData(contentsOfURL: url!)!
        card2Image.hidden = false
        card2Image.image = UIImage(data: imageData)
        walkCheckins[1]["details"]! = "Jim took a photo of \(dogName) at \(checkin2Location)"
        card2Label.text = walkCheckins[1]["details"] as? String
        walkCheckins[1]["done"] = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            println("here")
            self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width)
        })
    }
    
    func walkCheckin3done(data: NSDictionary) {
        walkCheckins[2]["image"] = data.valueForKey("imageURL") as String
        
        var url = NSURL(string: data.valueForKey("imageURL") as String)
        var imageData: NSData = NSData(contentsOfURL: url!)!
        card3Image.hidden = false
        card3Image.image = UIImage(data: imageData)
        walkCheckins[2]["details"]  = "Jim dropped \(dogName) off at \(walkTimeEnd)"
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

            destinationVC.pickupPlaceID = walkData["pickupPlaceID"]! as String
            switch clickedIndex {
                case 0:
                    println(card1Image.frame)
                    destinationVC.walkImage.image = card1Image.image!
                    cardImageToPass.image = card1Image.image!
                    
                    var window = UIApplication.sharedApplication().keyWindow!
                    var frame = window.convertRect(card1Image.frame, fromView: card1Image.superview)
                    cardImageToPass.frame = frame
                case 1:
                    destinationVC.walkImage.image = card2Image.image!
                    cardImageToPass.image = card2Image.image!
                
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
}
