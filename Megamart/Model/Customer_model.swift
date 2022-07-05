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

struct AllCustomers: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    // tags is password
    var first_name, email, tags: String?
    var id: Int?
    var addresses: [Address]?
    // token for firebase
    var lastName: String?
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

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
