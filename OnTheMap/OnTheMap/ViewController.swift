//
//  ViewController.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/10/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let authManager = AuthManager(authService: UdacityAuthService())
    let homeSegueIdentifier = "homeSegue"

    @IBAction func loginPressed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        self.activityIndicator.startAnimation()
        authManager.login(username, password: password) { (success, error) -> Void in
            if success {
                self.performSegueWithIdentifier(self.homeSegueIdentifier, sender: self)
            } else {
                print(error)
            }
            self.activityIndicator.stopAnimation()
        }
    }
}

