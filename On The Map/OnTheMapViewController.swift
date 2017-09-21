//
//  OnTheMapViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class OnTheMapViewController: UIViewController
{
    static let udacityColor = UIColor(red: 81/255.0, green: 177/255.0, blue: 224/255.0, alpha: 1)

    var studentLocations: [StudentLocation]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        refreshStudentLocations()
        print(UdacityUser.currentUdacityUser.firstName, UdacityUser.currentUdacityUser.lastName, UdacityUser.currentUdacityUser.key)
    }
    
    func setupUI()
    {
        let logoutButton = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logout(_:)))
        logoutButton.tintColor = OnTheMapViewController.udacityColor
        let textAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 14.0) as Any]
        logoutButton.setTitleTextAttributes(textAttributes, for: .normal)
        
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_refresh"), style: .plain, target: self, action: #selector(refreshStudentLocations))
        refreshButton.tintColor = OnTheMapViewController.udacityColor
        
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_addpin"), style: .plain, target: self, action: #selector(addStudentLocation))
        addButton.tintColor = OnTheMapViewController.udacityColor
        
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.title = "On the Map"
    }

    func logout(_ sender: Any)
    {
        (sender as! UIBarButtonItem).isEnabled = false
        activityIndicatorShouldStartAnimating()
        APIManager.logoutFromUdacity { (sessionID, error) in
            
            if error == nil
            {
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                print(error!.localizedDescription)
            }
            
            self.activityIndicatorShouldStopAnimating()
            (sender as! UIBarButtonItem).isEnabled = true
        }
    }
    
    func addStudentLocation()
    {
        let addLocationNVC = storyboard?.instantiateViewController(withIdentifier: "AddLocationNavigationController") as! UINavigationController
        present(addLocationNVC, animated: true, completion: nil)
    }
    
    func refreshStudentLocations()
    {
        activityIndicatorShouldStartAnimating()
        APIManager.getStudentLocations { (results, error) in
            
            if error == nil
            {
                self.studentLocations = results
                self.shouldRefereshData()
            }
            else
            {
                self.showErrorMessage(error!.localizedDescription)
            }
            
            self.activityIndicatorShouldStopAnimating()
        }
    }
    
    func showErrorMessage(_ message: String)
    {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func openURLInbrowser(url: URL?)
    {
        let app = UIApplication.shared
        if let url = url
        {
            app.open(url, options: [:], completionHandler: { success in
                
                if !success
                {
                    self.showErrorMessage("Invalid link")
                }
            })
        }
        else
        {
            showErrorMessage("Invalid link")
        }
    }
    
    func activityIndicatorShouldStartAnimating()
    {
        fatalError("Must be implemented by a subclass")
    }
    
    func activityIndicatorShouldStopAnimating()
    {
        fatalError("Must be implemented by a subclass")
    }
    
    func shouldRefereshData()
    {
        fatalError("Must be implemented by a subclass")
    }

}








