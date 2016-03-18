//
//  BaseViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/17/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator: SpinnerIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = SpinnerIndicator(parentView: self.view)        
    }
    
    func displayError(error: String) {
        self.activityIndicator.stopAnimation()
        print(error)
    }
    
    func getDefaultErrorHandler() -> (error: String) -> Void {
        return {
            (error: String) -> Void in
            self.displayError(error)
        }
    }
    
}
