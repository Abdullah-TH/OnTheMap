//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController
{
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if UIDevice.current.orientation.isLandscape
        {
            subscribeToKeyboardNotification()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationSubscription()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape
        {
            subscribeToKeyboardNotification()
        }
        else
        {
            removeKeyboardNotificationSubscription()
        }
    }
    
    func setupUI()
    {
        let textAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 14.0) as Any]
        
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancel))
        cancelButton.tintColor = OnTheMapViewController.udacityColor
        cancelButton.setTitleTextAttributes(textAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = cancelButton
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        backButton.setTitleTextAttributes(textAttributes, for: .normal)
        navigationItem.backBarButtonItem = backButton
        
        findLocationButton.layer.cornerRadius = 5
    }
    
    func subscribeToKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotificationSubscription()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        if view.frame.origin.y == 0
        {
            view.frame.origin.y -= 130.0
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if view.frame.origin.y != 0
        {
            view.frame.origin.y = 0.0
        }
    }
    
    func cancel()
    {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func findLocation(_ sender: UIButton)
    {
        activityIndicator.startAnimating()
        let gecoder = CLGeocoder()
        gecoder.geocodeAddressString(locationTextField.text!) { (placemarks, error) in
            
            guard let placemarks = placemarks,
                let location = placemarks.first?.location else
            {
                AlertControllerMaker.showErrorMessage("The location you entered is not valid", inViewController: self)
                self.activityIndicator.stopAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "AddLocationToCheckLocation", sender: location)
        }
    }
    
    @IBAction func backgroundViewTapped(_ sender: UITapGestureRecognizer)
    {
        locationTextField.resignFirstResponder()
        websiteTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AddLocationToCheckLocation"
        {
            let checkAddedLocationVC = segue.destination as! CheckAddedLocationViewController
            checkAddedLocationVC.location = sender as! CLLocation
            checkAddedLocationVC.mapString = locationTextField.text!
            checkAddedLocationVC.mediaURL = websiteTextField.text!
        }
    }
    
}

extension AddLocationViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField === locationTextField
        {
            websiteTextField.becomeFirstResponder()
        }
        else if textField === websiteTextField
        {
            websiteTextField.resignFirstResponder()
        }
        
        return true
    }
}












