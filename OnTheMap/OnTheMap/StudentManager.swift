//
//  StudentManager.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/15/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

class StudentManager {
    
    private let studentService: StudentService
    
    init(studentService: StudentService) {
        self.studentService = studentService
    }
    
    func getStudentLocations(completionHandler: (success: Bool, studentLocations: [StudentLocation]?, error: String?) -> Void) {
        self.studentService.getStudentLocations(nil, skip: nil, order: nil, completionHandler: completionHandler)
    }
    
}