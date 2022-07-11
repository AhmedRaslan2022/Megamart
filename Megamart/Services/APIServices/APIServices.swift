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

    
//MARK: -       register new customer
    
    func registerCustomer(newCustomer: NewCustomer, completion: @escaping ((NewCustomer?, Error?) -> Void))
    
//MARK: -                           Login
    
    func retriveCustomers(completion: @escaping (([Customer]?, Error?) -> Void))
    
//MARK: -                          Reset Password
    
    func restPassword(customer: NewCustomer, completion: @escaping ((Error?) -> Void))
    
    
}

//MARK: - Brands
protocol BrandsAPIService {
    
    func fetchBrands(completion: @escaping (([SmartCollection]?, Error?) -> Void ) )
    
}

//MARK: - products
protocol ProductsAPIService {
    
    func fetchProducts(completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}

//MARK: - Categoty
protocol CategotyAPIService {
    
    func fetchCategoty(completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}


//MARK: - Collects
protocol CollectsAPIService {
    
    func fetchCollects(completion: @escaping (([Collect]?, Error?) -> Void ) )
}
