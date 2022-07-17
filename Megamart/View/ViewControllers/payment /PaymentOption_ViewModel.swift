//
//  PaymentOption_ViewModel.swift
//  Megamart
//
//  Created by MAC on 17/07/2022.
//

import Foundation


class PaymentOption_ViewModel: PaymentOption_Protocol {
    
    
//    var error_removeProducts: Error? {
//        didSet{
//            binding(error_removeProducts)
//        }
//    }
    
//    var binding: ((Error?) -> Void) = { _ in }
    
    var firebaseManager: FirebaseServices
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }

    

//MARK: -                           Remove Products From Cart
    
    
    var removeProductsFromCart_error: Error? {
        didSet{
            removeProductsFromCart_status(removeProductsFromCart_error)
        }
    }
    
    var removeProductsFromCart_status: ((Error?) -> Void) = { _ in }
    
    func removeFromBagCard(products: [ProductBagCard_firestore]) {
        for product in products {
            firebaseManager.removeFromCart(productId: product.id) { error in
                if let error = error {
                    self.removeProductsFromCart_error = error
                    return
                }
            }
        }
        
        self.removeProductsFromCart_error = nil
        
    }
    
    
    //MARK: -                               Save Order in API
    
    var defaults = UserDefaults.standard
    
    var saveOrder_error: Error? {
        didSet{
            saveOrder_status(saveOrder_error)
        }
    }
    
    var saveOrder_status: ((Error?) -> Void) = { _ in }
    
    
    func saveOrder( order: inout Order_Model) {
        
        guard let customerId = defaults.string(forKey: Userdefaults_key.customerId.rawValue) else { return }
        order.id = customerId + order.created_at
        firebaseManager.saveOrder(order: order) { error in
            if let error = error {
                self.saveOrder_error = error
            }
            else{
                self.saveOrder_error = nil
            }
        }
    }

    

    
    
}
