//
//  ProductsViewModel.swift
//  Megamart
//
//  Created by Macintosh on 04/07/2022.
//
/*
import Foundation
class ProductsViewModel: Products_Protocol {
   
    
    var productsArray: [ProductModel]? {
        didSet{
            bindingData(productsArray, nil)
        }
    }
    
    var error: Error? {
        didSet{
            bindingData(nil, error)
        }
    }
    
    var bindingData: (([ProductModel]?, Error?) -> Void) = {_, _ in }
    
    var productsApiService: ProductsAPIService
    
    init(productsApiService: ProductsAPIService = NetworkManager()) {
        self.productsApiService = productsApiService
    }
    
    func fetchData(endPoint: String) {
        productsApiService.fetchProducts(endPoint: endPoint) { products, error in
            if let products = products {
                self.productsArray = products
            }
            if let error = error {
                print("%%%%%%%%%%%%%%%%%%%%5 \(error)")
                self.error = error
            }
        }
    }
    
}
*/
