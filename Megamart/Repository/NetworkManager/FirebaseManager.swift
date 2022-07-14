//
//  FirebaseManager.swift
//  Megamart
//
//  Created by MAC on 06/07/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class FirebaseManager: FirebaseServices {
    
    
    var products_id: [Int] = []
    var products_title: [String] = []
    var products_image: [String] = []
    
    let defaults = UserDefaults.standard
    let database = Firestore.firestore()
    

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
    
    
    func addToFavorites(product: productEntity_firestore, completion: @escaping ((Error?) -> Void)) {

            if let uid = Auth.auth().currentUser?.uid {
                do{
                    try database.collection(uid).document(String(product.id)).setData(from: product)
                    completion(nil)
                }
                catch let error {
                    completion(error)
                }
                
            }
        
    }
    
    
    
//MARK: -                                       Remove Product
    
    
    func removeFromFavorites(product: ProductModel, completion: @escaping ((Error?) -> Void)) {

        if let uid = Auth.auth().currentUser?.uid {
            
            // delete subcollections
            database.collection(uid).document(String(product.id)).updateData([
                "id": FieldValue.delete(),
                "title": FieldValue.delete(),
                "image": FieldValue.delete()
            ]) { error in
                
                if let error = error {
                    completion(error)
                
                } else {
                    
                    // delete document
                    self.database.collection(uid).document(String(product.id)).delete() { err in
                            if let error = error {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        }
                    }

                }
            }
        
        
    }
    
    
    
//MARK: -                                   Fetch Favorites
    
    
    
    func fetchFavorites(completion: @escaping (([productEntity_firestore]?, Error?) -> Void)) {
        
        var products: [productEntity_firestore] = []
        
        if let uid = Auth.auth().currentUser?.uid {
            database.collection(uid).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let doc = try? document.data(as: productEntity_firestore.self)
                        if let id = doc?.id {
                            print("^^^^^^^^^^ \(id)")
                        }
                        if let doc = doc {
                            products.append(doc)
                            print("$$$$$$$$ \(doc)")
                            print(" products \(products)")
                        }

                    }
                    completion(products, nil)
                    print("%%%%%%%%%%% products \(products)")
                }
            }
            
        
        }
    }
    
    
    
    
}
