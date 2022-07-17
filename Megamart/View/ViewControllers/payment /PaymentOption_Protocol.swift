//
//  PaymentOption_Protocol.swift
//  Megamart
//
//  Created by MAC on 17/07/2022.
//

import Foundation

protocol PaymentOption_Protocol {
    
    //MARK: -                           Remove Products From Friebse
    
    var removeProductsFromCart_status: ((Error?) -> Void) {set get}
    func removeFromBagCard(products: [ProductBagCard_firestore])
    
    
    //MARK: -                               Save Order in Firebase
    
    var saveOrder_status: ((Error?) -> Void) {get set}
    func saveOrder( order: inout Order_Model)
    
}
