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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if UIDevice.current.orientation.isLandscape
        {
            subscribeToKeyboardNotification()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationSubscription()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        if view.window != nil // if this view controller's view is currently visible
        {
            if UIDevice.current.orientation.isLandscape
            {
                subscribeToKeyboardNotification()
            }
            else
            {
                removeKeyboardNotificationSubscription()
            }
        }
    }
    
    func setupUI()
    {
        containerView.alpha = 0.0
        loginButton.layer.cornerRadius = 5
    }
    
    func subscribeToKeyboardNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotificationSubscription()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        if view.frame.origin.y == 0
        {
            view.frame.origin.y -= 130.0
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if view.frame.origin.y != 0
        {
            view.frame.origin.y = 0.0
        }
    }

    @IBAction func login(_ sender: UIButton)
    {
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        
        guard !emailTextField.text!.isEmpty || !passwordTextField.text!.isEmpty else
        {
            AlertControllerMaker.showErrorMessage("Please enter email and password", inViewController: self)
            activityIndicator.stopAnimating()
            loginButton.isEnabled = true
            return
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
            
            self.loginButton.isEnabled = true
        }
    }
    
    @IBAction func signUp(_ sender: UIButton)
    {
        let app = UIApplication.shared
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")!
        app.open(url, options: [:], completionHandler: nil)
    }

    @IBAction func backgroundViewTapped(_ sender: UITapGestureRecognizer)
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField === emailTextField
        {
            passwordTextField.becomeFirstResponder()
        }
        else if textField === passwordTextField
        {
            passwordTextField.resignFirstResponder()
            login(loginButton)
        }
        
        return true
    }
}




