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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        let logoutButton = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logout))
        logoutButton.tintColor = OnTheMapViewController.udacityColor
        let textAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 14.0) as Any]
        logoutButton.setTitleTextAttributes(textAttributes, for: .normal)
        
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_refresh"), style: .plain, target: self, action: #selector(refresh))
        refreshButton.tintColor = OnTheMapViewController.udacityColor
        
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_addpin"), style: .plain, target: self, action: #selector(addStudentLocation))
        addButton.tintColor = OnTheMapViewController.udacityColor
        
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.title = "On the Map"
    }

    func logout()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func addStudentLocation()
    {
        let addLocationNVC = storyboard?.instantiateViewController(withIdentifier: "AddLocationNavigationController") as! UINavigationController
        present(addLocationNVC, animated: true, completion: nil)
    }
    
    func refresh()
    {
        
    }

}
