//
//  LoginController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 01.05.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var usernameField: TranslucentTextField!
    @IBOutlet weak var passwordField: TranslucentTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.placeholderText = "Username"
        passwordField.placeholderText = "Password"
        
    }
    
    func login(email: String, password: String) {
        
    }
    
    @IBAction func loginTapped(button: UIButton!) {
        guard let username = usernameField.text where !username.isEmpty,
            let password = passwordField.text where !password.isEmpty else {
                return
        }
        activityIndicator.startAnimating()
        login(username, password: password)
    }
    
    @IBAction func signupTapped(button: UIButton!) {
        let mainSB = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let registerController = mainSB.instantiateViewControllerWithIdentifier("Register")
            as! UIViewController // Make sure to set register view controller id to 'Register'
        presentViewController(registerController, animated: true, completion: nil)
    }
}
