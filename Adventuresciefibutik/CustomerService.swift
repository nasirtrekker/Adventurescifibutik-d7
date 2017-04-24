//
//  CustomerService.swift
//  Adventuresciefibutik
//
//  Created by Nasir Uddin on 20/04/2017.
//  Copyright © 2017 Nasir Uddin. All rights reserved.
//

import Foundation
import CoreData

struct CustomerService {
    static var managedObjectContext = CoreDataStack().persistentContainer.viewContext
    
    static internal func verify(username: String, password: String) -> Customer? {
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@ AND password = %@", username, password)
        
        do {
            let result = try managedObjectContext.fetch(request)
            
            if result.count > 0 {
                return result.first
            }
            
            return nil
        }
        catch let error as NSError {
            print("Error verifying customer login: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    static internal func addCustomer(name: String, email: String, password: String) -> Customer {
        let customer = Customer(context: managedObjectContext)
        customer.name = name
        customer.email = email
        customer.password = password
        
        do {
            try managedObjectContext.save()
            return customer
        }
        catch let error as NSError {
            fatalError("Error create a new customer: \(error.localizedDescription)")
        }
    }
    
    
    static func addressList(forCustomer customer: Customer) -> [Address] {
        let addresses = customer.address?.mutableCopy() as! NSMutableSet
        return addresses.allObjects as! [Address]
    }
    
    
    static func addAddress(forCustomer customer: Customer, address1: String, address2: String, city: String, state: String, zip: String, phone: String) -> Address {
        
        let address = Address(context: managedObjectContext)
        address.address1 = address1
        address.address2 = address2
        address.city = city
        address.state = state
        address.zip = zip
        
        let addresses = customer.address?.mutableCopy() as! NSMutableSet
        addresses.add(address)
        
        customer.address = addresses.copy() as? NSSet
        customer.phone = phone
        
        do {
            try managedObjectContext.save()
            return address
        }
        catch let error as NSError {
            fatalError("Error adding customer address: \(error.localizedDescription)")
        }
    }
    
    
    static func addCreditCard(forCustomer customer: Customer, nameOnCard: String, cardNumber: String, expMonth: Int, expYear: Int) -> CreditCard {
        
        let creditCard = CreditCard(context: managedObjectContext)
        creditCard.nameOnCard = nameOnCard
        creditCard.cardNumber = cardNumber
        creditCard.expMonth = Int16(expMonth)
        creditCard.expYear = Int16(expYear)
        
        switch String(describing: cardNumber.characters.first!) {
        case "3":
            creditCard.type = CreditCardType.Amex.rawValue
            
        case "4":
            creditCard.type = CreditCardType.Visa.rawValue
            
        case "5":
            creditCard.type = CreditCardType.MC.rawValue
            
        case "6":
            creditCard.type = CreditCardType.Discover.rawValue
            
        default:
            creditCard.type = CreditCardType.Unknown.rawValue
        }
        
        let creditCards = customer.creditCard?.mutableCopy() as! NSMutableSet
        creditCards.add(creditCard)
        
        customer.creditCard = creditCards.copy() as? NSSet
        
        do {
            try managedObjectContext.save()
            
            return creditCard
        }
        catch let error as NSError {
            fatalError("Error adding credit card: \(error.localizedDescription)")
        }
    }
}





