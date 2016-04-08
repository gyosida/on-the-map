//
//  StudentLocationManager.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida on 4/7/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class StudentLocationManager {
    
    let studentLocationService: StudentLocationsService
    
    init(studentLocationService: StudentLocationsService) {
        self.studentLocationService = studentLocationService
    }
    
    func getLocationByStudent(studentKey: String, successHandler: (studentLocation: StudentLocation?) -> Void, failureHandler: (error: String) -> Void) {
        studentLocationService.getStudentLocations(studentKey, successHandler: { (studentLocations) in
                successHandler(studentLocation: studentLocations.count > 0 ? studentLocations[0] : nil)
            }, failureHandler: failureHandler)
    }
    
}