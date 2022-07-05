//
//  Brands_Protocol.swift
//  Megamart
//
//  Created by Macintosh on 04/07/2022.
//

import Foundation
protocol Brands_Protocol {
    func fetchData ()
    var  bindingData: (([BrandsModel]?, Error?) -> Void ) {set get}
}
