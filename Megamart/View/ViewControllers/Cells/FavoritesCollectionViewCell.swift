//
//  FavoritesCollectionViewCell.swift
//  Megamart
//
//  Created by MAC on 12/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage


class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var productTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(imageUrl: String, title: String) {
        Alamofire.request(imageUrl).responseImage { response in
            if case .success(let image) = response.result {
                self.productImage.image = image
            }
        }
        
        self.productTitle.text = title
        
    }
    
}
