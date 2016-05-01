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
        firebase.authUser(email, password: password, withCompletionBlock: { error, result in
            if error != nil {
                print(error.localizedDescription)
                self.activityIndicator.stopAnimating()
                return
            }
            let uid = result.uid
            usernameRef.childByAppendingPath(uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
                guard let username = snapshot.value as? String else {
                    print("No user found for \(email)")
                    self.activityIndicator.stopAnimating()
                    return
                }
                profileRef.childByAppendingPath(username).observeSingleEventOfType(.Value, withBlock: {
                    snapshot in
                    self.activityIndicator.stopAnimating()
                    guard let profile = snapshot.value as? [String: AnyObject] else {
                        print("No profile found for user")
                        return
                    }
                    Profile.currentUser = Profile.initWithUsername(username, profileDict: profile)
                    let mainSB = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let rootController = mainSB.instantiateViewControllerWithIdentifier("Tabs") // Initialize CenterTabBarController
                    self.presentViewController(rootController, animated: true, completion: nil)
                })
            })
        })
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
