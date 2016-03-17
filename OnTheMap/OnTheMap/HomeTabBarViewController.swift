//
//  BaseHomeViewController.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida Vilchez on 3/17/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addLocationPressed(sender: AnyObject) {
        print("add location now!")
    }
    
    @IBAction func refreshPressed(sender: UIBarButtonItem) {
        let selectedViewController = self.selectedViewController!
        if let delegate = selectedViewController as? LocationTabDelegate {
            delegate.refreshLocations()
        }
    }
    
}

protocol LocationTabDelegate {
    
    func refreshLocations()
    
}
