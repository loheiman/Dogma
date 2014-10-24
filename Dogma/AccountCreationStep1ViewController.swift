//
//  AccountCreationStep1ViewController.swift
//  Dogma
//
//  Created by Loren Heiman on 10/7/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class AccountCreationStep1ViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {

    var cameraUI:UIImagePickerController = UIImagePickerController()
    var imageCaptured: UIImageView!
    var fullCCNumber: String!

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var dogImageButton: UIButton!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var expirationField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var creditCardNumberField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // creditCardNumberField.becomeFirstResponder()
        
        zipField.hidden = true
        cvvField.hidden = true
        expirationField.hidden = true
        
        scrollView.frame.size.width = 320

        scrollView.contentSize = CGSize(width: 640, height: 506)
        
        nextButton.enabled = false
        finishButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        if scrollView.contentOffset.x < scrollView.frame.size.width * 2 {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.scrollView.contentOffset.x += 320
                }) { (Finished: Bool) -> Void in
                    //
            }
        }
        
        nextButton.enabled = false
    
    }
    
    @IBAction func phoneNumberChanged(sender: UITextField) {
        if countElements(phoneNumberField.text) == 10 {
            creditCardNumberField.becomeFirstResponder()
        }
    }
    
    @IBAction func onCreditCardChanged(sender: UITextField) {

        if countElements(creditCardNumberField.text) == 16 {
            creditCardNumberField.textAlignment = NSTextAlignment.Right
            creditCardNumberField.frame.size.width = 60
            //creditCardNumberField.frame.origin.x = 15
            fullCCNumber = creditCardNumberField.text
            
            creditCardNumberField.text = fullCCNumber[advance(fullCCNumber.startIndex, 12)...advance(fullCCNumber.startIndex, 15)]
            
            expirationField.becomeFirstResponder()
            zipField.hidden = false
            cvvField.hidden = false
            expirationField.hidden = false
        }
    }
    
    @IBAction func onExpirationChanged(sender: UITextField) {
        if countElements(expirationField.text) == 4 {
            cvvField.becomeFirstResponder()
        }

    }
    
    
    @IBAction func onCvvChanged(sender: UITextField) {
        if countElements(cvvField.text) == 3 {
            zipField.becomeFirstResponder()
        }
    }
    
    @IBAction func onZipChanged(sender: UITextField) {
        if countElements(zipField.text) == 5 {
             nextButton.enabled = true
            view.endEditing(true)
        }
    }
    
    

    
    
    @IBAction func onTakePhotoButton(sender: AnyObject) {
        self.presentCamera()
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
        //var mediaType:NSString = info.objectForKey(UIImagePickerControllerEditedImage) as NSString
        //println(mediaType)
        var imageToSave:UIImage
        
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        
        //imageCaptured.image = imageToSave
        // UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        //self.savedImage()
        dogImageButton.setImage(imageToSave, forState: UIControlState.Normal)
        dogImageButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        finishButton.enabled = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTapOnView(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}
