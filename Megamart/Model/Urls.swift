//
//  Urls.swift
//  Megamart
//
//  Created by MAC on 03/07/2022.
//

import Foundation

struct UrlServices {
    
    private static let baseURL =
    "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/"

    static func productDetails(product_id: String) -> String{
        return UrlServices.baseURL + "admin/api/2022-01/products/\(product_id).json"
    }
    
    static func products() -> String{
        return UrlServices.baseURL + "admin/api/2022-01/products.json"
    }
    
    static func registerCustomer() -> String{
        return UrlServices.baseURL + "admin/api/2022-01/customers.json"

    }
    
    static func getDiscountCode(priceRuleID: String) -> String{
        return UrlServices.baseURL + "admin/api/2022-01/price_rules/\(priceRuleID)/discount_codes.json"
    }

    static func brands() -> String{
        return UrlServices.baseURL + "admin/api/2022-01/smart_collections.json"
    }
    
    static func retrievesCustomers() -> String {
        return UrlServices.baseURL + "admin/api/2022-01/customers.json"
    }
    
    static func resetPassword(customerId: String) -> String {
        return UrlServices.baseURL + "admin/api/2022-01/customers/\(customerId).json"
    }
    
    static func collects() -> String {
        return UrlServices.baseURL + "admin/api/2022-01/collects.json"
    }
}

