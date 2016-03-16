//
//  AuthService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/11/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

protocol AuthService {
    
    func login(username: String, password: String, completionWithHandler:(success:Bool, session: Session?, error: String?) -> Void)
}
