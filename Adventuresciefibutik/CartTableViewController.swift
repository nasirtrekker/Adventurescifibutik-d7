//
//  CartTableViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    weak var cartDelegate: ShoppingCartDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ItemInCartTableViewCell", bundle: nil), forCellReuseIdentifier: "cellItemInCart")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return shoppingCart.items.count
            
        case 1:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            tableView.rowHeight = 80
            
            let item = shoppingCart.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellItemInCart", for: indexPath) as! ItemInCartTableViewCell
            cell.item = item
            cell.itemIndexPath = indexPath
            cell.delegate = self
            
            return cell
            
        case 1:
            tableView.rowHeight = 40
            
            // Subtotal ( xx items) .... $$$
            let itemStr = shoppingCart.items.count == 1 ? "item" : "items"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSummary", for: indexPath)
            cell.textLabel?.text = "Subtotal (\(shoppingCart.totalItem()) \(itemStr))"
            cell.detailTextLabel?.text = shoppingCart.totalItemCost().currencyFormatter
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
    // MARK: - Tableview Delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Review Items"
            
        default:
            return ""
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapContinueShopping(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - ShoppingCartDelegate

extension CartTableViewController: ShoppingCartDelegate {
    func updateTotalCartItem() {
        // Invoke delegate in ProductDetailViewController to update the number of item in cart
        cartDelegate?.updateTotalCartItem()
        
        checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false
        
        tableView.reloadData()
    }
    
    func confirmRemoval(forProduct product: Product, itemIndexPath: IndexPath) {
        let alertController = UIAlertController(title: "Remove Item", message: "Remove \(product.name!.uppercased()) from your shopping cart?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let removeAction = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive) { [weak self] (action: UIAlertAction) in
            self?.shoppingCart.delete(product: product)
            self?.tableView.deleteRows(at: [itemIndexPath], with: UITableViewRowAnimation.fade)
            self?.tableView.reloadData()
            
            self?.updateTotalCartItem()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


