//
//  Favorites_viewModel.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation

class Favorites_viewModel: Favorites_protocol {
    
    
   
    var products: [ProductEntity_firestore] = [] {
        didSet{
            binding(products,nil)
        }
    }
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var binding: (([ProductEntity_firestore]?, Error?) -> Void) = {_,_ in }
    
    var firebaseManager: FirebaseServices
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }
    
    
    
    func fetchFavorites() {
        firebaseManager.fetchFavorites { favorites, error in
            if let error = error {
                self.error = error
            }
            if let favorites = favorites {
                self.products = favorites
            }
        }
    }
 
    

//MARK: -                           Remove Product From Favorites
    
    
    var removeFromFavorites_error: Error? {
        didSet{
            removeFromFavorites_status(error)
        }
    }
    
    var removeFromFavorites_status: ((Error?) -> Void) = { _ in }
    
    func removeFromFavorites(productId: String) {
        firebaseManager.removeFromFavorites(productId: productId) { error in
            if let error = error {
                self.removeFromFavorites_error = error
            }
            else{
                self.removeFromFavorites_error = nil
            }
        }
    }
    
    
}


