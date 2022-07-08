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
    
    @IBAction func FavouriteProduct(_ sender: UIButton) {
    }
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!

func setCell(imageUrl: String) {
    Alamofire.request(imageUrl).responseImage { response in
        if case .success(let image) = response.result {
            self.ProductImage.image = image
        }
    }
    
}

}
