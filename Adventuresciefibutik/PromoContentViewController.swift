//
//  PromoContentViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 17/03/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class PromoContentViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var promoImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var pageIndex = 0
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentImage = imageName {
            promoImageView.image = UIImage(named: currentImage)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
