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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
}
