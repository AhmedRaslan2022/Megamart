//
//  FirebaseManager.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation
import Firebase


class FirebaseManager: FirebaseServices {
    
    var ids: [Int] = []
    var titles: [String] = []
    var images: [String] = []
    

//MARK: -                               Update Favorites
    
    
    func updateFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void)) {

        if isNotFavorites(product: product) {
            print(isNotFavorites(product: product))
            ids.append(product.id)
            titles.append(product.title)
            images.append(product.image.src)
            
            let ref = Database.database().reference()
            let id: String? = "5Vu3ThuLqEXT1OZ3QTNIV1JWZdn2"
    //        if let uid = Auth.auth().currentUser?.uid {
            if let uid = id {
                ref.child("Users").child(uid).setValue(["ids":ids,
                                                        "titles": titles,
                                                        "images": images]) { error, response in
                    if let error = error {
                        print("$$$$$$$$$$$$$$$$$$$$$$\(error.localizedDescription)")
                        completion(error)
                    }
                    else{
                        completion(nil)
                    }
                    print("^^^^^^^^^^^^^^^^^^^ \(response)")
                }
            }
        }else{
            print("%%%%%%%%%%%%%%%% added before ")
        }
    }
    
    
//MARK: -                                   Fetch Favorites
    
    
    func fetchFavorites(completion: @escaping (([Int]?, [String]?, [String]?, Error?) -> Void)) {
        let ref = Database.database().reference()
        let id: String? = "5Vu3ThuLqEXT1OZ3QTNIV1JWZdn2"
        if let uid = id {
            ref.child("Users").child(uid).observe(.value) { snapshot in
                if let favorites = snapshot.value as? [String: Any] {
                    let ids = favorites["ids"] as? [Int]
                    let titles = favorites["titles"] as? [String]
                    let images = favorites["images"] as? [String]
                    completion(ids, titles, images, nil)
                }
            } withCancel: { error in
                print("%%%%%%%%%%%%%%%%%% \(error.localizedDescription)")
                completion(nil, nil, nil, error)
            }

        }
        
    }
    
    
//MARK: -                         check is favorites or not
    
    
    func isNotFavorites(product: ProductModel) -> Bool {
        var check = true
        fetchFavorites { ids, _, _, error in
            if let error = error {
                print("$$$$$$$$$$$$$$ \(error.localizedDescription)")
            }
            if let ids = ids {
                self.ids = ids
                for id in self.ids {
                    print("************* \(id)")
                    print("##########333 \(product.id)")
                    if product.id == id {
                        check = false
                        print("%%%%%%%%%% $%%%%%%%%%%%%% \(check)5%%%%%%%%%%%%%%%% 5%%%%%%%%%%%%%%%%")
                        return
                    }
                }
            }
        }
        
        return check
    }
    
    
}

