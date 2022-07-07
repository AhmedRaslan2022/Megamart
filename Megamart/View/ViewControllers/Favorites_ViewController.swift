//
//  Favorites_ViewController.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import UIKit

class Favorites_ViewController: UIViewController {

    @IBOutlet weak var favorites_collectionView: UICollectionView!
    
    var ids: [Int] = []
    var titles: [String] = []
    var images: [String] = []
    
    var favoritesModelView: Favorites_protocol = Favorites_modelView()
    var firebaseManager: FirebaseServices = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.favoritesModelView.fetchFavorites()
        self.favoritesModelView.binding = { products, error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "cancle", viewController: self)
            }
            if let products = products {
                if let ids = products["ids"] as? [Int] {
                    self.ids = ids
                }
                if let titles = products["titles"] as? [String] {
                    self.titles = titles
                }
                if let images = products["images"] as? [String] {
                    self.images = images
                }
                print("$$$$$$$$$$$ ids = \(self.ids)")
                print("$$$$$$$$$$$ titles = \(self.titles)")
                print("$$$$$$$$$$$ images = \(self.images)")
            }else{
                print("%%%%%%%%%%%%%%% products is nil ")
            }
            
        }
    }
    

}
