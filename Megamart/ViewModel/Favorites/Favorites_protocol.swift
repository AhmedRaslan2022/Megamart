//
//  Favorites_protocol.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation

protocol Favorites_protocol {
    func fetchFavorites()
    var  binding: (([String: Any]?, Error?) -> Void) { get set }
}
