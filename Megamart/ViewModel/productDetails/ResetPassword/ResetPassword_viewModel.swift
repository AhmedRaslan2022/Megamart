//
//  ResetPassword_protocol.swift
//  Megamart
//
//  Created by MAC on 10/07/2022.
//

import Foundation

class ResetPassword_viewModel: ResetPassword_protocol {
    
    
    init(firebaseManager: FirebaseServices = FirebaseManager(), apiService: APIService = NetworkManager()) {
        self.firebaseManager = firebaseManager
        self.apiService = apiService
    }
    
    
    
//MARK: -                               Firebase
    
    var error_firebase: Error? {
        didSet{
            bindingData_firebase(error_firebase)
        }
    }
    
    var bindingData_firebase: ((Error?) -> Void) = {_ in }
    
    let firebaseManager: FirebaseServices
    
    
    func restPassword_firebase(userEmail: String) {
        self.firebaseManager.resetPassword(userEmail: userEmail) { error in
            if let error = error {
                self.error_firebase = error
            }
            else{
                self.error_firebase = nil
            }
        }
    }
    
    
    
//MARK: -                               API
    
    var error_api: Error? {
        didSet{
            bindingData_api(error_api)
        }
    }
    
    var bindingData_api: ((Error?) -> Void) = {_ in }
    
    let apiService: APIService

    
    func restPassword_api(userEmail: String, newPassword: String) {
        if let customer = getCustomer(email: userEmail) {
            
            let updatedCustomer = NewCustomer(customer: Customer(first_name: customer.first_name!, email: customer.email!, tags: newPassword, id: customer.id!, addresses: customer.addresses, lastName: customer.lastName))
            
            self.apiService.restPassword(customer: updatedCustomer) { error in
                if let error = error {
                    self.error_api = error
                }else{
                    self.error_api = nil
                }
            }

        }
    }
    
    
    func checkPassword(password:String, ConformPassword:String) -> Bool {
        return password == ConformPassword
    }
    
    func getCustomer(email: String) -> Customer? {
        for customer in Constants.customers_list {
                if email == customer.email {
                    return customer
                }
            }
        return nil
    }
    
}
