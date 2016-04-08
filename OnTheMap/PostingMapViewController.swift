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
    var studentLocation: StudentLocation?
    var modalNavigationDelegate: ModalNavigationDelegate?
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        print("topAttached PostingMapViewController")
        return .TopAttached
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        modalNavigationDelegate?.onNavigationCompleted()
    }
    
    @IBAction func submitPressed(sender: UIButton) {
        let studentService = ServicesFactory.sharedInstance.getStudentLocationsService()
        let mediaURL = self.shareLinkTextField.text!
        activityIndicator.startAnimation()
        if var existingStudentLocation = studentLocation {
            existingStudentLocation.mediaUrl = mediaURL
            existingStudentLocation.latitude = coordinate.latitude
            existingStudentLocation.longitude = coordinate.longitude
            existingStudentLocation.mapString =  address
            studentService.updateStudentLocation(existingStudentLocation, successHandler: {
                    self.activityIndicator.stopAnimation()
                    self.modalNavigationDelegate?.onNavigationCompleted()
                }, failureHandler: self.getDefaultErrorHandler())
        } else {
            let loggedInUser = UserManager.sharedInstance.getLoggedInUser()
            let studentLocation = StudentLocation(uniqueKey: loggedInUser.key, firstName: loggedInUser.firstName!, lastName: loggedInUser.lastName!, longitude: coordinate.longitude, latitude: coordinate.latitude, mediaUrl: mediaURL, mapString: address)
            studentService.saveStudentLocation(studentLocation, successHandler: {
                    self.activityIndicator.stopAnimation()
                    self.modalNavigationDelegate?.onNavigationCompleted()
                }, failureHandler: self.getDefaultErrorHandler())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.activityIndicator.startAnimation()
        print("Going to geocode \(address)")
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            self.activityIndicator.stopAnimation()
            guard error == nil else {
                self.displayError("Unable to process the address, please try again")
                return
            }
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
    
    private func initViews() {
        shareLinkTextField.attributedPlaceholder = NSAttributedString(string: "Enter a link to share here", attributes: [NSForegroundColorAttributeName: UIColor(hex: 0xE6E6E6)])
    }
    
}
