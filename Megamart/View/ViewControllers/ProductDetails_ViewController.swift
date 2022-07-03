//
//  ProductDetails_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit

class ProductDetails_ViewController: UIViewController {

    @IBOutlet weak var numberOfProducts_label: UILabel!
    @IBOutlet weak var products_collectionview: UICollectionView!
    @IBOutlet weak var productTitle_label: UILabel!
    @IBOutlet weak var description_textView: UITextView!
    @IBOutlet weak var reviews_textview: UITextView!
    @IBOutlet weak var availableSizes_label: UILabel!
    @IBOutlet weak var productRating_label: UILabel!
    @IBOutlet weak var productPrice_label: UILabel!
    @IBOutlet weak var imageController: UIPageControl!
    @IBOutlet weak var incrementProducts_button: UIButton!
    @IBOutlet weak var decrementProducts_button: UIButton!
    @IBOutlet weak var addToShopingBag_button: UIButton!
    @IBOutlet weak var addToFavorites_button: UIButton!
    
    
    var images_url: [Image]?
    var productID: String? = "7730623709398"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products_collectionview.delegate = self
        products_collectionview.dataSource = self
        
        self.products_collectionview.register(UINib(nibName: Constants.ProductDetails_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.ProductDetails_cell_id)

        
        
        var productDetails_viewModel: ProductDetails_Protocol = ProductDetails_modelView()
        if let productID = productID {
            productDetails_viewModel.fetchData(endPoint: productID)
        }

        productDetails_viewModel.bindingData = { productDetails, error in
            if let productDetails = productDetails {
                self.productTitle_label.text = productDetails.title
                self.productPrice_label.text = productDetails.variants[0].price
                self.description_textView.text = productDetails.body_html
                DispatchQueue.main.async {
                    self.images_url = productDetails.images
                    self.imageController.numberOfPages = productDetails.images.count
                    self.products_collectionview.reloadData()
                }
                
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
        
        func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                super.viewWillTransition(to: size, with: coordinator)
            products_collectionview.reloadData()
        }
        
    }
    

    @IBAction func AddToCart(_ sender: UIButton) {
    }
    
    @IBAction func reduceProductNumber_button(_ sender: UIButton) {
    }
    
    @IBAction func increaseProductNumber_button(_ sender: UIButton) {
    }
    
    @IBAction func goBack_button(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func goToHome_button(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func goToFavorites_button(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func goToShopingBag_button(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        if addToFavorites_button.currentBackgroundImage == UIImage(systemName: "heart.fill"){
            self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            self.addToFavorites_button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
    }
    
    
}


//MARK: -                   Collection View


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
