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

    
    @IBOutlet weak var expirationFormatting: UILabel!
    @IBOutlet weak var expirationField2: UITextField!
    @IBOutlet weak var expirationField1: UITextField!
    @IBOutlet weak var creditCardNumberButton: UIButton!
    @IBOutlet weak var creditCardNumberField4: UITextField!
    @IBOutlet weak var creditCardNumberField3: UITextField!
    @IBOutlet weak var creditCardNumberField2: UITextField!
    @IBOutlet weak var creditCardNumberField1: UITextField!
    @IBOutlet weak var phoneNumberFormatting: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var phoneNumberField3: UITextField!
    @IBOutlet weak var phoneNumberField2: UITextField!
    @IBOutlet weak var phoneNumberField1: UITextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var dogImageButton: UIButton!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
  

    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var creditCardNumberField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testObject = PFObject(className:"TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground()
        
        
        phoneNumberField1.text = ""
        phoneNumberField2.text = ""
        phoneNumberField3.text = ""
        phoneNumberFormatting.hidden = true
        
        creditCardNumberField1.text = ""
        creditCardNumberField2.text = ""
        creditCardNumberField3.text = ""
        creditCardNumberField4.text = ""

        
        zipField.hidden = true
        cvvField.hidden = true
        expirationField1.hidden = true
        expirationField2.hidden = true
        expirationFormatting.hidden = true
        
        scrollView.frame.size.width = 320

        scrollView.contentSize = CGSize(width: 640, height: 506)
        
        nextButton.enabled = false
        finishButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPhoneNumberEditing(sender: AnyObject) {
        raiseNext()
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        if scrollView.contentOffset.x < scrollView.frame.size.width * 2 {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.scrollView.contentOffset.x += 320
                }) { (finished:Bool) -> Void in
                    //
            }
        }
        
        nextButton.enabled = false
    
    }
    
    
    
    @IBAction func onPhoneNumberTapped(sender: UIButton) {
        phoneNumberButton.setTitle("", forState: UIControlState.Normal)
        phoneNumberFormatting.hidden = false
        phoneNumberField1.becomeFirstResponder()
        phoneNumberButton.hidden = true
        raiseNext()
    }
    
    
    //PHONE NUMBER ENTRY
    @IBAction func onPhoneNumberField1Changed(sender: UITextField) {
        if countElements(phoneNumberField1.text) == 3 {
            phoneNumberField2.becomeFirstResponder()
        }
    }
    
    @IBAction func onPhoneNumberField2Changed(sender: UITextField) {
        if countElements(phoneNumberField2.text) == 3 {
            phoneNumberField3.becomeFirstResponder()
        }
    }
    
    @IBAction func onPhoneNumberField3Changed(sender: UITextField) {
        if countElements(phoneNumberField3.text) == 4 {
            creditCardNumberField1.becomeFirstResponder()
        }
    }
    
    //CREDIT CARD ENTRY
    @IBAction func creditCardNumberField1(sender: UITextField) {
        creditCardNumberButton.hidden = true
        if countElements(creditCardNumberField1.text) == 4 {
            creditCardNumberField2.becomeFirstResponder()
        }
    }
    
    @IBAction func creditCardNumberField2(sender: UITextField) {
        if countElements(creditCardNumberField2.text) == 4 {
            creditCardNumberField3.becomeFirstResponder()
        }
    }
    
    
    @IBAction func creditCardNumberField3(sender: UITextField) {
        if countElements(creditCardNumberField3.text) == 4 {
            creditCardNumberField4.becomeFirstResponder()
        }
    }
    
    
    @IBAction func creditCardNumberField4(sender: UITextField) {
        if countElements(creditCardNumberField4.text) == 4 {
            creditCardNumberField1.hidden = true
            creditCardNumberField2.hidden = true
            creditCardNumberField3.hidden = true
            self.expirationField1.becomeFirstResponder()
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.creditCardNumberField4.frame.origin.x = 30
                }, completion: { (Finished: Bool) -> Void in
                    
                    self.zipField.hidden = false
                    self.cvvField.hidden = false
                    self.expirationField1.hidden = false
                    self.expirationField2.hidden = false
                    self.expirationFormatting.hidden = false
            })

            
        }
    }
    
    
    
    @IBAction func onExpirationField1Changed(sender: UITextField) {
        if countElements(expirationField1.text) == 2 {
        expirationField2.becomeFirstResponder()
        }

    }
    
    
    @IBAction func onExpirationField2Changed(sender: UITextField) {
        if countElements(expirationField2.text) == 2 {
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
        lowerNext()
    }
    
    func raiseNext() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.nextButton.frame.origin.y = 194
            }) { (finished:Bool) -> Void in
            // done
        }
    }
    
    func lowerNext() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.nextButton.frame.origin.y = 440
            }) { (finished:Bool) -> Void in
                // done
        }
    }
}
