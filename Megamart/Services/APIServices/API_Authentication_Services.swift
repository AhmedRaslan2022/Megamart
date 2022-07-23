//
//  API_Authentication_Services.swift
//  Megamart
//
//  Created by MAC on 23/07/2022.
//

import Foundation




//MARK: -                           Retrive Customers For LogIn

protocol RetriveCustomersProtocol_API {
    func retriveCustomers(completion: @escaping (([Customer]?, Error?) -> Void))
}





//MARK: -                           register new customer

protocol RegisterProtocol_API: RetriveCustomersProtocol_API {
        
    func registerCustomer(newCustomer: NewCustomer, completion: @escaping ((NewCustomer?, Error?) -> Void))
}




//MARK: -                               Reset Password

protocol RestPasswordProtocol_API {
    func restPassword(customer: NewCustomer, completion: @escaping ((Error?) -> Void))
}




