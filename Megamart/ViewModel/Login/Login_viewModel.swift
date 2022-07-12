//
//  Login_viewModel.swift
//  Megamart
//
//  Created by MAC on 05/07/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class Login_viewModel: Login_protocol {
    
    let defaults = UserDefaults.standard
    
    var error: String? {
        didSet{
            binding(error)
        }
    }
    
    var binding: ((String?) -> Void) = {_ in }
    
    
    init(apiService: APIService = NetworkManager(), firebaseManager: FirebaseServices = FirebaseManager()) {
        self.apiService = apiService
        self.firebseManager = firebaseManager
    }
    
    
    func login(userName: String, password: String) {
        login_firebase(email: userName, password: password)
    }
    
    
    
//MARK: -                                           Login Firebase

    let firebseManager: FirebaseServices
    
    func login_firebase(email: String, password: String) {
        self.firebseManager.login(email: email, password: password) { customerID, error  in
            if let error = error {
                self.error = error.localizedDescription
            }
            if let customerID = customerID {
                self.login_api(userName: email, password: password, customerId: customerID)
            }
        }
    }
    
    
    
//MARK: -                                             Login  API
    
        
    var apiService: APIService
    
    
    func login_api(userName: String, password: String, customerId: String) {
        for customer in Constants.customers_list {
                if userName == customer.email {
                    if password == customer.tags {
                        self.defaults.set(customerId, forKey: "customerId")
                        error = nil
                        return
                    }else{
                        error = "Incorrect Password"
                        return
                    }
                }
            }
        error = "Incorrect Username"
    }
    
    
    func retriveAllCustomer() {
        apiService.retriveCustomers { customers, error in
            if error != nil {
                print("error in retrive customers")
            }
            if let customers = customers {
                Constants.customers_list = customers
            }
        }
    }

    
    
}
