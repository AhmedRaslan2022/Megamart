//
//  APIServices.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation



//MARK: -                         Fetch Product Details

protocol FetchProductDetailsProtocol {
    
    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void ) )

}


//MARK: -                               Brands

protocol BrandsAPIService {
    
    func fetchBrands(completion: @escaping (([SmartCollection]?, Error?) -> Void ) )
    
}

//MARK: -                               products

protocol ProductsAPIService {
    
    func fetchProducts(completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}

//MARK: -                               Categoty

protocol CategotyAPIService {
    
    func fetchCategoty(completion: @escaping (([ProductModel]?, Error?) -> Void ) )
    
}


//MARK: -                                Collections
protocol CollectsAPIService {
    
    func fetchCollects(completion: @escaping (([Collect]?, Error?) -> Void ) )
}
