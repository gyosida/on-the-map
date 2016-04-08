//
//  ViewController.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/10/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private static let HOME_SEGUE_IDENTIFIER = "homeSegue"

    @IBAction func loginPressed(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let authManager = AuthManager(authService: ServicesFactory.sharedInstance.getAuthService())
        
        self.activityIndicator.startAnimation()
        authManager.login(username, password: password, successHandler: { () -> Void in
                UserManager.sharedInstance.getUser(AuthManager.session!.key, successHandler: {  () -> Void in
                        self.activityIndicator.stopAnimation()
                        self.performSegueWithIdentifier(LoginViewController.HOME_SEGUE_IDENTIFIER, sender: self)
                    }, failureHandler: self.getDefaultErrorHandler())
            }, failureHandler: self.getDefaultErrorHandler())
    }
}

