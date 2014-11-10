//
//  WalkerActiveWalkViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 11/5/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import CoreLocation

class WalkerActiveWalkViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var checkin3ImageView: UIImageView!
    @IBOutlet weak var checkin2ImageView: UIImageView!
    @IBOutlet weak var checkin1ImageView: UIImageView!
    @IBOutlet weak var checkin3Button: UIButton!
    @IBOutlet weak var checkin2Button: UIButton!
    @IBOutlet weak var checkin1Button: UIButton!

    @IBOutlet weak var walkLocationField: UILabel!
    @IBOutlet weak var walkDurationField: UILabel!
    @IBOutlet weak var walkTimeField: UILabel!
    @IBOutlet weak var dogNameField: UILabel!
    @IBOutlet weak var callOwnerButton: UIButton!
    var checkinNumber: Int!
    
    
    
    
    var cameraUI:UIImagePickerController = UIImagePickerController()
    var imageCaptured: UIImageView!
    
    var lat: Float!
    var lng: Float!
    var ownerName: String!
    var dogName: String!
    var walkLocation: String!
    var walkTime: String!
    var walkDuration: String!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    
    let locationManager = CLLocationManager()
 
    @IBOutlet weak var dogImage: UIImageView!
    
 
    var checkinsRef = Firebase(url:"https://dogma.firebaseio.com/checkins")
    var checkin1Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin1")
    var checkin2Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin2")
    var checkin3Ref = Firebase(url:"https://dogma.firebaseio.com/checkins/checkin3")

    var checkin1 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/1742640_741562002591024_935929873_n.jpg",
        "lat": 54,
        "lng": 33,
        "imageString" : "lksdjg"
    ]
    
    var checkin2 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-d.ak.instagram.com/hphotos-ak-xaf1/10632327_364503633708115_229544745_n.jpg",
        "lat": 54,
        "lng": 33,
        "imageString": "lksdjg"
    ]
    
    var checkin3 = [
        "status" : "incomplete",
        "location" : "ChIJueOuefqAhYARapAU-YtbztA",
        "imageURL": "http://photos-e.ak.instagram.com/hphotos-ak-xaf1/10735332_1712337005658708_1599530669_n.jpg",
        "lat": 54,
        "lng": 33,
        "imageString": "lksdjg"
    ]
  
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkinNumber = 0
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            println("Location services are not enabled");
        }
        
        checkin1Ref.setValue(checkin1)
        checkin2Ref.setValue(checkin2)
        checkin3Ref.setValue(checkin3)
        
        
        scrollView.delegate = self
        scrollView.frame.size.width = 272
        scrollView.contentSize.width = 804 + 12
        
        dogName = defaults.stringForKey("dogName")
        walkDuration = defaults.stringForKey("walkDuration")
        walkTime = defaults.stringForKey("walkTime")
        walkLocation = defaults.stringForKey("walkLocation")
        
        dogNameField.text = dogName
        walkDurationField.text = walkDuration
        walkTimeField.text = walkTime
        walkLocationField.text = walkLocation
        
       callOwnerButton.setTitle("Contact \(dogName)'s owner", forState: UIControlState.Normal)
        
       
        
        dogImage.layer.cornerRadius = dogImage.frame.size.width/2
        dogImage.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        delay(0.6, closure: { () -> () in
            
      
            if self.checkinNumber! == 1 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width)
                    println("checkin1 should scroll")
                })
            } else if self.checkinNumber! == 2 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width) * 2
                 
                    println("checkin2 should scroll")
                })
            } else if self.checkinNumber! == 3 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.scrollView.contentOffset.x = CGFloat(self.scrollView.frame.size.width) * 2
                    println("checkin3 should scroll")
                })
                
               self.performSegueWithIdentifier("toWalkerFinishedSegue", sender: self)
            }
        })
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        //println(coord.latitude)
        //println(coord.longitude)
        lat = Float(coord.latitude)
        lng = Float(coord.longitude)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        //removeLoadingView()
        if ((error) != nil) {
            print(error)
        }
    }
    
    
    func presentCamera() {
        cameraUI = UIImagePickerController()
        cameraUI.delegate = self
        cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
        cameraUI.allowsEditing = false
        
        self.presentViewController(cameraUI, animated: true, completion: {})
    }
    
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary)
    {
        
        var imageToSave:UIImage
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        var smallImage = ResizeImage(imageToSave, targetSize: CGSize(width: 320, height: 320))
        var imageData = UIImagePNGRepresentation(smallImage)
       // var imageData = UIImageJPEGRepresentation(smallImage, 0.8)
        let base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
      
        
        if checkinNumber == 1 {
           
        checkin1 = [
                "status" : "complete",
                "location" : "ChIJueOuefqAhYARapAU-YtbztA",
                "imageURL": "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/1742640_741562002591024_935929873_n.jpg",
                "lat": lat,
                "lng": lng,
                "imageString" : base64String
            ]
            
            checkin1Ref.setValue(checkin1)
        self.checkin1ImageView.image = imageToSave
            
            
        } else if checkinNumber == 2 {
            
            checkin2 = [
                "status" : "complete",
                "location" : "ChIJueOuefqAhYARapAU-YtbztA",
                "imageURL": "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/1742640_741562002591024_935929873_n.jpg",
                "lat": lat,
                "lng": lng,
                "imageString" : base64String
            ]
            
            checkin2Ref.setValue(checkin2)
            self.checkin2ImageView.image = imageToSave
           
            
        } else if checkinNumber == 3 {
            
            checkin3 = [
                "status" : "complete",
                "location" : "ChIJueOuefqAhYARapAU-YtbztA",
                "imageURL": "http://photos-a.ak.instagram.com/hphotos-ak-xaf1/1742640_741562002591024_935929873_n.jpg",
                "lat": lat,
                "lng": lng,
                "imageString" : base64String
            ]
            
            checkin3Ref.setValue(checkin3)
            self.checkin3ImageView.image = imageToSave
            
        }
        
        
        //self.checkin1ImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    @IBAction func onCheckin1ButtonTap(sender: AnyObject) {
        checkinNumber = 1
        presentCamera()
        checkin1Button.hidden = true
    }
    
    @IBAction func onCheckin2ButtonTap(sender: AnyObject) {
        checkinNumber = 2
        presentCamera()
        checkin2Button.hidden = true
    }
    
    
    @IBAction func onCheckin3ButtonTap(sender: AnyObject) {
        checkinNumber = 3
        presentCamera()
        checkin3Button.hidden = true
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return newImage
    }

}
