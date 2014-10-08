//
//  ActiveWalkViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class ActiveWalkViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var card1Image: UIImageView!
    @IBOutlet weak var card2Image: UIImageView!
    @IBOutlet weak var card3Image: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12
        rateButton.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.x
        println(offset)
        switch offset {
        case 0:
            pageControl.currentPage = 0
            delay(3, closure: { () -> () in
                self.card1Image.image = UIImage(named: "5 - Pickup 3-1")
                self.card1Image.frame.size = UIImage(named: "5 - Pickup 3-1").size
            })
        case scrollView.frame.size.width:
            pageControl.currentPage = 1
            delay(3, closure: { () -> () in
                self.card2Image.image = UIImage(named: "5 - Pickup 4-1")
                self.card2Image.frame.size = UIImage(named: "5 - Pickup 4-1").size
            })
        case scrollView.frame.size.width * 2:
            pageControl.currentPage = 2
            delay(3, closure: { () -> () in
                self.card3Image.image = UIImage(named: "5 - Pickup 6-1")
                self.card3Image.frame.size = UIImage(named: "5 - Pickup 6-1").size
                UIView.animateWithDuration(0.4, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.rateButton.alpha = 1
                    }, completion: { (finished:Bool) -> Void in
                    // here
                })
            })
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
