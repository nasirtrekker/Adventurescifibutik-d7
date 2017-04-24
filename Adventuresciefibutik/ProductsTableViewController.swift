//
//  ProductsTableViewController.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 16/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//
import UIKit

class ProductsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var products: [Product]?
    var selectedProduct: Product?
    weak var delegate: ProductDetailViewController?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Products"
        
        if let products = self.products, products.count > 0 {
            self.navigationItem.title = (products.first?.type?.uppercased())!
        }
        else {
            self.products = ProductService.browse()
            if let products = self.products {
                selectedProduct = products.first
            }
        }
        
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.products?.removeAll()
        self.selectedProduct = nil
        self.delegate?.product = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = self.products {
            return products.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 70
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductsTableViewCell
        
        if let currentProduct = self.products?[indexPath.row] {
            if selectedProduct?.id == currentProduct.id {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = UIColor().Adventurescifibutik_brown().cgColor
                
                delegate?.product = selectedProduct
            }
            else {
                cell.contentView.layer.borderWidth = 0
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.configureCell(with: currentProduct)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        delegate?.product = selectedProduct
        
        tableView.reloadData()
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
