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
    
    var addToFavorites_error: Error? {
        didSet{
            addToFavorites_status(error)
        }
    }
    
    
    var bindingData: ((ProductModel?, Error?) -> Void) = {_, _ in }
    
    var apiService: APIService
    var firebaseManager: FirebaseServices
    
    init(apiService: APIService = NetworkManager(), firebaseManager: FirebaseServices = FirebaseManager() ) {
        self.apiService = apiService
        self.firebaseManager = firebaseManager
    }
    
    func fetchData(endPoint: String) {
        apiService.fetchProductInfo(endPoint: endPoint) { product, error in
            if let product = product {
                self.data = product
            }
            if let error = error {
                self.error = error
            }
        }
    }

    
//MARK: -                           Add Product To Favorites
    
    
    
    var addToFavorites_status: ((Error?) -> Void) = { _ in }
    
    func addToFavorites(product: ProductModel) {
        firebaseManager.updateFavorites(product: product) { error in
            if let error = error {
                self.addToFavorites_error = error
            }
            else{
                self.addToFavorites_error = nil
            }
        }
    }
}
