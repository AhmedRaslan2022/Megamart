//
//  BagCard_viewModel.swift
//  Megamart
//
//  Created by A on 15/07/2022.
//

import Foundation


class BagCard_viewModel: BagCard_protocol {
    
    
   
    var products: [ProductBagCard_firestore] = [] {
        didSet{
            binding(products,nil)
        }
    }
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var binding: (([ProductBagCard_firestore]?, Error?) -> Void) = {_,_ in }
    
    var firebaseManager: FirebaseServices
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }
    
    
    
    func fetchBagCard() {
        firebaseManager.fetchBagCard { bagCard, error in
            if let error = error {
                self.error = error
            }
            if let bagCard = bagCard {
                self.products = bagCard
            }
        }
    }
 
    

//MARK: -                           Remove Product From bagCard
    
    
    var removeFromBagCard_error: Error? {
        didSet{
            removeFromBagCard_status(error)
        }
    }
    
    var removeFromBagCard_status: ((Error?) -> Void) = { _ in }
    
    func removeFromBagCard(productId: String) {
        firebaseManager.removeFromCart(productId: productId) { error in
            if let error = error {
                self.removeFromBagCard_error = error
            }
            else{
                self.removeFromBagCard_error = nil
            }
        }
    }
    
    
    
    
    
    var addToBagCart_error: Error? {
        didSet{
            addToBagCart_status(error)
        }
    }
    
    var addToBagCart_status: ((Error?) -> Void) = { _ in }
    
    func addToBagCart(product: ProductModel , count: String) {
        let bagCartProdcut = ProductBagCard_firestore(id: "\(product.id)", title: product.title, image: product.image.src, price: product.variants[0].price, count: count)
        firebaseManager.addToBagCard(product: bagCartProdcut) { error in
            if let error = error {
                self.addToBagCart_error = error
            }
            else{
                self.addToBagCart_error = nil
            }
        }
    }
    
}
