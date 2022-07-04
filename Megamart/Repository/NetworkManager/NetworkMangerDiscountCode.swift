//
//  NetworkMangerDiscountCode.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//

import Foundation


import Alamofire

class NetworkMangerDiscountCode: APIServicesDiscountcode {
    func fetchDiscountCode(endPoint: String, completion: @escaping (([DiscountCodeElement]?, Error?) -> Void)) {
        if let url = URL(string: UrlServices.getDiscountCode(priceRuleID: endPoint)){
            print(url)
            Alamofire.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default)
                        .responseData { response in
               guard let data = response.data else { return }
                            if let decodedData: DiscountCode = convertFromJson(data: data){
                                completion(decodedData.discountCodes, nil)
                            } else { print("/////////////////Error in decode data")}
                            
            }

        }else{
            print("888888888888888888else")
        }
        
    }
    }
    
    
    
    
    
