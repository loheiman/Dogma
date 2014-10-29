//
//  RatingViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/20/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    var stars: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let possibleOldImagePath = defaults.objectForKey("path") as String?
        
        if let oldImagePath = possibleOldImagePath {
            let oldFullPath = self.documentsPathForFileName(oldImagePath)
            let oldImageData = NSData(contentsOfFile: oldFullPath)
            // here is your saved image:
            let oldImage = UIImage(data: oldImageData!)
            dogImage.image = oldImage
        }
        
        
            
        submitButton.enabled = false

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
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onStarTap(sender: UIButton) {
        
       // self.stars[sender.tag - 1].transform = CGAffineTransformMakeScale(0.7, 0.7)
       /*
        UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
            self.stars[sender.tag - 1].transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (Finished: Bool) -> Void in
            println()
        }*/
        
        for star in stars {
            star.setImage(UIImage(named: "icon-star"), forState: UIControlState.Normal)
        }
        
        for index in 1...sender.tag {
            println(index)
            stars[index - 1].setImage(UIImage(named: "icon-star-filled"), forState: UIControlState.Normal)
        }
        
        submitButton.enabled = true

    }
        

    
    // For saving dog image
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let path = paths[0] as String;
        let fullPath = path.stringByAppendingPathComponent(name)
        
        return fullPath
    }

}
