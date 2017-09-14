//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController
{
    @IBOutlet weak var findLocationButton: UIButton!

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

}
