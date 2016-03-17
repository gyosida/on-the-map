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
    
}
