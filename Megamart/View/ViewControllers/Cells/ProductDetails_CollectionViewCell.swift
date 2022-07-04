//
//  ProductDetails_CollectionViewCell.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage


class ProductDetails_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var product_imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(imageUrl: String) {
        Alamofire.request(imageUrl).responseImage { response in
            if case .success(let image) = response.result {
                self.product_imageView.image = image
            }
        }
        
    }

}
