//
//  ExistingCreditCardTableViewCell.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class ExistingCreditCardTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var noCreditCardLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    internal func configureCell(withCreditCard creditCard: CreditCard) {
        noCreditCardLabel.isHidden = true
        
        cardNumberLabel.text = creditCard.cardNumber?.maskedPlustLast4()
        cardTypeImageView.image = UIImage(named: creditCard.type!)
        nameOnCardLabel.text = creditCard.nameOnCard
        expirationLabel.text = "\(creditCard.expMonth)/\(creditCard.expYear)"
    }
    
}




