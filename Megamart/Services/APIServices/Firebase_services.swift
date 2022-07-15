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
        
        func login(email: String, password: String, completion: @escaping ((String?, String?, Error?) -> Void))
        
        
//MARK: -                          Register
            
        func register(email: String, password: String, completion: @escaping ((Error?) -> Void))
    

//MARK: -                           Sign Out

        func signOut(completion: @escaping ((Error?)-> Void))
    
    
    
    
    
//MARK: -                           Add to Favorites
    
    func addToFavorites(product: productEntity_firestore, completion: @escaping ((Error?) -> Void))
 
    
//MARK: -                      Fetch Favorites
        
    func fetchFavorites(completion: @escaping (([productEntity_firestore]?, Error?) -> Void))
    
    
//MARK: -                     Remove Product from Favorites
    
    
    func removeFromFavorites(productId: String, completion: @escaping ((Error?) -> Void))
    
    

    
    
}
