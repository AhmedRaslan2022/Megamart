//
//  Constatnts.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import Foundation
import SwiftUI




struct Constants {
    
//MARK: -                   Storyboards
    
    static let Main_storyboard  = "Main"
    static let Products_storyboard  = "Products"
    static let authentication_storyboard  = "Authentication"
    static let setting_storyboard  = "Setting"
    static let productDetails_storyboard  = "ProductDetails"
    static let Favorites_storyboard  = "Favorites"
    static let Orders_storyboard  = "Orders"
    static let bag_storyboard = "BagStoryboard"
    static let payment_storyboard = "payment"
    
    
//MARK: -                   viewControllers
    
    static let HomeViewController_id = "HomeVC_id"
    static let CategoryViewController_id = "CategoryViewController_id"
    static let login_viewController_id = "login_viewController_id"
    static let SignUp_viewController_id = "SignUp_ViewController_id"
    static let Setting_viewController_id = "SettingViewController_id"
    static let ProductDetails_ViewController_id = "ProductDetails_ViewController_id"
    static let BagViewController_id = "BagViewController_id"
    static let Favorites_ViewController_id = "Favorites_ViewController_id"
    static let Orders_ViewController_id = "Orders_ViewController_id"
    static let Payment_viewController_id = "PaymentVC_id"
    static let PaymentOption_viewController_id = "PaymentOptionVC_id"
    static let ProductsViewController_id = "Products_viewController_id"
    static let resetPassword_ViewController_id = "ResetPassword_ViewController_id"
    static let tabBar_ViewController_id = "tabViewControllerId"
    
    
    
//MARK: -                   Cells
    
    
    static let ProductDetails_cell_id = "ProductDetails_cell_id"
    static let ProductDetails_nib_name = "ProductDetails_CollectionViewCell"
    
    static let BagTableViewCell_id = "BagTableViewCell"
    static let ProductsViewCell_id = "Products_ViewCell_id"
    
    static let CategoryViewCell_id = "Category_ViewCell_id"
    static let Brands_Cell_id     = "Brands_Cell_id"
    
    static let Products_nib_name  = "ProductCollectionCell"
    static let Brands_nib_name    = "BrandsCollectionCell"
    
    static let WishList_nib_name  = "WishListCollectionCell"
    static let WishList_Cell_id   = "WishList_cell_id"
    
    static let favorite_nib_name  = "FavoritesCollectionViewCell"
    static let favorite_Cell_id   = "favoritesCell_id"
    

    

  
    
//MARK: -               Customers list
    
    static var customers_list : [Customer] = []
    
    
    
//MARK: -              CategoryId
    
    enum CategoryId: Int{
        case Men = 409147474134
        case Women = 409147506902
        case Kids = 409147539670
        case Sale = 409147605206
    }
    
    
//MARK: -              Product Type
        
    enum ProductType: String {
        case SHOES = "SHOES"
        case ACCESSORIES = "ACCESSORIES"
        case TSHIRTS = "T-SHIRTS"
    }
   
    
//MARK: -               others
            
    
    static let noImageAvailabel = "no_image_available-product"
    
    static let coupons_values = [0.1, 0.2 , 0.05 , 0.3 , 0.4, 0.15 ]
    
    
}





//MARK: -                       UserDefaults Keys

enum Userdefaults_key: String {
    case customerId = "customerId", customerName = "customerName", couponValue = "couponValue"
}
