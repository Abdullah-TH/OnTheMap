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












