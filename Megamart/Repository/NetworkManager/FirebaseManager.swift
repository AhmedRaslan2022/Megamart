//
//  FirebaseManager.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation
import Firebase


class FirebaseManager: FirebaseServices {
    
    
    var products_id: [Int] = []
    var products_title: [String] = []
    var products_image: [String] = []
    
    let defaults = UserDefaults.standard
    

//MARK: -                                       Login
    
    
    func login(email: String, password: String, completion: @escaping ((String?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                completion(nil,error)
            }
            else{
                completion(authResult?.user.uid, nil)
            }
        }
    }
    
   
//MARK: -                                   Register new customer
    
    
    func register(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    
 
    //MARK: -                               Reset Password
        
       
    func resetPassword(userEmail: String, completion: @escaping ((Error?)-> Void)) {
        
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: userEmail) { error in
            if let error = error{
                completion(error)
            }
            else{
                completion(nil)
            }
        }
        
    }

    
    
//MARK: -                                        Sign Out


    func signOut(completion: @escaping ((Error?)-> Void)) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }
    
    
    
    
    
    
//MARK: -                               Update Favorites
    
    
    func addToFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void)) {

        if isNotFavorites(product: product) {
            print(isNotFavorites(product: product))
            products_id.append(product.id)
            products_title.append(product.title)
            products_image.append(product.image.src)
            
            let ref = Database.database().reference()
//            let id: String? = "5Vu3ThuLqEXT1OZ3QTNIV1JWZdn2"
            if let uid = Auth.auth().currentUser?.uid {
//            if let uid = id {
                ref.child("Users").child(uid).setValue(["ids":products_id,
                                                      "titles": products_title,
                                                      "images": products_image]) { error, response in
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
    
//MARK: -                                       Remove Product
    
    func removeFromFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void)) {

        if (isNotFavorites(product: product)) {
            let products_id = products_id.filter { $0 !=  product.id }
            let products_title = products_title.filter { $0 !=  product.title }
            let products_image = products_image.filter { $0 !=  product.image.src }
            let ref = Database.database().reference()
//            let id: String? = "5Vu3ThuLqEXT1OZ3QTNIV1JWZdn2"
            if let uid = Auth.auth().currentUser?.uid {
//            if let uid = id {
                ref.child("Users").child(uid).setValue(["ids":products_id,
                                                        "titles": products_title,
                                                        "images": products_image]) { error, response in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(error)
                    }
                    else{
                        completion(nil)
                    }
                }
            }
        }
    }
    
    
    
//MARK: -                                   Fetch Favorites
    
    
    func fetchFavorites(completion: @escaping (([Int]?, [String]?, [String]?, Error?) -> Void)) {
        let ref = Database.database().reference()
//        let id: String? = "5Vu3ThuLqEXT1OZ3QTNIV1JWZdn2"
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("Users").child(uid).observe(.value) { snapshot in
                if let favorites = snapshot.value as? [String: Any] {
                    let ids = favorites["ids"] as? [Int]
                    let titles = favorites["titles"] as? [String]
                    let images = favorites["images"] as? [String]
                    completion(ids, titles, images, nil)
                }
            } withCancel: { error in
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
                self.products_id = ids
                for id in self.products_id {
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

