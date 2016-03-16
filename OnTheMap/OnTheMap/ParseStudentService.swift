//
//  ParseStudentService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/15/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class ParseStudentService : StudentService {
    
    private let networkingManager = NetworkingManager(host: Constants.PARSE_HOST)
    private let parseHeaders = [
        Constants.HeaderKeys.X_PARSE_APPLICATION_ID : Constants.PARSE_APP_ID,
        Constants.HeaderKeys.X_PARSE_REST_API_KEY : Constants.PARSE_REST_API_KEY
    ]
    
    func getStudentLocations(limit: String?, skip: String?, order: String?, completionHandler: (success: Bool, studentLocations: [StudentLocation]?, error: String?) -> Void) {
        var optionalQueryParams = [String: AnyObject]()
        if let limit = limit {
            optionalQueryParams[Constants.ParameterKeys.LIMIT] = limit
        }
        if let skip = skip {
            optionalQueryParams[Constants.ParameterKeys.SKIP] = skip
        }
        if let order = order {
            optionalQueryParams[Constants.ParameterKeys.ORDER] = order
        }
        let urlRequest = self.networkingManager.createURLRequest(.GET, resourcePath: Constants.Methods.PARSE_GET_STUDENT_LOCATIONS, queryParams: optionalQueryParams, bodyParameters: nil, headers: self.parseHeaders)
        self.networkingManager.makeHttpRequest(.GET, request: urlRequest) { (result, error) -> Void in
            guard error == nil else {
                completionHandler(success: false, studentLocations: nil, error: "\(error)")
                return
            }
            if let result = result {
                let json = result as! [String:AnyObject]
                let locationsArray = json[Constants.JSONResponseKeys.RESULTS] as! [[String: AnyObject]]
                let studentLocations = StudentLocation.fromJSON(locationsArray)
                if let studentLocations = studentLocations {
                    completionHandler(success: true, studentLocations: studentLocations, error: nil)
                } else {
                    completionHandler(success: false, studentLocations: nil, error: "Could not parse locations")
                }
            }
        }
    }
    
}