//
//  Customer_model.swift
//  Megamart
//
//  Created by MAC on 04/07/2022.
//

import Foundation


struct NewCustomer: Codable {
    let customer: Customer
}

struct Customer: Codable {
    var first_name, email, tags: String?
    var id: Int?
    var addresses: [Address]?
    // token for firebase
    var last_order_id: String?
    
    
}

struct Address: Codable {
    var id : Int?
    var customer_id : Int?
    var address1, city: String?
    var country: String?
    var phone : String?
}

struct NewAddress : Codable{
    var customer_address : Address?
}

struct CustomerAddress: Codable {
    var addresses: [Address]?
}

struct Addresses: Codable {
    var addresses: Address
}


// MARK: - Customer
//struct Customer: Codable {
//
//    let customers: [CustomerElement]
//}
//
//// MARK: - CustomerElement
//
//struct CustomerElement: Codable {
//
//    let id: Int?
//    let email: String
//    let name: String
//    let password: String?
//    let token_key: String?
//    let defaultAddress: Address?
//
//
//    enum CodingKeys: String, CodingKey {
//        case id, email
//        case name = "first_name"
//        case password = "phone"
//        case token_key = "last_order_name"
//        case defaultAddress = "default_address"
//
//    }
//}
//
//
//// MARK: - Address
//
//struct Address: Codable {
//
//    let id, customerID: Int
//    let name: String
//    let city, country, zip: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case customerID = "customer_id"
//        case name = "first_name"
//        case  city, country, zip
//
//    }
//}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
