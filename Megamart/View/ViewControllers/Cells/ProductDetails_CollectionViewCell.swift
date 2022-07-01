//
//  ProductDetails_CollectionViewCell.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit

class ProductDetails_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var product_imageView: UIImageView!
    @IBOutlet weak private var addToFavorites_button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addToFavorites_button(_ sender: UIButton) {
        addToFavorites_button.imageView?.image = UIImage(systemName: "heart.fill")
    }
}
