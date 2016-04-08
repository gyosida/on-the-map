//
//  ServicesFactory.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/18/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class ServicesFactory {
    
    static let sharedInstance = ServicesFactory()
    
    private init() {}
    
    func getAuthService() -> AuthService {
        return UdacityAuthService()
    }
    
    func getUserService() -> UserService {
        return UdacityUserService()
    }
    
    func getStudentLocationsService() -> StudentLocationsService {
        return ParseStudentLocationService()
    }
    
}