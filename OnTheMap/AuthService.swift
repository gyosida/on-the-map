//
//  AuthService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/11/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

protocol AuthService {
    
    func login(username: String, password: String, successHandler:(session: Session?) -> Void, failureHandler: (error: String) -> Void)
}
