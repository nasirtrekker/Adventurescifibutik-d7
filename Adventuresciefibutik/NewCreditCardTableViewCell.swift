//
//  NewCreditCardTableViewCell.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//
import UIKit

enum CreditCardType: String {
    case Visa = "visa"
    case MC = "mastercard"
    case Amex = "amex"
    case Discover = "discover"
    case Unknown = "unknown"
}

protocol CreditCardDelegate: class {
    func add(card: CreditCard)
}

class NewCreditCardTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expMonthButton: MyButton!
    @IBOutlet weak var expYearButton: MyButton!
    
    
    // MARK: - Properties
    
    var customer: Customer?
    weak var creditCardDelegate: CreditCardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: - IBAction
    
    @IBAction func didTapAddCard(_ sender: MyButton) {
        guard let nameOnCard = nameOnCardTextField.text else {
            return
        }
        guard let cardNumber = cardNumberTextField.text else {
            return
        }
        guard let expMonth = expMonthButton.titleLabel?.text else {
            return
        }
        guard let expYear = expYearButton.titleLabel?.text else {
            return
        }
        
        let creditCard = CustomerService.addCreditCard(forCustomer: self.customer!, nameOnCard: nameOnCard, cardNumber: cardNumber, expMonth: Int(expMonth)!, expYear: Int(expYear)!)
        
        creditCardDelegate?.add(card: creditCard)
        
        // Reset credit card info
        nameOnCardTextField.text = ""
        cardNumberTextField.text = ""
        expMonthButton.setTitle("01", for: UIControlState.normal)
        expYearButton.setTitle("\(Utility.currentYear())", for: UIControlState.normal)
    }
}
