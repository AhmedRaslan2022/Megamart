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
        
        favorites_collectionView.delegate = self
        favorites_collectionView.dataSource = self

        self.favorites_collectionView.register(UINib(nibName: Constants.WishList_nib_name , bundle: nil), forCellWithReuseIdentifier: Constants.WishList_Cell_id)
        
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
                
                self.favorites_collectionView.reloadData()
                print("$$$$$$$$$$$ ids = \(self.ids)")
                print("$$$$$$$$$$$ titles = \(self.titles)")
                print("$$$$$$$$$$$ images = \(self.images)")
            }else{
                print("%%%%%%%%%%%%%%% products is nil ")
            }
            
        }
    }
    

}


//MARK: -                                       Collection View


extension Favorites_ViewController: UICollectionViewDelegate{
    
}

extension Favorites_ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("&&&&&&&&&&&&&&&&& \(ids.count)")
        return ids.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.WishList_Cell_id, for: indexPath) as! WishListCollectionCell
        cell.setCell(imageUrl: images[indexPath.row])
        return cell
    }

    
}


extension Favorites_ViewController: UICollectionViewDelegateFlowLayout{
    // to set only one cell in row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 , height: collectionView.frame.size.height/2)
    }

    
    
}
