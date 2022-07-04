//
//  DiscountCode_ModelView.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//

import Foundation


class DiscountCode_ModelView: DiscountCode_Protocol {
    
    
    
    
    var discountArr: [DiscountCodeElement]? {
        didSet{
            bindingData(discountArr, nil)
        }
    }
    
    var error: Error? {
        didSet{
            bindingData(nil, error)
        }
    }
    
    var bindingData: (([DiscountCodeElement]?, Error?) -> Void) = {_, _ in }
    
    var apiService: APIServicesDiscountcode
    
    init(apiService: APIServicesDiscountcode = NetworkMangerDiscountCode()) {
        self.apiService = apiService
    }
    
    func fetchDataDiscountCode(endPoint: String) {
        apiService.fetchDiscountCode(endPoint: endPoint) { DiscountCode, error in
            if let DiscountCode = DiscountCode {
                //print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\(product)")
                self.discountArr = DiscountCode
            }
            if let error = error {
                print("%%%%%%%%%%%%%%%%%%%%5 \(error)")
                self.error = error
            }
        }
    }
    
}
