//
//  UIImage+Extension.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 18/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
