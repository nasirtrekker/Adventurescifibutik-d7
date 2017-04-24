//
//  AddressViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addressPickerView: UIPickerView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noAddressLabel: UILabel!
    
    
    
    // MARK: - Properties
    var customer: Customer?
    var addresses = [Address]()
    var selectedAddress: Address?
    var activeTextField: UITextField?
    var shoppingCart = ShoppingCart.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addressPickerView.isHidden = false
        noAddressLabel.isHidden = true
        
        if let customer = customer {
            addresses = CustomerService.addressList(forCustomer: customer)
            
            if addresses.count == 0 {
                addressPickerView.isHidden = true
                noAddressLabel.isHidden = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Private functions
    
    private func registerForKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(AddressViewController.keyboardIsOn(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(AddressViewController.keyboardIsOff(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc private func keyboardIsOn(sender: Notification) {
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize = value.cgRectValue.size
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height - 90, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardIsOff(sender: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
        scrollView.isScrollEnabled = false
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueToPayment":
                if let customer = customer {
                    shoppingCart.assignCart(toCustomer: customer)
                    
                    var address: Address
                    
                    if !(address1TextField.text?.isEmpty)! {
                        address = CustomerService.addAddress(forCustomer: customer, address1: address1TextField.text!, address2: address2TextField.text!, city: cityTextField.text!, state: stateTextField.text!, zip: zipTextField.text!, phone: phoneNumberTextField.text!)
                        
                        shoppingCart.assignShipping(address: address)
                    }
                    else {
                        if selectedAddress == nil {
                            selectedAddress = addresses[self.addressPickerView.selectedRow(inComponent: 0)]
                        }
                        
                        shoppingCart.assignShipping(address: selectedAddress!)
                    }
                    
                    let paymentController = segue.destination as! PaymentViewController
                    paymentController.customer = customer
                }
                
            default:
                break
            }
        }
    }
}


// MARK: - UIPickerView Datasource and Delegate

extension AddressViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let address = addresses[row]
        
        return "\(address.address1!) \(address.address2!), \(address.city!), \(address.state!) \(address.zip!)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAddress = addresses[row]
    }
}


// MARK: - UITextField Delegate

extension AddressViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollView.isScrollEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        
        return true
    }
}



