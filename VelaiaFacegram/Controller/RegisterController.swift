//
//  RegisterController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 01.05.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

protocol RegisterControllerDelegate: class {
    func registerControllerDidCancel(controller: RegisterController)
    func registerControllerDidFinish(controller: RegisterController, withEmail email: String)
}

class RegisterController: UIViewController {
    @IBOutlet weak var emailField: TranslucentTextField!
    @IBOutlet weak var passwordField: TranslucentTextField!
    @IBOutlet weak var usernameField: TranslucentTextField!
    weak var delegate: RegisterControllerDelegate?
    
    @IBAction func registerTabbed(button: UIButton!) {
        guard let email = emailField.text where !email.isEmpty,
            let password = passwordField.text where !password.isEmpty,
            let username = usernameField.text where !username.isEmpty else {
                return
        }
        firebase.createUser(email, password: password, withValueCompletionBlock: { error, result in
            if error != nil {
                print("Error occured during registration: \(error.localizedDescription)")
                return
            }
            guard let uid = result["uid"] as? String else {
                print("Invalid uid for user: \(email)")
                return
            }
            usernameRef.childByAppendingPath(uid).setValue(username)
            profileRef.childByAppendingPath(username).setValue(["username": username])
            let alertController = UIAlertController(title: "Registration Success!", message: "Your account was succesfully created with email\n\(email)", preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "Got it", style: .Default, handler: { alertAction in
                // Return to login screen. Pass email back.
                self.delegate?.registerControllerDidFinish(self, withEmail: email)
            })
            alertController.addAction(dismissAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func loginTabbed(button: UIButton!) {
        delegate?.registerControllerDidCancel(self)
    }
}
