//
//  RegisterNewCustomer_ModelView.swift
//  Megamart
//
//  Created by MAC on 04/07/2022.
//

import Foundation

class RegisterNewCustomer_ViewModel: RegiserNewCustomer_protocol {
    
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var customer: NewCustomer? {
        didSet{
            binding(customer, nil)
        }
    }
    
    var binding: ((NewCustomer?, Error?) -> Void) = {_,_ in }
    
    var apiService: APIService
    
    init(apiService: APIService = NetworkManager()) {
        self.apiService = apiService
    }
    
    
    func createNewCustomer(email: String, name: String, password: String, conformPassword: String) {
        
        let newCustomer = NewCustomer(customer: Customer(first_name: name, email: email, tags: password, id: nil, addresses: nil))
        registerCustomer(newCustomer: newCustomer)
    }
    
    
    func registerCustomer(newCustomer: NewCustomer) {
        apiService.registerCustomer(newCustomer: newCustomer) { customer, error in
            if let error = error {
                self.error = error
            }
            if let customer = customer {
                self.customer = customer
            }
        }
        
    }
    
    
    func checkPassword(password:String, ConformPassword:String) -> Bool {
        return password == ConformPassword
    }
    
    
}
