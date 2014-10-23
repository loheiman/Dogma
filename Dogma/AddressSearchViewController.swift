//
//  AddressSearchViewController.swift
//  Dogma
//
//  Created by Kyle Pickering on 10/19/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var predictions : [NSDictionary] = []
    var address: String!
    var pickupPlaceID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
    }
    
    override func viewDidAppear(animated: Bool) {
        searchField.becomeFirstResponder()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("AddressSearch") as AddressSearchTableViewCell
        
        //var user = users[indexPath.row]
        var prediction = predictions[indexPath.row]
        var description = prediction["description"] as String
        
        cell.addressLabel.text = description
        
        return cell
    }

    @IBAction func onSearchFieldChanged(sender: AnyObject) {
        var contents = searchField.text
        var newContents = contents.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        var url = NSURL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=" + newContents! + "&types=geocode&language=fr&key=AIzaSyBR25mbykImkoIribmzpCFXLAuvPkfqCio")
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            var objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.predictions = objects["predictions"] as [ NSDictionary ]
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var prediction = predictions[indexPath.row]
        var description = prediction["description"] as String
        pickupPlaceID = prediction["place_id"] as String!
        address = description

        performSegueWithIdentifier("addressReturnSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as CreateWalkViewController
        destinationVC.walkData["address"] = address
        destinationVC.walkData["pickupPlaceID"] = pickupPlaceID!
        println(pickupPlaceID)
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
