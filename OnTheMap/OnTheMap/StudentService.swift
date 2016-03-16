//
//  StudentService.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/14/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation

protocol StudentService {
    
    func getStudentLocations(limit: String?, skip: String?, order: String?, completionHandler: (success: Bool, studentLocations: [StudentLocation]?, error: String?) -> Void)
    
}
