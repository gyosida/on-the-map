//
//  PostingMapViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida on 4/6/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class PostingMapViewController: BaseViewController, UIBarPositioningDelegate {
    
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var shareLinkTextField: UITextField!
    
    var address: String!
    var coordinate: CLLocationCoordinate2D!
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        print("topAttached PostingMapViewController")
        return .TopAttached
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitPressed(sender: UIButton) {
        let studentService = ServicesFactory.sharedInstance.getStudentLocationsService()
        let loggedInUser = UserManager.sharedInstance.getLoggedInUser()
        if let loggedInUser = loggedInUser {
            let mediaURL = self.shareLinkTextField.text!
            let studentLocation = StudentLocation(uniqueKey: loggedInUser.key, firstName: loggedInUser.firstName!, lastName: loggedInUser.lastName!, longitude: self.coordinate.longitude, latitude: self.coordinate.latitude, mediaUrl: mediaURL, mapString: self.address)
            studentService.saveStudentLocation(studentLocation, successHandler: {
                    print("student location saved")
                    self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                }, failureHandler: { (error) in
                    print("\(error)")
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimation()
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                return
            }
            self.activityIndicator.stopAnimation()
            if let firstPlacemark = placemarks?.first {
                self.coordinate = firstPlacemark.location?.coordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.coordinate
                var coordinateRegion = MKCoordinateRegion()
                coordinateRegion.center = self.coordinate
                self.locationMapView.addAnnotation(annotation)
                self.locationMapView.setRegion(coordinateRegion, animated: true)
            }
        }

    }
    
}
