//
//  Session.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

struct Session {
    let key: String
    let sessionId: String
    
    init(key:String, sessionId: String) {
        self.key = key
        self.sessionId = sessionId
    }
    
    static func fromJSON(json: [String: AnyObject]) -> Session? {
        guard let account = json[Constants.JSONResponseKeys.UDACITY_ACCOUNT], key = account[Constants.JSONResponseKeys.UDACITY_KEY] as? String else {
            return nil
        }
        guard let session = json[Constants.JSONResponseKeys.UDACITY_SESSION], sessionId = session[Constants.JSONResponseKeys.UDACITY_ID] as? String else {
            return nil
        }
        return Session(key: key, sessionId: sessionId)
    }
    
}
