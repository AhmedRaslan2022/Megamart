//
//  Order_Model.swift
//  Megamart
//
//  Created by MAC on 16/07/2022.
//

import Foundation


struct Order_Model: Codable {

    let id: String
    let products: [ProductBagCard_firestore]
    let totalPrice: String
    let created_at: String

}
