//
//  RegisterNewCustomer_viewModel.swift
//  Megamart
//
//  Created by MAC on 04/07/2022.
//

import Foundation

class RegisterNewCustomer_viewModel: RegiserNewCustomer_protocol {
    
    
    var error: String? {
        didSet{
            binding(error)
        }
    }

    
    var binding: ((String?) -> Void) = {_ in }
    
    
    var apiService: APIService
    var firebaseManager: FirebaseServices
    
    
    init(apiService: APIService = NetworkManager(), firebaseManager: FirebaseServices = FirebaseManager()) {
        self.apiService = apiService
        self.firebaseManager = firebaseManager
    }
    
    
    func createNewCustomer(email: String, name: String, password: String, conformPassword: String) {
        
        if let error = check_emailAndUserName(userName: name, email: email) {
            self.error = error
        }
        else{
            let newCustomer = NewCustomer(customer: Customer(first_name: name, email: email, tags: password, id: nil, addresses: nil))
            registerCustomer_firebase(newCustomer: newCustomer)
        }
        
    }
    
    

    
//MARK: -                                   register new customer in Firebase
    
    
    func registerCustomer_firebase(newCustomer: NewCustomer) {
        
        guard let email = newCustomer.customer.email else { return }
        guard let password = newCustomer.customer.tags else { return }
        firebaseManager.register(email: email, password: password) { error in
            if let error = error {
                self.error = error.localizedDescription
            }
            else{
                self.registerCustomer_api(newCustomer: newCustomer)
            }
        }
    }
    
    
    
  //MARK: -                                   register new customer in API
      
      
      func registerCustomer_api(newCustomer: NewCustomer) {
          apiService.registerCustomer(newCustomer: newCustomer) { customer, error in
              if let error = error {
                  self.error = error.localizedDescription
              }
              else{
                  self.error = nil
              }

          }
          
      }
      
    
    
    func checkPassword(password:String, ConfirmPassword: String) -> Bool {
        return password == ConfirmPassword
    }
    
    
    func check_emailAndUserName(userName: String, email: String) -> String? {
        for customer in Constants.customers_list {
                if userName == customer.first_name {
                    return "User name is used before"
                }
                if email == customer.email {
                    return "Email is used before"
                }
            }
        return nil
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
