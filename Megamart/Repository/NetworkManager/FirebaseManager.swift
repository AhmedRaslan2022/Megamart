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
    
    
    var products_id:    [Int]   = []
    var products_title: [String] = []
    var products_image: [String] = []
    
    let defaults = UserDefaults.standard
    let database = Firestore.firestore()
    
    

//MARK: -                                       Log In
    
    
    func login(email: String, password: String, completion: @escaping ((String?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                completion(nil, error)
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
    
    
    
    
    
    
//MARK: -                                       Add Product to Favorites
    
    
    func addToFavorites(product: ProductEntity_firestore, completion: @escaping ((Error?) -> Void)) {

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
    
    
    
//MARK: -                                       Remove Product From Favorites
    
    
    func removeFromFavorites(productId: String, completion: @escaping ((Error?) -> Void)) {

        if let uid = Auth.auth().currentUser?.uid {
            
            // delete subcollections
            database.collection(uid).document(productId).updateData([
                "id": FieldValue.delete(),
                "title": FieldValue.delete(),
                "image": FieldValue.delete()
            ]) { error in
                
                if let error = error {
                    completion(error)
                
                } else {
                    
                    // delete document
                    self.database.collection(uid).document(productId).delete() { err in
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
    
    
    
    func fetchFavorites(completion: @escaping (([ProductEntity_firestore]?, Error?) -> Void)) {
        
        var products: [ProductEntity_firestore] = []
        
        if let uid = Auth.auth().currentUser?.uid {
            database.collection(uid).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    for document in querySnapshot!.documents {
                        let doc = try? document.data(as: ProductEntity_firestore.self)
                        if let doc = doc {
                            products.append(doc)
                        }

                    }
                    completion(products, nil)
                }
            }
            
        
        }
    }
    
   
    func addToBagCard(product: ProductBagCard_firestore, completion: @escaping ((Error?) -> Void)) {
        
        if let email = Auth.auth().currentUser?.email {
            do{
                try database.collection(email).document(String(product.id)).setData(from: product)
                completion(nil)
            }
            catch let error {
                completion(error)
            }
            
        }
    }
    
    func fetchBagCard(completion: @escaping (([ProductBagCard_firestore]?, Error?) -> Void)) {
        
        var products: [ProductBagCard_firestore] = []
        
        if let email = Auth.auth().currentUser?.email {
            database.collection(email).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                   
                } else {
                    for document in querySnapshot!.documents {
                        let doc = try? document.data(as: ProductBagCard_firestore.self)
                        if let doc = doc {
                            products.append(doc)
                            
                        }

                    }
                    completion(products, nil)
                }
            }
            
        
        }
    
    }
    
    func removeFromCart(productId: String, completion: @escaping ((Error?) -> Void)) {
        if let email = Auth.auth().currentUser?.email {
            
            // delete subcollections
            database.collection(email).document(productId).updateData([
                "id": FieldValue.delete(),
                "title": FieldValue.delete(),
                "image": FieldValue.delete(),
                "price": FieldValue.delete(),
                "inventory_quantity": FieldValue.delete(),
            ]) { error in
                
                if let error = error {
                    completion(error)
                
                } else {
                    
                    // delete document
                    self.database.collection(email).document(productId).delete() { err in
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
    
    
    
    //MARK: -                                   Save Order
    
    func saveOrder(order: Order_Model, completion: @escaping ((Error?) -> Void)) {
        
        if let email = Auth.auth().currentUser?.email {
            do{
                try database.collection(email).document(order.id).setData(from: order)
                completion(nil)
            }
            catch let error {
                completion(error)
            }
            
        }
    }
    
    
//MARK: -                                   Fetch Orders
    func fetchOrders(completion: @escaping (([Order_Model]?, Error?) -> Void)) {
        
        var orders: [Order_Model] = []
        print("@@@@@@@@@@")
        
        if let email = Auth.auth().currentUser?.email {
            print("&&&&&&&&&&&&&&&&&")
            database.collection(email).getDocuments() { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                   
                } else {
                    print("************************")
                    for document in querySnapshot!.documents {
                        print("!!!!!!!!!!!!\(document)")
                        let doc = try? document.data(as: Order_Model.self)
                        if let doc = doc {
                            orders.append(doc)
                            
                        }

                    }
                    completion(orders, nil)
                    print("!!!!!!!!!!!!\(orders)")
                }
            }
        
        }
    
}
}
