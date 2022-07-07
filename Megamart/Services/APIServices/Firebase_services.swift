//
//  Firebase_services.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation


protocol FirebaseServices {
    
//MARK: -               Update Favorites
    
    func updateFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void))
 
    
    //MARK: -               Update Favorites
        
    func fetchFavorites(completion: @escaping (([Int]?,[String]?,[String]?,Error?) -> Void))
}
