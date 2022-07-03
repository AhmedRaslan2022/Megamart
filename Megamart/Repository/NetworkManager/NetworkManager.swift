//
//  NetworkManager.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation
import Alamofire

class NetworkManager: APIService {
    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void)) {
        if let url = URL(string: UrlServices.productDetails(product_id: endPoint)){
            print(url)
            Alamofire.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default)
                        .responseData { response in
               guard let data = response.data else { return }
                    if let decodedData: Product = convertFromJson(data: data){
                        completion(decodedData.product , nil)
                    } else {
                        print("Error in decode data")
                    }

            }
            

        }
        

    }
    
}
