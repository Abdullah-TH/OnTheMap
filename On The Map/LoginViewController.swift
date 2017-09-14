//
//  LoginViewController.swift
//  On The Map
//
//  Created by Abdullah Althobetey on 9/14/17.
//  Copyright © 2017 Abdullah Althobetey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        loginButton.layer.cornerRadius = 5
    }

    @IBAction func signUp(_ sender: UIButton)
    {
        let app = UIApplication.shared
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")!
        app.open(url, options: [:], completionHandler: nil)
    }
}
