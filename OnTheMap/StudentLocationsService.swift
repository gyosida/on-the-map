//
//  StudentService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

protocol StudentLocationsService {
    
    func getStudentLocations(limit: String?, skip: String?, order: String?, successHandler: (studentLocations: [StudentLocation]) -> Void, failureHandler: (error: String) -> Void)
    func getStudentLocations(studentKey: String, successHandler: (studentLocations: [StudentLocation]) -> Void, failureHandler: (error: String) -> Void)
    func saveStudentLocation(studentLocation: StudentLocation, successHandler: () -> Void, failureHandler: (error: String) -> Void)
    func updateStudentLocation(studentLocation: StudentLocation, successHandler: () -> Void, failureHandler: (error: String) -> Void)
}
