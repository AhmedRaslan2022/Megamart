//
//  OrderViewModel.swift
//  Megamart
//
//  Created by Macintosh on 16/07/2022.
//

import Foundation

class OrderViewModel : Order_Protocol{


    var orders: [Order_Model] = [] {
        didSet{
            binding(orders,nil)
        }
    }
    
    var error: Error? {
        didSet{
            binding(nil, error)
        }
    }
    
    var binding: (([Order_Model]?, Error?) -> Void) = {_,_ in }
    
    var firebaseManager: FirebaseServices
    
    init(firebaseManager: FirebaseServices = FirebaseManager()) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchOrders() {
        print ("InsideOrders")
        firebaseManager.fetchOrders { orders, error in
            if let error = error {
                self.error = error
                print ("OrdersError")
            }
               if let orders = orders {
                self.orders = orders
                   print ("OrdersSuccess")
            }
        }
    }
}

