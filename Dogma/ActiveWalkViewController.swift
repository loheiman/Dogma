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
    
    var walkData:NSDictionary!
    
    var walkCheckins = [
        [
            "image": "penny-1",
            "lat": "37",
            "lng": "-122",
            "details": "Jim Picked up spike at 7pm"
        ],
        [
            "image": "penny-2",
            "lat": "42",
            "lng": "122",
            "details": "Jim took a photo of Spike at Dolores Park"
        ],
        [
            "image": "penny-3",
            "lat": "22",
            "lng": "-125",
            "details": "Jim dropped Spike off at Home"
        ]
    ]
    
    var clickedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateButton.hidden=true
   
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12
        
        
       
        
        walkCheckins[0]["details"] = walkData["address"] as String!
        
        card1Image.image = UIImage(named: walkCheckins[0]["image"]!)
        card2Image.image = UIImage(named: walkCheckins[1]["image"]!)
        card3Image.image = UIImage(named: walkCheckins[2]["image"]!)
        
        card1Label.text = walkCheckins[0]["details"]!
        card2Label.text = walkCheckins[1]["details"]!
        card3Label.text = walkCheckins[2]["details"]!
        
        println(walkData["pickupPlaceID"]!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender?.identifier == "PhotoDetailSegue" {
        var destinationVC = segue.destinationViewController as PhotoDetailViewController
        
        var checkin = walkCheckins[clickedIndex]
        
 
        destinationVC.pickupPlaceID = walkData["pickupPlaceID"] as String
        /*destinationVC.lat = checkin["lat"]
        destinationVC.lng = checkin["lng"]*/
        destinationVC.imageString = checkin["image"]
        destinationVC.details = checkin["details"]
        }
        
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
            rateButton.hidden = false
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
