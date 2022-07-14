//
//  Favorites_viewModel.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation

class Favorites_viewModel: Favorites_protocol {
    
    
   
    var products: [productEntity_firestore] = [] {
        didSet{
            binding(products,nil)
        }
    }
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var binding: (([productEntity_firestore]?, Error?) -> Void) = {_,_ in }
    
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
    
}
