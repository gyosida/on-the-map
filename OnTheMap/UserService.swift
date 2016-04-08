//
//  UserService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

protocol UserService {
    
    func getUser(userId: String, successHandler: (user: User) -> Void, failureHandler: (error: String) -> Void)
    
}