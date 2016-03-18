//
//  Constants.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class Constants {
    static let UDACITY_HOST = "www.udacity.com"
    static let PARSE_HOST = "api.parse.com"
    static let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let PARSE_REST_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let SCHEME = "https"
    
    struct Methods {
        static let UDACITY_NEW_SESSION = "/api/session"
        static let UDACITY_USER = "/api/users/{\(URLKeys.USER_ID)}"
        static let PARSE_GET_STUDENT_LOCATIONS = "/1/classes/StudentLocation"
        static let PARSE_POST_STUDENT_LOCATION = "/1/classes/StudentLocation"
    }
    
    struct ParameterKeys {
        static let LIMIT = "limit"
        static let SKIP = "skip"
        static let ORDER = "order"
    }
    
    struct HeaderKeys {
        static let X_PARSE_APPLICATION_ID = "X-Parse-Application-Id"
        static let X_PARSE_REST_API_KEY = "X-Parse-REST-API-Key"
    }
    
    struct JSONBodyKeys {
        static let UDACITY = "udacity"
        static let UDACITY_USERNAME = "username"
        static let UDACITY_PASSWORD = "password"
        
        static let PARSE_STUDENT_FIRST_NAME = "firstName"
        static let PARSE_STUDENT_LAST_NAME = "lastName"
        static let PARSE_STUDENT_LONGITUDE = "longitude"
        static let PARSE_STUDENT_LATITUDE = "latitude"
        static let PARSE_STUDENT_MAP_STRING = "mapString"
        static let PARSE_STUDENT_MEDIA_URL = "mediaURL"
        static let PARSE_STUDENT_UNIQUE_KEY = "uniqueKey"
    }
    
    struct JSONResponseKeys {
        static let UDACITY_ACCOUNT = "account"
        static let UDACITY_KEY = "key"
        static let UDACITY_SESSION = "session"
        static let UDACITY_ID = "id"
        static let UDACITY_USER_KEY = "key"
        static let UDACITY_USER_FIRST_NAME = "first_name"
        static let UDACITY_USER_LAST_NAME = "last_name"
        static let UDACITY_USER = "user"
        
        static let PARSE_STUDENT_FIRST_NAME = "firstName"
        static let PARSE_STUDENT_LAST_NAME = "lastName"
        static let PARSE_STUDENT_LONGITUDE = "longitude"
        static let PARSE_STUDENT_LATITUDE = "latitude"
        static let PARSE_STUDENT_MAP_STRING = "mapString"
        static let PARSE_STUDENT_MEDIA_URL = "mediaURL"
        static let PARSE_STUDENT_UNIQUE_KEY = "uniqueKey"
        static let RESULTS = "results"
    }
    
    struct URLKeys {
        static let USER_ID = "id"
    }
    
}