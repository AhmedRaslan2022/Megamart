//
//  ProductDetails_protocol.swift
//  Megamart
//
//  Created by MAC on 03/07/2022.
//

import Foundation

protocol ProductDetails_Protocol {
    func fetchData (endPoint: String)
    var  bindingData: ((ProductModel?, Error?) -> Void ) {set get}
}
