//
//  Order_Protocol.swift
//  Megamart
//
//  Created by Macintosh on 16/07/2022.
//

import Foundation
protocol Order_Protocol {
    
    func fetchOrders()
    var  binding: (([Order_Model]?, Error?) -> Void) { get set }
 
}
