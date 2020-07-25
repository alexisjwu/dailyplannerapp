//
//  roundButton.swift
//  DIscoverFBLA
//
//  Created by Meena Sambandam on 2/27/18.
//  Copyright © 2018 Smriti Somasundaram. All rights reserved.
//
/**
 UIButton object use through out the app
 
 **/
import UIKit
@IBDesignable

class roundButton: UIButton {
    
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor  = borderColor.cgColor
        }
    }
    
}

