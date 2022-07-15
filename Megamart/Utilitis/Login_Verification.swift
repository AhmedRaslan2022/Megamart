//
//  Login_Verification.swift
//  Megamart
//
//  Created by MAC on 16/07/2022.
//

import Foundation


func Login_Verification() -> Bool {
    
    let defaults = UserDefaults.standard
    if defaults.string(forKey: Userdefaults_key.customerId.rawValue) != nil {
        return true
    }
    else{
        return false
    }
    
}
