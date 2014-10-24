//
//  PhotoDetailViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/16/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit
import MapKit

class PhotoDetailViewController: UIViewController  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailsLabel: UILabel!

    var imageString: String!
    var details: String!
    var pickupPlaceID: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLabel.text = details
        //imageView.image = UIImage(named: imageString)
        
        var url = NSURL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + pickupPlaceID! + "&key=AIzaSyBR25mbykImkoIribmzpCFXLAuvPkfqCio")
        var request = NSURLRequest(URL: url!)

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            var objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            var result = objects["result"] as NSDictionary
            var geometry = result["geometry"] as NSDictionary
            var locations = geometry["location"] as NSDictionary
            
            var lat = locations["lat"] as CLLocationDegrees
            var lng = locations["lng"] as CLLocationDegrees

            var location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            
            self.mapView.setRegion(region, animated: true)
            self.mapView.scrollEnabled = false
            self.mapView.zoomEnabled = false
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(location)
            
            self.mapView.addAnnotation(annotation)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
