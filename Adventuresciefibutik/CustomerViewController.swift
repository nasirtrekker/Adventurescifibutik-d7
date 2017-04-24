//
//  CustomerViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//
import UIKit

class CustomerViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBack = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        self.navigationItem.leftBarButtonItem = navBack
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueAddAddress":
                guard let name = nameTextField.text,
                    let email = emailTextField.text,
                    let password = passwordTextField.text,
                    name.characters.count > 0, email.characters.count > 0, !password.isEmpty else {
                        let alertController = UIAlertController(title: "Missing Information", message: "Please provide all the information for name, email and password", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                        
                        alertController.addAction(okAction)
                        present(alertController, animated: true, completion: nil)
                        
                        return
                }
                
                let customer = CustomerService.addCustomer(name: name, email: email, password: password)
                
                let addressController = segue.destination as! AddressViewController
                addressController.customer = customer
                
            default:
                break
            }
        }
    }
}
























