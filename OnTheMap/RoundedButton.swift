//
//  RoundedButton.swift
//  OnTheMap
//
//  Created by Arturo Gamarra on 12/21/15.
//  Copyright © 2016 Gianfranco. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderWith:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWith
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.clearColor() {
        didSet {
            self.layer.borderColor = self.borderColor.CGColor
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        self.clipsToBounds = true
        self.layer.borderWidth = self.borderWith
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.cornerRadius = self.cornerRadius
    }
}

