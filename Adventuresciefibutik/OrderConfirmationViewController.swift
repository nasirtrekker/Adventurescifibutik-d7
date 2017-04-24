//
//  OrderConfirmationViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//


import UIKit

class OrderConfirmationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var orderConfirmationNumberLabel: UILabel!
    
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        orderConfirmationNumberLabel.text = UUID().uuidString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapContinueShopping(_ sender: MyButton) {
        dismiss(animated: true, completion: nil)
        shoppingCart.reset()
    }
}

