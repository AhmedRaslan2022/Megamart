//
//  Category_Model.swift
//  Megamart
//
//  Created by Macintosh on 08/07/2022.
//

import Foundation
struct Collects: Codable {
    let collects: [Collect]
}

// MARK: - Collect
struct Collect: Codable {
    let id, collectionID, productID: Int
  

    enum CodingKeys: String, CodingKey {
        case id
        case collectionID = "collection_id"
        case productID = "product_id"
  
    }
}
