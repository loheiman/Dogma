//
//  RatingViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/20/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    
    var stars: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dogImage.layer.cornerRadius = dogImage.frame.size.width/2
        dogImage.clipsToBounds = true
        
        stars = [
            star1Button,
            star2Button,
            star3Button,
            star4Button,
            star5Button
        ]
        
        for star in stars {
            star.alpha = 0.5
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onStarTap(sender: UIButton) {
        
        for star in stars {
            star.alpha = 0.5
        }
        
        for index in 1...sender.tag {
            println(index)
            stars[index - 1].alpha = 1
        }
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
