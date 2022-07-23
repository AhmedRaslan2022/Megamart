//
//  CustomersResponse.swift
//  MegamartTests
//
//  Created by MAC on 23/07/2022.
//

import Foundation


class CustomersResponse {
    static let jsonResponse: [String: Any?] = [
        "customers": [ CustomerResponse.jsonResponse ]
    ]
        
}


struct CustomerResponse {
    
    static let jsonResponse: [String: Any?] = [
    
        "customer": [
            "id": 6285607698646,
            "email": "test1122@gmail.com",
            "accepts_marketing": false,
            "created_at": "2022-07-23T12:52:30+02:00",
            "updated_at": "2022-07-23T12:54:16+02:00",
            "first_name": "Mohamed",
            "last_name": nil,
            "orders_count": 1,
            "state": "disabled",
            "total_spent": "170.00",
            "last_order_id": 4809258172630,
            "note": nil,
            "verified_email": true,
            "multipass_identifier": nil,
            "tax_exempt": false,
            "tags": "123123",
            "last_order_name": "#1264",
            "currency": "EGP",
            "phone": nil,
            "addresses": [
            [
            "id": 7780172103894,
            "customer_id": 6285607698646,
            "first_name": "Mohamed",
            "last_name": nil,
            "company": nil,
            "address1": "Street 1 Build 1",
            "address2": nil,
            "city": "New City",
            "province": "Cairo",
            "country": "Egypt",
            "zip": "",
            "phone": "01234543456",
            "name": "Mohamed",
            "province_code": "C",
            "country_code": "EG",
            "country_name": "Egypt",
            "default": true
            ]
            ],
            "accepts_marketing_updated_at": "2022-07-23T12:52:30+02:00",
            "marketing_opt_in_level": nil,
            "tax_exemptions": [],
            "email_marketing_consent": [
            "state": "not_subscribed",
            "opt_in_level": "single_opt_in",
            "consent_updated_at": nil
            ]
        ]
    ]
    
}
