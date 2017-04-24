//
//  Double+Extension.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 16/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var percentFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
