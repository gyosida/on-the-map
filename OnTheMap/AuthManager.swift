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
    
    func login(username: String, password: String, successHandler: () -> Void, failureHandler: (error: String) -> Void) {
        authService.login(username, password: password, successHandler: { (session) -> Void in
                AuthManager.session = session
                successHandler()
            }, failureHandler: {(error) -> Void in
                failureHandler(error: error)
            }
        )
    }
    
}