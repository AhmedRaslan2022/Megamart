//
//  Firebase_services.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation


protocol FirebaseServices {
    
    
//MARK: -                           Reset Password
        
        func resetPassword(userEmail: String, completion: @escaping ((Error?)-> Void))
        
        
//MARK: -                           Log in
        
        func login(email: String, password: String, completion: @escaping ((String?, Error?) -> Void))
        
        
//MARK: -                          Register
            
        func register(email: String, password: String, completion: @escaping ((Error?) -> Void))
    

//MARK: -                           Sign Out

        func signOut(completion: @escaping ((Error?)-> Void))
    
    
    
    
    
//MARK: -                              Add to Favorites
    
    func addToFavorites(product: ProductEntity_firestore, completion: @escaping ((Error?) -> Void))
 
    
//MARK: -                            Fetch Favorites
        
    func fetchFavorites(completion: @escaping (([ProductEntity_firestore]?, Error?) -> Void))
    
    
//MARK: -                         Remove Product from Favorites
    
    
    func removeFromFavorites(productId: String, completion: @escaping ((Error?) -> Void))

    
//MARK: -                              Add to BagCard
    
    func addToBagCard(product: ProductBagCard_firestore, completion: @escaping ((Error?) -> Void))
 
    
//MARK: -                            Fetch BagCard
        
    func fetchBagCard(completion: @escaping (([ProductBagCard_firestore]?, Error?) -> Void))
    
    
//MARK: -                         Remove Product from Favorites
    
    
    func removeFromCart(productId: String, completion: @escaping ((Error?) -> Void))
    
//MARK: -                               Save Order
    
    func saveOrder(order: Order_Model, completion: @escaping ((Error?) -> Void))
    
//MARK: -                               Fetch Orders
    
    func fetchOrders(completion: @escaping (([Order_Model]?, Error?) -> Void))

}
