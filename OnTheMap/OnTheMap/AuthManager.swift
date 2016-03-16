//
//  AuthManager.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class AuthManager {
    
    private let authService: AuthService
    static var session: Session?
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(username: String, password: String, completionHandler: (success: Bool, error: String?) -> Void) {
        authService.login(username, password: password) { (success, session, error) -> Void in
            if success {
                AuthManager.session = session
            }
            completionHandler(success: success, error: error)
        }
    }
    
}