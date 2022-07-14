//
//  ProductDetails_protocol.swift
//  Megamart
//
//  Created by MAC on 03/07/2022.
//

import Foundation

protocol ProductDetails_Protocol {
   
    // fetch product details
    func fetchData (endPoint: String)
    var  bindingData: ((ProductModel?, Error?) -> Void ) {set get}
    
    // add product to favorites
    func addToFavorites(product: ProductModel)
    var addToFavorites_status: ((Error?) -> Void) {set get}
    
    // remove from favorites
    var removeFromFavorites_status: ((Error?) -> Void) {set get}
    func removeFromFavorites(productId: Int)

}
