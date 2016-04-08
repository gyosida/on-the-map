//
//  PostingViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/18/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PostingViewController: BaseViewController, UIBarPositioningDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    var studentLocation: StudentLocation?
    var modalNavigationDelegate: ModalNavigationDelegate?
    
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func findLocationPressed(sender: UIButton) {
        guard let location = self.locationTextField.text where !location.isEmpty else {
            return
        }
        self.performSegueWithIdentifier("locationMapSegue", sender: self)
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        print("topAttached")
        return .TopAttached
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "locationMapSegue" {
            let postingMapVC = segue.destinationViewController as! PostingMapViewController
            postingMapVC.address = locationTextField.text
            if studentLocation != nil {
                postingMapVC.studentLocation = studentLocation
            }
            if modalNavigationDelegate != nil {
                postingMapVC.modalNavigationDelegate = modalNavigationDelegate
            }
        }
        super.prepareForSegue(segue, sender: sender)
    }
    
}
