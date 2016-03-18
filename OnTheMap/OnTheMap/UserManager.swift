//
//  UserManager.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/18/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class UserManager {
    
    static let sharedInstance = UserManager(userService: ServicesFactory.sharedInstance.getUserService())
    private let userService: UserService
    var user: User?
    
    private init(userService: UserService) {
        self.userService = userService
    }
    
    func getUser(userId: String, successHandler: () -> Void, failureHandler: (error: String) -> Void) {
        self.userService.getUser(userId, successHandler: { (user) -> Void in
                self.user = user
                successHandler()
            }, failureHandler: { (error: String) -> Void in
                failureHandler(error: error)
            }
        )
    }
    
}
