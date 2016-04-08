//
//  BaseHomeViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/17/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

class HomeTabBarViewController: UITabBarController, ModalNavigationDelegate {
    
    static let POSTING_SEGUE = "postingLocationSegue"
    
    var activityIndicator: SpinnerIndicator!
    var existingStudentLocation: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = SpinnerIndicator(parentView: self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == HomeTabBarViewController.POSTING_SEGUE {
            let postingVC = segue.destinationViewController as! PostingViewController
            postingVC.studentLocation = existingStudentLocation
            postingVC.modalNavigationDelegate = self
        }
        super.prepareForSegue(segue, sender: sender)
    }
    
    func onNavigationCompleted() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addLocationPressed(sender: AnyObject) {
        let studentLocationManager = StudentLocationManager(studentLocationService: ServicesFactory.sharedInstance.getStudentLocationsService())
        let studentKey = UserManager.sharedInstance.getLoggedInUser().key
        activityIndicator.startAnimation()
        studentLocationManager.getLocationByStudent(studentKey, successHandler: { (studentLocation) in
                self.activityIndicator.stopAnimation()
                if let studentLocation = studentLocation {
                    let overrideAlertController = Utils.createDefaultAlert(
                        "On The Map",
                        message: "You have already posted a student location, would you like to override your current location?",
                        actions: [
                            UIAlertAction(
                                title: "Override",
                                style: .Default,
                                handler: {
                                    (action) in
                                    self.performSegueWithIdentifier(HomeTabBarViewController.POSTING_SEGUE, sender: self)
                                }
                            ),
                            UIAlertAction(title: "Cancel", style: .Default, handler: nil)
                        ]
                    )
                    self.existingStudentLocation = studentLocation
                    self.presentViewController(overrideAlertController, animated: true, completion: nil)
                } else {
                    self.performSegueWithIdentifier(HomeTabBarViewController.POSTING_SEGUE, sender:self)
                }
            }, failureHandler: {(error) in
                let errorAlertController = Utils.createErrorAlert(error)
                self.activityIndicator.stopAnimation()
                self.presentViewController(errorAlertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func refreshPressed(sender: UIBarButtonItem) {
        let selectedViewController = self.selectedViewController!
        if let delegate = selectedViewController as? LocationTabDelegate {
            delegate.refreshLocations()
        }
    }
    
}

protocol ModalNavigationDelegate {
    
    func onNavigationCompleted()
    
}

protocol LocationTabDelegate {
    
    func refreshLocations()
    
}
