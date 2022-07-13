//
//  Settings_protocol.swift
//  Megamart
//
//  Created by MAC on 12/07/2022.
//

import Foundation

protocol SettingsProtocol {
    
    func signout()
    var binding: ((Error?) -> Void) {get set}
    
}
