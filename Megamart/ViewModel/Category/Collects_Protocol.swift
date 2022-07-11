//
//  Collects_Protocol.swift
//  Megamart
//
//  Created by Macintosh on 11/07/2022.
//

import Foundation
protocol Collects_Protocol {
    func fetchData ()
    var  bindingData: (([Collect]?, Error?) -> Void ) {set get}
}
