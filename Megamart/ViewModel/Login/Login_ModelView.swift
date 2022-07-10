//
//  Login_ModelView.swift
//  Megamart
//
//  Created by MAC on 05/07/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class Login_modelView: Login_protocol {
    
    
    var loggedin: String?{
        didSet{
            binding(true, nil)
        }
    }
    
    
    var error: String? {
        didSet{
            binding(false, error)
        }
    }
    

    
    var binding: ((Bool, String?) -> Void) = {_,_ in }
    
    var apiService: APIService
    
    init(apiService: APIService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func login(userName: String, password: String) {
        for customer in Constants.customers_list {
                if userName == customer.email {
                    if password == customer.tags {
                        binding(true, nil)
                        return
                    }else{
                        error = "Incorrect Password"
                    }
                } else{
                    error = "Incorrect Username"
                }
            }
    }
    
    
    func retriveAllCustomer() {
        apiService.retriveCustomers { customers, error in
            if error != nil {
                print("%%%%%%%%%%%% error in retrive customers ")
            }
            if let customers = customers {
                Constants.customers_list = customers
            }
        }
    }

    
}
