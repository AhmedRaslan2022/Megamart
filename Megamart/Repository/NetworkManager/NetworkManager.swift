//
//  NetworkManager.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import Foundation
import Alamofire


class NetworkManager: APIService,BrandsAPIService{
  
    
//MARK:                     product details
    

    func fetchProductInfo(endPoint: String, completion: @escaping ((ProductModel?, Error?) -> Void)) {
        if let url = URL(string: UrlServices.productDetails(product_id: endPoint)){
            Alamofire.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default)
                    .responseData { response in
                            if let error = response.error {
                                completion(nil, error)
                            }
               guard let data = response.data else { return }
                    if let decodedData: Product = convertFromJson(data: data){
                        completion(decodedData.product , nil)
                    } else {
                        print("Error in decode data")
                    }

            }
        }
    }
    
//MARK:                             create new customer
    

    func registerCustomer(newCustomer: NewCustomer, completion: @escaping ((NewCustomer?, Error?) -> Void)) {
        if let url = URL(string: UrlServices.registerCustomer() ) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpShouldHandleCookies = false

            do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            URLSession.shared.dataTask(with: request) { data, response, error in

                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                if let decodedData: NewCustomer = convertFromJson(data: data) {
                    completion(decodedData, nil)
                }
            }.resume()
    
        }
        
    }
    
    
    //MARK:                             Brands
    
    func  fetchBrands(completion: @escaping (([BrandsModel]?, Error?) -> Void)){
        if let url = URL(string: UrlServices.brands()){
            print(url)
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data {
                    guard let decodedData = try? JSONDecoder().decode(Brands.self, from: data) else{ return}
                    completion(decodedData.brands,nil)
                }
                if let error = error {
                   completion(nil, error)
                }
            }.resume()
        }
      
    }
                
                
            /*guard let data = response.data else { return }
                    print("before decode")
                    if let decodedData: Brands = convertFromJson(data: data){
                        completion(decodedData.brands, nil)
                    } else { print("!!!!!!Error in decode data!!!!!!")}
                    }
        }*/


}
    /* func fetchSports(endPoint: String, completion: @escaping (([Sport]?, Error?) -> Void)) {
     
     if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data = data {
                 guard let decodedData = try? JSONDecoder().decode(SportModel.self, from: data) else{ return}
                 completion(decodedData.sports,nil)
             }
             if let error = error {
                completion(nil, error)
             }
         }.resume()
     }
   
 }
}*/
    
    func fetchProducts(endPoint: String, completion: @escaping (([ProductModel]?, Error?) -> Void)) {
        if let url = URL(string: UrlServices.products()){
            Alamofire.request(url , method: .get, parameters: nil, encoding:JSONEncoding.default)
                        .responseData { response in
               guard let data = response.data else { return }
                            if let decodedData: Products = convertFromJson(data: data){
                                completion(decodedData.products, nil)
                            } else { print("*****************Error in decode data")}
            }
        }else{
            print("&&&&&&&&&&&&&&&&&&& else")
        }
        

    }
    




