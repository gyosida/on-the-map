//
//  Student.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

struct StudentLocation {
    
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var longitude: Double?
    var latitude: Double?
    var mediaUrl: String?
    var mapString: String?
    
    static func fromJSON(json: [[String: AnyObject]]) -> [StudentLocation]? {
        guard !json.isEmpty else {
            return nil
        }
        var studentLocations = [StudentLocation]()
        for studentLocationDictionary in json {
            let studentLocation = StudentLocation.fromJSON(studentLocationDictionary)
            if studentLocation != nil {
                studentLocations.append(studentLocation!)
            }
        }
        return studentLocations
    }
    
    static func fromJSON(json: [String: AnyObject]) -> StudentLocation? {
        guard !json.isEmpty else {
            return nil
        }
        var student = StudentLocation()
        if let uniqueKey = json[Constants.JSONResponseKeys.PARSE_STUDENT_UNIQUE_KEY] as? String {
            student.uniqueKey = uniqueKey
        }
        if let firstName = json[Constants.JSONResponseKeys.PARSE_STUDENT_FIRST_NAME] as? String {
            student.firstName = firstName
        }
        if let longitude = json[Constants.JSONResponseKeys.PARSE_STUDENT_LONGITUDE] as? Double {
            student.longitude = longitude
        }
        if let latitude = json[Constants.JSONResponseKeys.PARSE_STUDENT_LATITUDE] as? Double {
            student.latitude = latitude
        }
        if let mediaUrl = json[Constants.JSONResponseKeys.PARSE_STUDENT_MEDIA_URL] as? String {
            student.mediaUrl = mediaUrl
        }
        if let mapString = json[Constants.JSONResponseKeys.PARSE_STUDENT_MAP_STRING] as? String {
            student.mapString = mapString
        }
        return student
    }
    
}