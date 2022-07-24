//
//  NetworkManagerMock.swift
//  MegamartTests
//
//  Created by MAC on 23/07/2022.
//

import Foundation
@testable import Megamart


protocol APIServices: FetchProductDetailsProtocol, RetrieveCustomersProtocol_API, ProductsAPIService {
}


class NetworkManagerMock: APIServices {
    
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool){
        self.shouldReturnError = shouldReturnError
    }
    
    
    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void)) {
        switch shouldReturnError {
        case true:
            completion(nil, NetworkError.failedFetchingData)
        case false:
            guard let data = try? JSONSerialization.data(withJSONObject: ProductDetailsResponse.jsonResponse , options: .fragmentsAllowed) else {
                completion(nil, NetworkError.failedFetchingData)
                return
            }
            if let decodedData: Product = convertFromJson(data: data){
                completion(decodedData.product , nil)
            }
            else {
               completion(nil, NetworkError.failedFetchingData)
            }
        }
    }
    
    func retriveCustomers(completion: @escaping (([Customer]?, Error?) -> Void)) {
        switch shouldReturnError {
        case true:
            completion(nil, NetworkError.failedFetchingData)
        case false:
            guard let data = try? JSONSerialization.data(withJSONObject: CustomersResponse.jsonResponse , options: .fragmentsAllowed) else {
                completion(nil, NetworkError.failedFetchingData)
                return
            }
            if let decodedData: AllCustomers = convertFromJson(data: data){
                completion(decodedData.customers, nil)
            }
            else {
               completion(nil, NetworkError.failedFetchingData)
            }
        }
    }
    
    
    func fetchProducts(completion: @escaping (([ProductModel]?, Error?) -> Void)) {
        switch shouldReturnError {
        case true:
            completion(nil, NetworkError.failedFetchingData)
        case false:
            guard let data = try? JSONSerialization.data(withJSONObject: ProductsResponse.jsonResponse, options: .fragmentsAllowed) else {
                completion(nil, NetworkError.failedFetchingData)
                return
            }
            if let decodedData: Products = convertFromJson(data: data){
                completion(decodedData.products, nil)
            }
            else{
                completion(nil, NetworkError.failedFetchingData)
            }
            
        }
    }

    
    
    enum NetworkError: Error {
        case failedFetchingData
    }
    
}
