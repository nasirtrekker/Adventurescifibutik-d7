//
//  MyButton.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 17/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

@IBDesignable
class MyButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
