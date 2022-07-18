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
    
//MARK: -                    remove from Cart
    
    var removeFromBagCard_status: ((Error?) -> Void) {set get}
    func removeFromBagCard(productId: String)

//MARK: -                       Add to Cart
    
    func addToBagCart(product: ProductModel , count: Int)
    var addToBagCart_status: ((Error?) -> Void) {set get}
    
    
//MARK: -               get current Time
    
    func getCurrentTime() -> String

}
