//
//  Login_protocol.swift
//  Megamart
//
//  Created by MAC on 05/07/2022.
//

import Foundation

protocol Login_protocol {
    func login(userName: String, password: String)
    func retriveAllCustomer() 
    var binding: ((Bool, String?) -> Void) {get set}
    
}
