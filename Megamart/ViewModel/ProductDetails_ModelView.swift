//
//  ProductDetails_ModelView.swift
//  Megamart
//
//  Created by MAC on 03/07/2022.
//

import Foundation

class ProductDetails_modelView: ProductDetails_Protocol {
    
    
    var data: ProductModel? {
        didSet{
            bindingData(data, nil)
        }
    }
    
    var error: Error? {
        didSet{
            bindingData(nil, error)
        }
    }
    
    var bindingData: ((ProductModel?, Error?) -> Void) = {_, _ in }
    
    var apiService: APIService
    
    init(apiService: APIService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func fetchData(endPoint: String) {
        apiService.fetchProductInfo(endPoint: endPoint) { product, error in
            if let product = product {
                print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\(product)")
                self.data = product
            }
            if let error = error {
                print("%%%%%%%%%%%%%%%%%%%%5 \(error)")
                self.error = error
            }
        }
    }
    
}
