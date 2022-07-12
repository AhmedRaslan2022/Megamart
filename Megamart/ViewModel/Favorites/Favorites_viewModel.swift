//
//  Favorites_viewModel.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation

class Favorites_viewModel: Favorites_protocol {
    
   
    var products: [String: Any] = [:] {
        didSet{
            binding(products,nil)
        }
    }
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var binding: (([String : Any]?, Error?) -> Void) = {_,_ in }
    
    var firebaseManager: FirebaseServices
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }
    
    
    
    func fetchFavorites() {
        firebaseManager.fetchFavorites { ids, titles, images, error in
            if let error = error {
                self.error = error
            }
            if let ids = ids {
                if let images = images {
                    if let titles = titles {
                        self.products = ["titles": titles, "images": images, "ids": ids]
                    }
                }
            }
        }
    }
    
}
