//
//  Products.swift
//  Megamart
//
//  Created by Macintosh on 03/07/2022.
//


import Foundation

struct productStruct: Codable {
    let id: String
    let title: String
    let image: String
}

// MARK: - Product
struct Product: Codable {
    let product: ProductModel
}

// MARK: - ProductClass
struct ProductModel: Codable {
    let id: Int
    let title: String
    let vendor: String
    // description
    let body_html: String
    // price
    let variants: [Variant]
    let images: [Image]
    let options: [OptionList]?
    let product_type: String?
    let image: Image
}



struct Variant: Codable {
    let price: String
}


struct Image: Codable {
    let src: String
}


struct OptionList:Codable{

    let id: Int
    let product_id: Int
    let name: String
    let position: Int
    // sizes
    let values: [String]?

}

