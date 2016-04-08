//
//  AlertUtils.swift
//  OnTheMap
//
//  Created by Gianfranco Yosida on 4/7/16.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

extension Utils {
    
    static func createDefaultAlert(title: String?, message: String?, actions: [UIAlertAction]?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        }
        return alertController
    }
    
    static func createErrorAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        alertController.addAction(
            UIAlertAction(title: "Accept", style: .Default, handler: nil)
        )
        return alertController
    }
    
}
