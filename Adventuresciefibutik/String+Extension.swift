//
//  String+Extension.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 11/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

extension String {
    func stripFileExtension() -> String {
        if self.contains(".") {
            // toy.jpg, .png
            return self.substring(to: self.characters.index(of: ".")!)
        }
        return self
    }
    
    func maskedPlustLast4() -> String {
        let last4CardNumber = self.substring(from: self.index(self.endIndex, offsetBy: -4))
        
        return "****\(last4CardNumber)"
    }
}
