//
//  DiscountCode_Protocol.swift
//  Megamart
//
//  Created by A on 13/04/1401 AP.
//

import Foundation



protocol DiscountCode_Protocol {
    func fetchDataDiscountCode (endPoint: String)
    var  bindingData: (([DiscountCodeElement]?, Error?) -> Void ) {set get}
}

