//
//  ProductViewCell.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductViewCell: UICollectionViewCell {
    
    private var product: ProductModel?
    var productDetails_viewModel: ProductDetails_Protocol = ProductDetails_viewModel()
    

    @IBOutlet weak var FavouriteProduct: UIButton!
    @IBAction func FavouriteProduct(_ sender: UIButton) {
        
        
        
        
    }
    
    
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!

func setCell(imageUrl: String) {
    AF.request(imageUrl).responseImage { response in
        if case .success(let image) = response.result {
            self.ProductImage.image = image
        }
    }
    
}

}
