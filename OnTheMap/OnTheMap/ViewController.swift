//
//  ViewController.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/10/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let authManager = AuthManager(authService: UdacityAuthService())

    @IBAction func loginPressed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        authManager.login(username, password: password) { (success, error) -> Void in
            if success {
                let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("homeViewController")
                self.presentViewController(homeViewController, animated: true, completion: nil)
            } else {
                print(error)
            }
        }
    }
}

