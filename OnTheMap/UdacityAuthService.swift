//
//  UdacityAuthService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/11/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class UdacityAuthService: AuthService {
    
    private let networkingManager = NetworkingManager(scheme: Constants.SCHEME, host: Constants.UDACITY_HOST, reduceDataLength: true)
    
    func login(username: String, password: String, successHandler: (session: Session?) -> Void, failureHandler: (error: String) -> Void) {
        let body = [
            Constants.JSONBodyKeys.UDACITY: [
                Constants.JSONBodyKeys.UDACITY_USERNAME:username,
                Constants.JSONBodyKeys.UDACITY_PASSWORD:password
            ]
        ]
        self.networkingManager.makeHttpRequest(.POST, resourcePath: Constants.Methods.UDACITY_NEW_SESSION, queryParams: nil, bodyParameters: body) { (result, error) -> Void in
            guard error == nil else {
                failureHandler(error: "\(error)")
                return
            }
            let session = Session.fromJSON(result as! [String:AnyObject])
            if session != nil {
                successHandler(session: session)
            } else {
                failureHandler(error: "Could not parse")
            }
        }
    }
    
}