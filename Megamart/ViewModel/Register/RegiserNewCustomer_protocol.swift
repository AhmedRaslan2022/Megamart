//
//  RegiserNewCustomer_protocol.swift
//  Megamart
//
//  Created by MAC on 04/07/2022.
//


import Foundation

protocol RegiserNewCustomer_protocol {
    func createNewCustomer(email:String, name:String, password:String, conformPassword:String)
    func checkPassword(password:String, ConfirmPassword:String) -> Bool
    var binding: ((String?) -> Void) { get set }
}

