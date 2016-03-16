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

class LocationsMapViewController: UIViewController {
    
    @IBOutlet weak var locationsMapView: MKMapView!
    let studentManager = StudentManager(studentService: ParseStudentService())
    var studentLocations:[StudentLocation]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsMapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.studentManager.getStudentLocations { (success, studentLocations, error) -> Void in
            if success {
                var annotations = [MKPointAnnotation]()
                self.studentLocations = studentLocations!
                for location in studentLocations! {
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
                    let annotation = MKPointAnnotation()
                    annotation.title = "\(location.firstName) \(location.lastName)"
                    annotation.subtitle = location.mediaUrl
                    annotation.coordinate = coordinate
                    annotations.append(annotation)
                }
                self.locationsMapView.addAnnotations(annotations)
            } else {
                print("Not able to retrieve studentlocations! :(")
            }
        }
    }
    
}

extension LocationsMapViewController: MKMapViewDelegate {
    
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
    
}