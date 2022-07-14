//
//  Favorites_protocol.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation

protocol Favorites_protocol {
    
    func fetchFavorites()
    var  binding: (([productEntity_firestore]?, Error?) -> Void) { get set }
    
    // remove from favorites
    var removeFromFavorites_status: ((Error?) -> Void) {set get}
    func removeFromFavorites(productId: String)
    
    
}
