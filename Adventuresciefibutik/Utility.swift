//
//  Utility.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 11/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class Utility {
    
    class func image(withName name: String?, andType type: String) -> UIImage? {
        let imagePath = Bundle.main.path(forResource: name?.stripFileExtension(), ofType: type)
        
        var image: UIImage?
        if let path = imagePath {
            image = UIImage(contentsOfFile: path)
        }
        
        return image
    }
    
    
    class func currentYear() -> Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(Calendar.Component.year, from: Date())
        
        return currentYear
    }
    
}
