//
//  ProductDetails_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit
import Cosmos

class ProductDetails_ViewController: UIViewController {

    @IBOutlet weak var numberOfProducts_label: UILabel!
    @IBOutlet weak var products_collectionview: UICollectionView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var productTitle_label: UILabel!
    @IBOutlet weak var availableSizes_label: UILabel!
    @IBOutlet weak var productRating_label: UILabel!
    @IBOutlet weak var productPrice_label: UILabel!
    @IBOutlet weak var imageController: UIPageControl!
    @IBOutlet weak var incrementProducts_button: UIButton!
    @IBOutlet weak var decrementProducts_button: UIButton!
    @IBOutlet weak var addToShopingBag_button: UIButton!
    @IBOutlet weak var addToFavorites_button: UIButton!
    @IBOutlet weak var description_label: UILabel!
    
    
    
    private var images_url: [Image]?
    var productID: String?
    private var product: ProductModel?
    
    var rating = Double.random(in: 1...5)
    
    var productDetails_viewModel: ProductDetails_Protocol = ProductDetails_viewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products_collectionview.delegate = self
        products_collectionview.dataSource = self
        self.products_collectionview.register(UINib(nibName: Constants.ProductDetails_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.ProductDetails_cell_id)
    
        if let productID = productID {
            productDetails_viewModel.fetchData(endPoint: productID)
        }
        
        responseOf_updateFavorites()
        responseOf_fetchProducts()
        
    }

        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
        products_collectionview.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
      
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
   
//MARK: -                                    Buttons Action

    
    @IBAction func AddToCart(_ sender: UIButton) {
    }
    
    @IBAction func reduceProductNumber_button(_ sender: UIButton) {
    }
    
    @IBAction func increaseProductNumber_button(_ sender: UIButton) {
    }
    
    @IBAction func goBack_button(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToHome_button(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: Constants.HomeViewController_id) as! HomeVC
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @IBAction func goToFavorites_button(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Favorites_storyboard, bundle:nil)
        let favoritesViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as! Favorites_ViewController
        self.navigationController?.pushViewController(favoritesViewController, animated: true)
    }
    
    @IBAction func goToShopingBag_button(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.bag_storyboard, bundle:nil)
        let bagViewController = storyBoard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as! BagViewController
        self.navigationController?.pushViewController(bagViewController, animated: true)
//        bagViewController.modalPresentationStyle = .fullScreen
//        self.present(bagViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        
        if addToFavorites_button.currentBackgroundImage == UIImage(systemName: "heart.fill"){
            self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            
            if let product = product {
                print("%%%%%%%%%%%%%%%%% here re %%%%%%%%%%%%%%%%%%%%%%%%%")
                productDetails_viewModel.removeFromFavorites(product: product)
            }
            
            
        }else{
            self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("%%%%%%%%%%%%%%%%% here %%%%%%%%%%%%%%%%%%%%%%%%%")
            if let product = product {
                productDetails_viewModel.addToFavorites(product: product)
            }
        }
        
    }
  
    
}



//MARK: -                                         Collection View


extension ProductDetails_ViewController: UICollectionViewDelegate{
    
}

extension ProductDetails_ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images_url?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.imageController.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ProductDetails_cell_id, for: indexPath) as! ProductDetails_CollectionViewCell
        
        if let image = images_url?[indexPath.row].src {
            cell.setCell(imageUrl: image)
        }
        
        if images_url?.count == 0 {
            cell.setCell(imageUrl: Constants.noImageAvailabel)
        }

        return cell
    }

    
}


extension ProductDetails_ViewController: UICollectionViewDelegateFlowLayout{
    // to set only one cell in row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.height)
    }

    
    
}



//MARK: -                                   Response of fetchProducts and update Favorites


extension ProductDetails_ViewController {
    
    func responseOf_updateFavorites () {
        self.productDetails_viewModel.addToFavorites_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription, ActionTitle: "Cancel", viewController: self)
                print("%%%%%%%%%%%% error")
            }
            else{
                print("%%%%%%%%%%%% else")
                addAlert(title: "Done", message: "The product has been saved to favourites", ActionTitle: "OK", viewController: self)
            }
                    
        }
        
        self.productDetails_viewModel.removeFromFavorites_status = { error in
            if let error = error {
                addAlert(title: "Warning", message: error.localizedDescription, ActionTitle: "Cancel", viewController: self)
            }
            else{
                addAlert(title: "Done", message: "Product removed from favourites", ActionTitle: "OK", viewController: self)
            }
                    
        }
    }
    
    
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

                self.images_url = productDetails.images
                self.imageController.numberOfPages = productDetails.images.count
                self.products_collectionview.reloadData()

                
                if let sizes = productDetails.options?[0].values {
                    for size in sizes {
                        self.availableSizes_label.text! += size
                        self.availableSizes_label.text! += " "
                    }
                }
 
            }
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
}
