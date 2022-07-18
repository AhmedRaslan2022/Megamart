//
//  ProductDetails_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit
import Cosmos


class ProductDetails_ViewController: UIViewController {

    @IBOutlet weak var products_collectionview: UICollectionView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var productTitle_label: UILabel!
    @IBOutlet weak var productRating_label: UILabel!
    @IBOutlet weak var productPrice_label: UILabel!
    @IBOutlet weak var imageController: UIPageControl!
    @IBOutlet weak var addToShopingBag_button: UIButton!
    @IBOutlet weak var addToFavorites_button: UIButton!
    @IBOutlet weak var description_label: UILabel!
    @IBOutlet weak var availabelSizes: UIStackView!
    
    
    
    var rootViewController: UIViewController?
    var productID: String?
    private var product: ProductModel?
    var rating = Double.random(in: 1...5)
    var isRotate = false
    
    var productDetails_viewModel: ProductDetails_Protocol = ProductDetails_viewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products_collectionview.delegate = self
        products_collectionview.dataSource = self
        self.products_collectionview.register(UINib(nibName: Constants.ProductDetails_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.ProductDetails_cell_id)
    
        if rootViewController != nil {
            self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        if let productID = productID {
            productDetails_viewModel.fetchData(endPoint: productID)
        }
        
        responseOf_updateFavorites()
        responseOf_fetchProducts()
        responseOf_addToCart()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
      
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()

      guard let flowLayout = products_collectionview.collectionViewLayout as? UICollectionViewFlowLayout else {
        return
      }
        if UIApplication.shared.statusBarOrientation.isLandscape {
            self.isRotate = true
        } else {
            self.isRotate = false
      }

      flowLayout.invalidateLayout()
    }
    
    
    
   
//MARK: -                                    Buttons Action

    
    @IBAction func AddToCart(_ sender: UIButton) {
        if Login_Verification(){
            guard let product = product else { return }
                self.productDetails_viewModel.addToCart(product: product)
        }
        else{
            requestLogin_alert(viewController: self)
        }
        
    }
    
    @IBAction func goBack_button(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToHome_button(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: Constants.HomeViewController_id) as! HomeVC
        homeViewController.modalPresentationStyle = .fullScreen
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    @IBAction func goToFavorites_button(_ sender: UIBarButtonItem) {
        
        if Login_Verification() {
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Favorites_storyboard, bundle:nil)
            let favoritesViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as! Favorites_ViewController
            self.navigationController?.pushViewController(favoritesViewController, animated: true)
        }
        else{
            requestLogin_alert(viewController: self)
        }
        
    }
    
    @IBAction func goToShopingBag_button(_ sender: UIBarButtonItem) {
        if Login_Verification(){
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.bag_storyboard, bundle:nil)
            let bagViewController = storyBoard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as! BagViewController
            self.navigationController?.pushViewController(bagViewController, animated: true)
        }
        else{
            requestLogin_alert(viewController: self)
        }
        
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
        if Login_Verification() {
            if addToFavorites_button.currentBackgroundImage == UIImage(systemName: "heart.fill"){
                self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                
                if let product = product {
                    productDetails_viewModel.removeFromFavorites(productId: product.id)
                }

            }else{
                self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                if let product = product {
                    productDetails_viewModel.addToFavorites(product: product)
                }
            }
        
        }
        else{
            requestLogin_alert(viewController: self)
        }
        
    }
  
    
}


//MARK: -                                   Response of Add To Cart

extension ProductDetails_ViewController {
 
    func responseOf_addToCart() {
        self.productDetails_viewModel.addToCart_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription, ActionTitle: "Cancel", viewController: self)
            }
            else{
                addAlert(title: "Done", message: "The product has been Added to Cart", ActionTitle: "OK", viewController: self)
            }
                    
        }
    }
    
}




//MARK: -                                   Response of Update Favorites


extension ProductDetails_ViewController {
    
    func responseOf_updateFavorites () {
        self.productDetails_viewModel.addToFavorites_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription, ActionTitle: "Cancel", viewController: self)
            }
            else{
                addAlert(title: "Done", message: "The product has been saved to favourites", ActionTitle: "OK", viewController: self)
            }
                    
        }
        
        self.productDetails_viewModel.removeFromFavorites_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription, ActionTitle: "Cancel", viewController: self)
            }
            else{
                addAlert(title: "Done", message: "Product removed from favorites", ActionTitle: "OK", viewController: self)
            }
                    
        }
    }
  
}


//MARK: -                                   Response of Fetch Products


extension ProductDetails_ViewController {
    
    func responseOf_fetchProducts() {
        
        productDetails_viewModel.bindingData = { productDetails, error in
            if let productDetails = productDetails {
                self.product = productDetails
                self.productTitle_label.text = productDetails.title
                self.productPrice_label.text = productDetails.variants[0].price
                self.description_label.text = productDetails.body_html
                
                self.starRating.settings.fillMode = .precise
                let rate = self.rating
                self.productRating_label.text = String(format: "%.1f", rate)
                self.starRating.rating = rate

                self.imageController.numberOfPages = productDetails.images.count
                self.products_collectionview.reloadData()

                
                if let sizes = productDetails.options?[0].values {
                    for size in sizes {
                        let label = UILabel()
                        label.text = size
                        label.backgroundColor = .yellow
                        label.textAlignment = .center
                        label.font = UIFont.boldSystemFont(ofSize: 18)
                        self.availabelSizes.addArrangedSubview(label)
                    }
                }
 
            }
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }

}




//MARK: -                                         Collection View


extension ProductDetails_ViewController: UICollectionViewDelegate{
    
}

extension ProductDetails_ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.imageController.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ProductDetails_cell_id, for: indexPath) as! ProductDetails_CollectionViewCell
        
        if let image = product?.images[indexPath.row].src {
            cell.setCell(imageUrl: image)
        }
        
        if product?.images.count == 0 {
            cell.setCell(imageUrl: Constants.noImageAvailabel)
        }

        return cell
    }

    
}


extension ProductDetails_ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  self.isRotate {
            return CGSize(width: collectionView.bounds.width , height: collectionView.bounds.height)
        }
        else{
            return CGSize(width: collectionView.bounds.height , height: collectionView.bounds.width)
        }
        
    }

}

