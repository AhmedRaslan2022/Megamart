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

    
//MARK: -       register new user
    
    func registerCustomer(newCustomer: NewCustomer, completion: @escaping ((NewCustomer?, Error?) -> Void))
    
}

<<<<<<< HEAD
//MARK: - products
protocol ProductsAPIService {
    
    func fetchProducts(endPoint: String, completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}
=======
>>>>>>> firebase
