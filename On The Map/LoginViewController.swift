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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        loginButton.layer.cornerRadius = 5
    }

    @IBAction func login(_ sender: UIButton)
    {
        activityIndicator.startAnimating()
        APIManager.loginToUdacity(username: emailTextField.text!, password: passwordTextField.text!) { (sessionID, error) in
            
            self.activityIndicator.stopAnimating()
            
            if error == nil
            {
                print("\nsession id: \(sessionID!)\n")
                self.performSegue(withIdentifier: "LoginToMain", sender: nil)
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: error!.description, preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
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




