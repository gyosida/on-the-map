//
//  ParseStudentService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/15/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class ParseStudentLocationService : StudentLocationsService {
    
    private let networkingManager = NetworkingManager(host: Constants.PARSE_HOST)
    private let parseHeaders = [
        Constants.HeaderKeys.X_PARSE_APPLICATION_ID : Constants.PARSE_APP_ID,
        Constants.HeaderKeys.X_PARSE_REST_API_KEY : Constants.PARSE_REST_API_KEY
    ]
    
    func getStudentLocations(limit: String?, skip: String?, order: String?, successHandler: (studentLocations: [StudentLocation]) -> Void, failureHandler: (error: String) -> Void) {
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
        getStudentLocationsInternal(optionalQueryParams, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    func getStudentLocations(studentKey: String, successHandler: (studentLocations: [StudentLocation]) -> Void, failureHandler: (error: String) -> Void) {
        let params: [String: AnyObject] = [Constants.JSONBodyKeys.PARSE_STUDENT_UNIQUE_KEY : studentKey]
        getStudentLocationsInternal(params, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private func getStudentLocationsInternal(genericParams: [String : AnyObject], successHandler: (studentLocations: [StudentLocation]) -> Void, failureHandler: (error: String) -> Void) {
        let urlRequest = self.networkingManager.createURLRequest(.GET, resourcePath: Constants.Methods.PARSE_GET_STUDENT_LOCATIONS, queryParams: genericParams, bodyParameters: nil, headers: self.parseHeaders)
        self.networkingManager.makeHttpRequest(urlRequest) { (result, error) -> Void in
            guard error == nil else {
                failureHandler(error: "\(error)")
                return
            }
            if let result = result {
                let json = result as! [String:AnyObject]
                let locationsArray = json[Constants.JSONResponseKeys.RESULTS] as! [[String: AnyObject]]
                let studentLocations = StudentLocation.fromJSON(locationsArray)
                if let studentLocations = studentLocations {
                    successHandler(studentLocations: studentLocations)
                } else {
                    failureHandler(error: "Could not parse locations")
                }
            }
        }
    }
    
    func saveStudentLocation(studentLocation: StudentLocation, successHandler: () -> Void, failureHandler: (error: String) -> Void) {
        let bodyParameters = studentLocationToDictionary(studentLocation)
        let urlRequest = self.networkingManager.createURLRequest(.POST, resourcePath: Constants.Methods.PARSE_POST_STUDENT_LOCATION, queryParams: nil, bodyParameters: bodyParameters, headers: parseHeaders)
        self.networkingManager.makeHttpRequest(urlRequest) { (result, error) -> Void in
            guard error == nil else {
                failureHandler(error: "\(error)")
                return
            }
            successHandler()
        }
    }
    
    func updateStudentLocation(studentLocation: StudentLocation, successHandler: () -> Void, failureHandler: (error: String) -> Void) {
        let bodyParameters = studentLocationToDictionary(studentLocation)
        let resourcePath = networkingManager.subtituteKeyInMethod(Constants.Methods.PARSE_PUT_STUDENT_LOCATION, key: Constants.URLKeys.USER_ID, value: studentLocation.objectId!)!
        let urlRequest = networkingManager.createURLRequest(.PUT, resourcePath: resourcePath, queryParams: nil, bodyParameters: bodyParameters, headers: parseHeaders)
        networkingManager.makeHttpRequest(urlRequest) { (result, error) in
            guard error == nil else {
                failureHandler(error: "\(error)")
                return
            }
            successHandler()
        }
    }
    
    private func studentLocationToDictionary(studentLocation: StudentLocation) -> [String: AnyObject] {
        let bodyParameters: [String: AnyObject!] = [
            Constants.JSONBodyKeys.PARSE_STUDENT_UNIQUE_KEY : studentLocation.uniqueKey!,
            Constants.JSONBodyKeys.PARSE_STUDENT_FIRST_NAME : studentLocation.firstName,
            Constants.JSONBodyKeys.PARSE_STUDENT_LAST_NAME : studentLocation.lastName,
            Constants.JSONBodyKeys.PARSE_STUDENT_LATITUDE : studentLocation.latitude,
            Constants.JSONBodyKeys.PARSE_STUDENT_LONGITUDE : studentLocation.longitude,
            Constants.JSONBodyKeys.PARSE_STUDENT_MEDIA_URL : studentLocation.mediaUrl,
            Constants.JSONBodyKeys.PARSE_STUDENT_MAP_STRING : studentLocation.mapString
        ]
        return bodyParameters
    }
    
}