//
//  APIServicesDiscountcode.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//

import Foundation

protocol APIServicesDiscountcode {
    
 func fetchDiscountCode(endPoint: String, completion: @escaping (([DiscountCodeElement]?, Error?) -> Void ) )
}
