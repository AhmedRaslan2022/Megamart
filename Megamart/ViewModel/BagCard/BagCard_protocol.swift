//
//  BagCard_protocol.swift
//  Megamart
//
//  Created by A on 15/07/2022.
//

import Foundation


protocol BagCard_protocol {
    
    func fetchBagCard()
    var  binding: (([ProductBagCard_firestore]?, Error?) -> Void) { get set }
    
    // remove from bagcart
    var removeFromBagCard_status: ((Error?) -> Void) {set get}
    func removeFromBagCard(productId: String)
    
    
    func addToBagCart(product: ProductModel , count: String)
    var addToBagCart_status: ((Error?) -> Void) {set get}
}
