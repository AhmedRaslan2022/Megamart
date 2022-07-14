//
//  Favorites_ViewController.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import UIKit

class Favorites_ViewController: UIViewController {

    @IBOutlet weak var favorites_collectionView: UICollectionView!
    
    
    var products: [productEntity_firestore] = []
    
    var favoritesViewModel: Favorites_protocol = Favorites_viewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favorites_collectionView.delegate = self
        favorites_collectionView.dataSource = self
        

        self.favorites_collectionView.register(UINib(nibName: Constants.favorite_nib_name , bundle: nil), forCellWithReuseIdentifier: Constants.favorite_Cell_id)
           
        responseOf_fetchingFavorites()
        responseOf_deleteProductFromFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritesViewModel.fetchFavorites()
    }


}

//MARK: -                                   delete Product From Favorites


extension Favorites_ViewController: DeleteProductFromFavorites_protocol {
    
    func deleteProductFromFavorites(productId: String) {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to remove this product from your favourites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.favoritesViewModel.removeFromFavorites(productId: productId)
            
            for index in 0..<self.products.count {
                if self.products[index].id == productId {
                    self.products.remove(at: index)
                    break
                }
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}



//MARK: -                                   The response of fetching favorites


extension Favorites_ViewController {
    
    func responseOf_fetchingFavorites() {
        
        self.favoritesViewModel.binding = { favorites, error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            if let favorites = favorites {
                self.products = favorites
                if self.products.count == 0 {
                addAlert(title: "Alert!", message: "There are no favorite Products", ActionTitle: "Cancel", viewController: self)
                }
                self.favorites_collectionView.reloadData()
            }
            
        }
    }
    
    
//MARK: -                           The response of Delete product from Favorites
    
    
    func responseOf_deleteProductFromFavorites() {
        
        self.favoritesViewModel.removeFromFavorites_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription , ActionTitle: "Cancel", viewController: self)
            }
            else{
                DispatchQueue.main.async {
                    self.favorites_collectionView.reloadData()
                }
                addAlert(title: "Done", message: "Product removed from favorites", ActionTitle: "OK", viewController: self)
            }
        }
    }
}




//MARK: -                                       Collection View


extension Favorites_ViewController: UICollectionViewDelegate{
    
}

extension Favorites_ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.favorite_Cell_id, for: indexPath) as? FavoritesCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.setCell(product: products[indexPath.row])

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.productDetails_storyboard, bundle:nil)
        let productDetailsViewController = storyBoard.instantiateViewController(withIdentifier: Constants.ProductDetails_ViewController_id) as! ProductDetails_ViewController
        productDetailsViewController.productID = products[indexPath.row].id
        productDetailsViewController.rootViewController = self
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    
    }

    
    
}


extension Favorites_ViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 , height: collectionView.bounds.height / 2)
    }

}
