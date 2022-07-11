//
//  CategoryViewController.swift
//  Megamart
//
//  Created by Macintosh on 10/07/2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    

    
    @IBOutlet weak var productsCollection: UICollectionView!
    
    var menArray = [Int]()
    var womenArray = [Int]()
    var kidsArray = [Int]()
    var saleArray = [Int]()
    var productsArray = [ProductModel]()
    var viewedArray = [ProductModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollection.delegate = self
        productsCollection.dataSource = self
        
        self.productsCollection.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.CategoryViewCell_id)
        
        
//MARK: -                 Fetch Products
        
        let productsViewModel = ProductsViewModel()
          productsViewModel.fetchData()
     
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.productsArray = products
                  self.viewedArray = self.productsArray
                  DispatchQueue.main.async {
   
                 self.productsCollection.reloadData()
             }
        
    }
}
        
        
//MARK: -                   Fetch Collects
        
        let collectsViewModel = CollectsViewModel()
            collectsViewModel.fetchData()
            collectsViewModel.bindingData = { collects, error in
                 if let collects = collects {
                    for   index in 0..<collects.count {
                     switch collects[index].collectionID{
                     case Constants.CategoryId.Men.rawValue :
                         self.menArray.append(collects[index].productID)
                     case Constants.CategoryId.Women.rawValue :
                         self.womenArray.append(collects[index].productID)
                     case Constants.CategoryId.Kids.rawValue :
                         self.kidsArray.append(collects[index].productID)
                     case Constants.CategoryId.Sale.rawValue :
                         self.saleArray.append(collects[index].productID)
                     default:
                         print("******Error in filitring*******")
                     }

         }
       }
   }
}
    
 //MARK: -                   Categories Buttons
    @IBAction func WomenButton(_ sender: UIBarButtonItem) {
        
        let productsViewModel = ProductsViewModel()
          productsViewModel.fetchData()
        
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.viewedArray.removeAll()
                  for  index in 0..<products.count    {
                      for i in 0..<self.womenArray.count {
                      if self.womenArray[i] == products[index].id{
                          self.viewedArray.append(products[index])
                       }
                     }
                  }
                  DispatchQueue.main.async {
                 self.productsCollection.reloadData()
             }
        
          }
     }
        
}
    
    @IBAction func Men(_ sender: Any) {
        
        let productsViewModel = ProductsViewModel()
          productsViewModel.fetchData()
        
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.viewedArray.removeAll()
                  for  index in 0..<products.count    {
                      for i in 0..<self.menArray.count {
                      if self.menArray[i] == products[index].id{
                          self.viewedArray.append(products[index])
                       }
                     }
                  }
                  DispatchQueue.main.async {
                 self.productsCollection.reloadData()
             }
        
          }
    }
}
    
    @IBAction func saleButton(_ sender: UIBarButtonItem) {
        let productsViewModel = ProductsViewModel()
          productsViewModel.fetchData()
        
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.viewedArray.removeAll()
                  for  index in 0..<products.count    {
                      for i in 0..<self.saleArray.count {
                      if self.saleArray[i] == products[index].id{
                          self.viewedArray.append(products[index])
                       }
                     }
                  }
                  DispatchQueue.main.async {
                 self.productsCollection.reloadData()
             }
        
          }
    }
}
    
    
    @IBAction func kidsButton(_ sender: Any) {
        let productsViewModel = ProductsViewModel()
          productsViewModel.fetchData()
        
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.viewedArray.removeAll()
                  for  index in 0..<products.count    {
                      for i in 0..<self.kidsArray.count {
                      if self.kidsArray[i] == products[index].id{
                          self.viewedArray.append(products[index])
                       }
                     }
                  }
                  DispatchQueue.main.async {
                 self.productsCollection.reloadData()
               }
        
            }
        }
    }
    
//MARK: -                    Navigation Bar Buttons
    @IBAction func goFav(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.Favorites_storyboard,bundle: nil)
        if let favouriteVC = storyboard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as? Favorites_ViewController{
            self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
    }
    
    @IBAction func goCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.bag_storyboard,bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as? BagViewController{
            self.navigationController?.pushViewController(cartVC, animated: true)
      }
    
   }
       
}


//MARK: -                    CollectionView Layout

 extension CategoryViewController: UICollectionViewDataSource,UICollectionViewDelegate {


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            return viewedArray.count
        }


        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
         
            
            let cell = productsCollection.dequeueReusableCell(withReuseIdentifier: Constants.CategoryViewCell_id, for: indexPath) as! CategoryCollectionCell
            cell.productPrice.text = viewedArray[indexPath.row].variants[0].price
               let image = viewedArray[indexPath.row].image.src
               cell.setCell(imageUrl: image)
            return cell
        }



        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
             CGSize(width: productsCollection.bounds.width, height: productsCollection.bounds.height)
        }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: Constants.productDetails_storyboard,bundle: nil)
         if let productVC = storyboard.instantiateViewController(withIdentifier:Constants.ProductDetails_ViewController_id) as? ProductDetails_ViewController{
             productVC.productID = String(viewedArray[indexPath.row].id)
             self.navigationController?.pushViewController(productVC, animated: true)
       }
    }
  
}
