//
//  APIServices.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation

protocol APIService {
    
//MARK: - product Info
    
    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void ) )
    
}
