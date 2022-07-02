//
//  Product_model.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation

struct Product: Codable {
    let product: ProductClass
}

// MARK: - ProductClass

struct ProductClass: Codable {

    let title: String
    // description
    let bodyHTML: String
    // price
    let variants: [Variant]
    let images: [Image]
}

// MARK: - Variant
struct Variant: Codable {
    let price: String
}

struct Image: Codable {
    let src: String
}
