//
//  LocationsListViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/17/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

class LocationsListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var locationsTableView: UITableView!
    let studentManager = StudentManager(studentService: ParseStudentService())
    var studentLocations = [StudentLocation]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateStudentLocations()
    }
    
    private func updateStudentLocations() {
        self.activityIndicator.startAnimation()
        self.studentManager.getStudentLocations { (success, studentLocations, error) -> Void in
            if success {
                self.studentLocations = studentLocations!
                self.locationsTableView.reloadData()
            } else {
                print("Could not get the locations :(")
            }
            self.activityIndicator.stopAnimation()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let studentTableViewCell = (tableView.dequeueReusableCellWithIdentifier("studentIdentifier", forIndexPath: indexPath) as? StudentLocationTableViewCell)!
        let student = self.studentLocations[indexPath.item]
        var studentFullName = ""
        if let firstName = student.firstName {
            studentFullName += firstName
        }
        if let lastName = student.lastName {
            studentFullName += " " + lastName
        }
        studentTableViewCell.studentNameLabel.text = studentFullName
        return studentTableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentLocations.count
    }
    
}

extension LocationsListViewController: LocationTabDelegate {
    
    func refreshLocations() {
        self.updateStudentLocations()
    }
    
}
