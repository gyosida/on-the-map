//
//  Student.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

struct StudentLocation {
    
    var objectId: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var longitude: Double?
    var latitude: Double?
    var mediaUrl: String?
    var mapString: String?
    
    init(){}
    
    init(uniqueKey: String, firstName: String, lastName: String, longitude: Double, latitude: Double, mediaUrl: String, mapString: String) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.longitude = longitude
        self.latitude = latitude
        self.mediaUrl = mediaUrl
        self.mapString = mapString
    }
    
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
        if let objectId = json[Constants.JSONResponseKeys.PARSE_STUDENT_OBJECT_ID] as? String {
            student.objectId = objectId
        }
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
    
    static func studentLocationToDictionary(studentLocation: StudentLocation) -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        if let uniqueKey = studentLocation.uniqueKey {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_UNIQUE_KEY] = uniqueKey
        }
        if let firstName = studentLocation.firstName {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_FIRST_NAME] = firstName
        }
        if let lastName = studentLocation.lastName {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_LAST_NAME] = lastName
        }
        if let latitude = studentLocation.latitude {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_LATITUDE] = latitude
        }
        if let longitude = studentLocation.longitude {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_LONGITUDE] = longitude
        }
        if let mediaURL = studentLocation.mediaUrl {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_MEDIA_URL] = mediaURL
        }
        if let mapString = studentLocation.mapString {
            dictionary[Constants.JSONBodyKeys.PARSE_STUDENT_MAP_STRING] = mapString
        }
        return dictionary
    }
    
}