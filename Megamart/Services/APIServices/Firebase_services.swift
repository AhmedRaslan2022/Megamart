//
//  Firebase_services.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation


protocol FirebaseServices {
    
//MARK: -               Add to Favorites
    
    func addToFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void))
 
    
    //MARK: -               Fetch Favorites
        
    func fetchFavorites(completion: @escaping (([Int]?,[String]?,[String]?,Error?) -> Void))
    
    
    //MARK: -               Update Favorites
    
    
    func removeFromFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void))
    
    
//MARK: -                           Reset Password
    
    func resetPassword(userEmail: String, completion: @escaping ((Error?)-> Void))
    
    
}
