//
//  Settings_ViewModel.swift
//  Megamart
//
//  Created by MAC on 12/07/2022.
//

import Foundation

class Settings_ViewModel: SettingsProtocol {
    
    let firebaseManager: FirebaseServices
    let defaults = UserDefaults.standard
    
    var signout_error: Error? {
        didSet{
            binding(signout_error)
        }
    }
    
    var binding: ((Error?) -> Void) = { _ in }
    
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }
    
    func signout() {
        print("############### signout ")
        firebaseManager.signOut { error in
            if let error = error {
                self.signout_error = error
            }
            else{
                print("@@@@@@@@@@@@@@@@@@@@@@")
                self.defaults.set(nil, forKey: Userdefaults_key.customerId.rawValue)
                self.defaults.set(nil, forKey: Userdefaults_key.customerName.rawValue)
                self.signout_error = nil
            }
        }
    }

    
}
