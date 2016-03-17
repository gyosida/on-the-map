//
//  LocationsMapViewController.swift
//  OnTheMap
//
//  Created by Gianfranco on 3/16/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationsMapViewController: BaseViewController {
    
    @IBOutlet weak var locationsMapView: MKMapView!
    let studentManager = StudentManager(studentService: ParseStudentService())
    var studentLocations:[StudentLocation]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsMapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateStudentLocations()
    }
    
    private func updateStudentLocations() {
        self.activityIndicator.startAnimation()
        self.studentManager.getStudentLocations { (success, studentLocations, error) -> Void in
            if success {
                var annotations = [MKPointAnnotation]()
                self.studentLocations = studentLocations!
                self.locationsMapView.removeAnnotations(self.locationsMapView.annotations)
                for location in studentLocations! {
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
                    let annotation = MKPointAnnotation()
                    var title = ""
                    if let firstName = location.firstName {
                        title += firstName
                    }
                    if let lastName = location.lastName {
                        title += " " + lastName
                    }
                    annotation.title = title
                    annotation.subtitle = location.mediaUrl
                    annotation.coordinate = coordinate
                    annotations.append(annotation)
                }
                self.locationsMapView.addAnnotations(annotations)
            } else {
                print("Not able to retrieve studentlocations! :(")
            }
            self.activityIndicator.stopAnimation()
        }
    }
    
}

extension LocationsMapViewController: MKMapViewDelegate, LocationTabDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "location"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let subtitle = view.annotation!.subtitle!!
            print("Opening: \(subtitle)")
            UIApplication.sharedApplication().openURL(NSURL(string: subtitle)!)
        }
    }
    
    func refreshLocations() {
        print("Refreshing locations...")
        self.updateStudentLocations()
    }
    
}