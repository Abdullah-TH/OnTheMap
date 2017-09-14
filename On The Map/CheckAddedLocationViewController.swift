//
//  CheckAddedLocationViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class CheckAddedLocationViewController: UIViewController
{
    @IBOutlet weak var finishButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        finishButton.layer.cornerRadius = 5
        navigationController?.navigationBar.tintColor = OnTheMapViewController.udacityColor // this will change the tint color of the backBarButtonItem
    }

    @IBAction func finish(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
