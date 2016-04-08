//
//  UdacityUserService.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/18/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class UdacityUserService: UserService {
    
    private let networkingManager = NetworkingManager(scheme: Constants.SCHEME, host: Constants.UDACITY_HOST, reduceDataLength: true)
    
    func getUser(userId: String, successHandler: (user: User) -> Void, failureHandler: (error: String) -> Void) {
        let path = self.networkingManager.subtituteKeyInMethod(Constants.Methods.UDACITY_USER, key: Constants.URLKeys.USER_ID, value: userId)!
        self.networkingManager.makeHttpRequest(.GET, resourcePath: path, queryParams: nil, bodyParameters: nil) { (result, error) -> Void in
            guard error == nil else {
                failureHandler(error: "\(error)")
                return
            }
            let user = User.fromJSON(result as! [String:AnyObject])
            if user != nil {
                successHandler(user: user!)
            } else {
                failureHandler(error: "Could not parse")
            }
        }
    }
    
}
