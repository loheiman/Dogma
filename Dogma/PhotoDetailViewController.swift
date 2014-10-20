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
    
    var location: CLLocationCoordinate2D!
    var imageString: String!
    var details: String!
    var pickupPlaceID: String!
    //var result: [NSDictionary] = []
    /*var geometry: [NSDictionary] = []
    var locationDictionary: [NSDictionary] = []*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLabel.text = details
        imageView.image = UIImage(named: imageString)
        
        var url = NSURL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + pickupPlaceID! + "&key=AIzaSyBR25mbykImkoIribmzpCFXLAuvPkfqCio")
        var request = NSURLRequest(URL: url)
        /*var lat:CLLocationDegrees
        var lng:CLLocationDegrees*/

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            var objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            var result = objects["result"] as [ NSDictionary ]
            println(result)
            /*var geometry = result["geometry"] as [ NSDictionary ]
            var locationDictionary = geometry["location"] as [ NSDictionary ]
            self.lat = locationDictionary["lat"] as CLLocationDegrees
            self.lng = locationDictionary["lng"] as CLLocationDegrees
            */
            
        }

        
        
        /*var location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)
        mapView.scrollEnabled = false
        mapView.zoomEnabled = false
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        
        mapView.addAnnotation(annotation)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
