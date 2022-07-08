//
//  SetPassword_protocol.swift
//  Megamart
//
//  Created by MAC on 08/07/2022.
//

import Foundation

protocol SetPasswordProtocol {
    
    func resetPassword_api (userEmail: String, newPassword: String)
    var binding_api: ((Error?) -> Void) { get set }
    
}
