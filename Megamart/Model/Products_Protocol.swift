//
//  Products_Protocol.swift
//  Megamart
//
//  Created by Macintosh on 04/07/2022.
//

import Foundation
protocol Products_Protocol {
    func fetchData (endPoint: String)
    var  bindingData: (([ProductModel]?, Error?) -> Void ) {set get}
}
