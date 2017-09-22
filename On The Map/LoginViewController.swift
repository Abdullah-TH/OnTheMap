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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.4) {
            self.containerView.alpha = 1.0
        }
    }
    
    func setupUI()
    {
        containerView.alpha = 0.0
        loginButton.layer.cornerRadius = 5
    }

    @IBAction func login(_ sender: UIButton)
    {
        activityIndicator.startAnimating()
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        {
            AlertControllerMaker.showErrorMessage("Please enter email and password", inViewController: self)
        }
        APIManager.loginToUdacity(username: emailTextField.text!, password: passwordTextField.text!) { (udacityUser, error) in
            
            self.activityIndicator.stopAnimating()
            
            if error == nil
            {
                UdacityUser.currentUdacityUser = udacityUser
                self.performSegue(withIdentifier: "LoginToMain", sender: nil)
            }
            else
            {
                AlertControllerMaker.showErrorMessage(error!.localizedDescription, inViewController: self)
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton)
    {
        let app = UIApplication.shared
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")!
        app.open(url, options: [:], completionHandler: nil)
    }

}




