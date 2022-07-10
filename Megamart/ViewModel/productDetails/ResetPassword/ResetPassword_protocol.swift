//
//  ResetPassword_protocol.swift
//  Megamart
//
//  Created by MAC on 10/07/2022.
//

import Foundation

protocol ResetPassword_protocol {
    func restPassword_firebase(userEmail: String)
    var bindingData_firebase: ((Error?) -> Void) {get set}
    
    func restPassword_api(userEmail: String, newPassword: String)
    var bindingData_api: ((Error?) -> Void) {get set}
    
    func checkPassword(password:String, ConformPassword:String) -> Bool
    
}
