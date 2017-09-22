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
        
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
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
                                                
                                                let tabBarController = self.presentingViewController as! UITabBarController
                                                let navController = tabBarController.selectedViewController as! UINavigationController
                                                let onTheMapVC = navController.topViewController as! OnTheMapViewController
                                                
                                                self.dismiss(animated: true, completion: {
                                                    
                                                    onTheMapVC.refreshStudentLocations()
                                                })
                                            }
                                            else
                                            {
                                                print(result ?? "no result")
                                                AlertControllerMaker.showErrorMessage(error!.localizedDescription, inViewController: self)
                                            }
                                            
                                            self.activityIndicator.stopAnimating()
        }
    }
    
}










