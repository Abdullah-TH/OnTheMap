//
//  CheckAddedLocationViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit
import MapKit

class CheckAddedLocationViewController: UIViewController
{
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var location: CLLocation!
    var mapString = ""
    var mediaURL = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    func setupUI()
    {
        finishButton.layer.cornerRadius = 5
        navigationController?.navigationBar.tintColor = OnTheMapViewController.udacityColor // this will change the tint color of the backBarButtonItem
    }

    @IBAction func finish(_ sender: UIButton)
    {
        activityIndicator.startAnimating()
        APIManager.postAStudentLocation(accountKey: UdacityUser.currentUdacityUser.key,
                                        firstName: UdacityUser.currentUdacityUser.firstName,
                                        lastName: UdacityUser.currentUdacityUser.lastName,
                                        mapString: self.mapString,
                                        mediaURL: self.mediaURL,
                                        latitude: location.coordinate.latitude,
                                        longitude: location.coordinate.longitude) { (result, error) in
                                            
                                            if let result = result
                                            {
                                                print(result)
                                                self.dismiss(animated: true, completion: nil)
                                            }
                                            else
                                            {
                                                print(result ?? "no result")
                                                self.showErrorMessage(error!.localizedDescription)
                                            }
                                            
                                            self.activityIndicator.stopAnimating()
        }
    }
    
    func showErrorMessage(_ message: String)
    {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}










