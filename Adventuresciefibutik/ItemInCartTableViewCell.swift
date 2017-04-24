//
//  ItemInCartTableViewCell.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//
import UIKit

class ItemInCartTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    var item: (product: Product, qty: Int)? {
        didSet {
            if let currentItem = item {
                refreshCell(currentItem: currentItem)
            }
        }
    }
    var itemIndexPath: IndexPath?
    weak var delegate: ShoppingCartDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        qtyTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: - Private functions
    
    private func refreshCell(currentItem: (product: Product, qty: Int)) {
        productImageView.image = Utility.image(withName: currentItem.product.mainImage, andType: "jpg")
        productNameLabel.text = currentItem.product.name
        qtyTextField.text = "\(currentItem.qty)"
        priceLabel.text = currentItem.product.salePrice.currencyFormatter
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapRemove(_ sender: UIButton) {
        if let product = item?.product, let itemIndexPath = itemIndexPath {
            delegate?.confirmRemoval!(forProduct: product, itemIndexPath: itemIndexPath)
        }
    }
}


// MARK: - UITextFieldDelegate

extension ItemInCartTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let qty = qtyTextField.text, let currentItem = self.item {
            shoppingCart.update(product: currentItem.product, qty: Int(qty)!)
            delegate?.updateTotalCartItem()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


