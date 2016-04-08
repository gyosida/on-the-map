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
    let studentLocationsService = ServicesFactory.sharedInstance.getStudentLocationsService()
    var studentLocations = [StudentLocation]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateStudentLocations()
    }
    
    private func updateStudentLocations() {
        self.activityIndicator.startAnimation()
        self.studentLocationsService.getStudentLocations(nil, skip: nil, order: nil, successHandler: { (studentLocations) -> Void in
                self.studentLocations = studentLocations
                self.locationsTableView.reloadData()
                self.activityIndicator.stopAnimation()
            }, failureHandler: self.getDefaultErrorHandler())
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let studentTableViewCell = (tableView.dequeueReusableCellWithIdentifier("studentLocationIdentifier", forIndexPath: indexPath) as? StudentLocationTableViewCell)!
        let studentLocation = self.studentLocations[indexPath.item]
        var studentFullName = ""
        if let firstName = studentLocation.firstName {
            studentFullName += firstName
        }
        if let lastName = studentLocation.lastName {
            studentFullName += " " + lastName
        }
        studentTableViewCell.studentNameLabel.text = studentFullName
        return studentTableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentLocations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let studentLocation = studentLocations[indexPath.item]
        if let mediaURL = studentLocation.mediaUrl {
            UIApplication.sharedApplication().openURL(NSURL(string: mediaURL)!)
        } else {
            displayError("Student does not have a link attached")
        }
    }
    
}

extension LocationsListViewController: LocationTabDelegate {
    
    func refreshLocations() {
        self.updateStudentLocations()
    }
    
}
