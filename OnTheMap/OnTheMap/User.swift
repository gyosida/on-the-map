//
//  Student.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/18/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class User {
    
    let key: String
    var firstName: String?
    var lastName: String?
    
    init(key: String) {
        self.key = key
    }
    
    static func fromJSON(json: [String: AnyObject]) -> User? {
        guard let userDictionary = json[Constants.JSONResponseKeys.UDACITY_USER] as? [String: AnyObject] else {
            return nil
        }
        let user = User(key: userDictionary[Constants.JSONResponseKeys.UDACITY_KEY] as! String)
        if let firstName = userDictionary[Constants.JSONResponseKeys.UDACITY_USER_FIRST_NAME] as? String {
            user.firstName = firstName
        }
        if let lastName = userDictionary[Constants.JSONResponseKeys.UDACITY_USER_LAST_NAME] as? String {
            user.lastName = lastName
        }
        return user
    }
    
}
