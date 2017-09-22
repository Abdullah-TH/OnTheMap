//
//  MapViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: OnTheMapViewController
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshStudentLocations()
    }
    
    override func activityIndicatorShouldStartAnimating()
    {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.mapView.alpha = 0.3
        }
    }
    
    override func activityIndicatorShouldStopAnimating()
    {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2) {
            self.mapView.alpha = 1.0
        }
    }
    
    override func shouldRefereshData()
    {
        var annotations = [MKPointAnnotation]()
        for location in StudentLocation.studentLocations
        {
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = location.mediaURL
            
            annotations.append(annotation)
        }
        
        mapView.removeAnnotations(mapView.annotations) // remove old annotations before adding the new ones 
        mapView.addAnnotations(annotations)
    }

}

extension MapViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil
        {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else
        {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if control == view.rightCalloutAccessoryView
        {
            if let toOpen = view.annotation?.subtitle!
            {
                openURLInbrowser(url: URL(string: toOpen))
            }
        }
    }
}












