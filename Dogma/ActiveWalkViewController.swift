//
//  ActiveWalkViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import MapKit

class ActiveWalkViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var card1Image: UIImageView!
    @IBOutlet weak var card2Image: UIImageView!
    @IBOutlet weak var card3Image: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var card1Label: UILabel!
    @IBOutlet weak var card2Label: UILabel!
    @IBOutlet weak var card3Label: UILabel!
    var walkTimeStart: NSString!
    var walkTimeEnd = "8:30pm"
    var checkin2Location = "Dolores Park"
    var clickedIndex = 0
    
    var walkData: NSDictionary! //contains the Create Walk Data

    var walkCheckins = [
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will pickup Spike at ",
            "done": 0

        ],
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will take a photo of Spike during the walk",
            "done": 0
        ],
        [
            "image": "checkin-blank",
            "lat": "",
            "lng": "",
            "details": "Jim will drop Spike off at around",
            "done": 0
        ]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walkTimeStart = walkData["time"] as String
        
        
        walkCheckins[0]["details"] = "Jim will pickup Spike at \(walkTimeStart)"
       
        walkCheckins[1]["details"] = "Jim will take a photo of Spike during the walk"
        
        walkCheckins[2]["details"] = "Jim will drop Spike off at around \(walkTimeEnd)"
        
       
        
        rateButton.hidden = true
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12
        
        
        card1Image.image = UIImage(named: "checkin-blank")
        card2Image.image = UIImage(named: "checkin-blank")
        card3Image.image = UIImage(named: "checkin-blank")
        
        
        card1Label.text = walkCheckins[0]["details"] as? String
        card2Label.text = walkCheckins[1]["details"] as? String
        card3Label.text = walkCheckins[2]["details"] as? String
        
        /*
        walkCheckin1done()
        walkCheckin2done()
        walkCheckin3done()
*/
      //  println(walkData["pickupPlaceID"]!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PhotoDetailSegue" {
            println("here")
            var destinationVC = segue.destinationViewController as PhotoDetailViewController
            var checkin = walkCheckins[clickedIndex]
        
            destinationVC.pickupPlaceID = walkData["pickupPlaceID"]! as String
            destinationVC.imageString = checkin["image"] as String
            destinationVC.details = checkin["details"] as String

        }
        
    }
    
    
    func walkCheckin1done() {
        walkCheckins[0]["image"] = "penny-1"
        card1Image.image = UIImage(named: walkCheckins[0]["image"] as String)
        walkCheckins[0]["details"] = "Jim picked up Spike at \(walkTimeStart)"
         card1Label.text = walkCheckins[0]["details"] as? String
        walkCheckins[0]["done"] = 1

    }
    
    func walkCheckin2done() {
        walkCheckins[1]["image"] = "penny-2"
        card2Image.image = UIImage(named: walkCheckins[1]["image"] as String)
        walkCheckins[1]["details"]! = "Jim took a photo of Spike at \(checkin2Location)"
        card2Label.text = walkCheckins[1]["details"] as? String
        walkCheckins[1]["done"] = 1
    }
    
    func walkCheckin3done() {
        walkCheckins[2]["image"] = "penny-3"
        card3Image.image = UIImage(named: walkCheckins[2]["image"] as String)
        walkCheckins[2]["details"]  = "Jim dropped Spike off at \(walkTimeEnd)"
        card3Label.text = walkCheckins[2]["details"] as? String
        walkCheckins[2]["done"] = 1
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
            /*delay(3, closure: { () -> () in
                self.card1Image.image = UIImage(named: "5 - Pickup 3-1")
                self.card1Image.frame.size = UIImage(named: "5 - Pickup 3-1").size
            })*/
        case scrollView.frame.size.width:
            pageControl.currentPage = 1
            /*delay(3, closure: { () -> () in
                self.card2Image.image = UIImage(named: "5 - Pickup 4-1")
                self.card2Image.frame.size = UIImage(named: "5 - Pickup 4-1").size
            })*/
        case scrollView.frame.size.width * 2:
            pageControl.currentPage = 2
            
            if walkCheckins[2]["done"] == 1 {
rateButton.hidden = false
}
            
            /*delay(3, closure: { () -> () in
                self.card3Image.image = UIImage(named: "5 - Pickup 6-1")
                self.card3Image.frame.size = UIImage(named: "5 - Pickup 6-1").size
                UIView.animateWithDuration(0.4, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.rateButton.alpha = 1
                    }, completion: { (finished:Bool) -> Void in
                    // here
                })
            })*/
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
   }
