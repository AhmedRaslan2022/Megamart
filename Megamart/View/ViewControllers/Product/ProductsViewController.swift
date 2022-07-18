//
//  ProductsViewController.swift
//  Megamart
//
//  Created by Macintosh on 01/07/2022.
//

import UIKit


class ProductsViewController: UIViewController {
    


    @IBOutlet weak var priceSlide: UISlider!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ProductCollection: UICollectionView!

    
    var brandTitle = String ()
    var adjustedPrice: Float = 200.0
    var productsArray = [ProductModel]()
    var sortedProductsArray = [ProductModel]()
    var sortedArrayByPrice = [ProductModel]()
    var maxPrice: Float = 0.0
    
    var searchedProduct: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PriceLabel.text = String(adjustedPrice)
        priceSlide.isHidden = true
        PriceLabel.isHidden = true
        ProductCollection.delegate = self
        ProductCollection.dataSource = self
        
        self.SearchBar.delegate = self
        
      self.ProductCollection.register(UINib(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.ProductsViewCell_id)
        
           let productsViewModel = ProductsViewModel()
             productsViewModel.fetchData()
        
        productsViewModel.bindingData = { products, error in
                 if let products = products {
                     self.productsArray = products
                     for product in self.productsArray {
                         if product.vendor == self.brandTitle   {
                             self.sortedProductsArray.append(product)
                             if Float(product.variants[0].price)! > self.maxPrice{
                                 self.maxPrice = Float(product.variants[0].price)!
                             }
                           }
                       }
                     self.priceSlide.maximumValue =  self.maxPrice
                     
                     self.sortedArrayByPrice = self.sortedProductsArray
                     DispatchQueue.main.async {
                    self.ProductCollection.reloadData()
                }
        
             }
       }
        
      
    }
    @IBAction func filter(_ sender: UIBarButtonItem) {
        priceSlide.isHidden = false
        PriceLabel.isHidden = false
    }
    
    
    
    @IBAction func priceSlider(_ sender: UISlider) {
        adjustedPrice = sender.value
        PriceLabel.text = String(adjustedPrice)
        sortedArrayByPrice = []
        for product in self.sortedProductsArray {
            if  Float(product.variants[0].price)! <= self.adjustedPrice {
                self.sortedArrayByPrice.append(product)
              }
          }
        DispatchQueue.main.async {
       self.ProductCollection.reloadData()
   }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.SearchBar.endEditing(true)
    }
   
  
   
}

extension ProductsViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return sortedArrayByPrice.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     
        
        let cell = ProductCollection.dequeueReusableCell(withReuseIdentifier: Constants.ProductsViewCell_id, for: indexPath) as! ProductViewCell
            cell.ProductPrice.text = sortedArrayByPrice[indexPath.row].variants[0].price
           let image = sortedArrayByPrice[indexPath.row].image.src
           cell.setCell(imageUrl: image)
        return cell
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
         CGSize(width: ProductCollection.bounds.width, height: ProductCollection.bounds.height)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.productDetails_storyboard,bundle: nil)
        if let productVC = storyboard.instantiateViewController(withIdentifier:Constants.ProductDetails_ViewController_id) as? ProductDetails_ViewController{
            productVC.productID = String(sortedArrayByPrice[indexPath.row].id)
            self.navigationController?.pushViewController(productVC, animated: true)
            
        }

    }
    
    
}



//MARK: -                                       SEARCH BAR


extension ProductsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            sortedArrayByPrice = productsArray.filter({$0.title.contains(searchText)})
            self.ProductCollection.reloadData()
        }else{
            self.ProductCollection.reloadData()
        }
        
        if searchBar.text?.count == 0 {
            self.sortedArrayByPrice = productsArray
            self.ProductCollection.reloadData()
            searchBar.resignFirstResponder()
        }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}


