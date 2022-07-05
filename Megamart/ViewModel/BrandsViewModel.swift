//
//  Brands.swift
//  Megamart
//
//  Created by Macintosh on 04/07/2022.
//

import Foundation
class BrandsViewModel: Brands_Protocol {
    
    var brandsArray: [BrandsModel]? {
        didSet{
            bindingData(brandsArray, nil)
        }
    }
    
    var error: Error? {
        didSet{
            bindingData(nil, error)
        }
    }
    
    var bindingData: (([BrandsModel]?, Error?) -> Void) = {_, _ in }
    var brandsApiService: BrandsAPIService
    
    init(brandsApiService: BrandsAPIService = NetworkManager()) {
        self.brandsApiService = brandsApiService
    }
    
    
    func fetchData() {
        brandsApiService.fetchBrands() { brands, error in
            if let brands = brands {
                self.brandsArray = brands
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
   
    
    
    
 
    
}
