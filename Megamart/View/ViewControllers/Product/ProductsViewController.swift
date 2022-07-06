//
//  ProductsViewController.swift
//  Megamart
//
//  Created by Macintosh on 01/07/2022.
//

import UIKit


class ProductsViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PriceSlider: UISlider!
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var ProductCollection: UICollectionView!
    
    
    var brandTitle = String ()
    var productsArray = [ProductModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductCollection.delegate = self
        ProductCollection.dataSource = self
        
     /*   self.ProductCollection.register(UINib(nibName: Constants.Products_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.ProductDetails_cell_id)
        
           let productsViewModel = ProductsViewModel()
             productsViewModel.fetchData(endPoint:"")
        
             productsViewModel.bindingData = { products, error in
                 if let products = products {
                     self.productsArray = products
                DispatchQueue.main.async {
                    self.ProductCollection.reloadData()
                }
        
}
}*/
    }
}

extension ProductsViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ProductCollection.dequeueReusableCell(withReuseIdentifier: Constants.ProductsViewCell_id, for: indexPath) as! ProductViewCell
          
        cell.ProductPrice.text = productsArray[indexPath.row].variants[indexPath.row].price
        let data = productsArray[indexPath.row].image.src
       // cell.ProductImage.sd_setImage(with: URL(string: data), placeholderImage: UIImage(named: "Product.jpg"))
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return productsArray.count
    }
    
  

    
}





/*extension ProductsViewController: UICollectionViewDelegateFlowLayout{
    // to set only one cell in row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ProductCollection.bounds.width , height: ProductCollection.bounds.height)
    }

    
    
}*/

