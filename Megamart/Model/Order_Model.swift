//
//  Order_Model.swift
//  Megamart
//
//  Created by MAC on 16/07/2022.
//

import Foundation


struct Order_Model: Codable {

    var id: String
    let products: [ProductBagCard_firestore]
    let totalPrice: String
    let created_at: String
    var address: Order_Address?


}

struct Order_Address: Codable {
    let street: String
    let city: String
    let country: String
    let phoneNumber: String
}
