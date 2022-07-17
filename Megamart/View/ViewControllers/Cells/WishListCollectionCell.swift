//
//  WishListCollectionCell.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage

class WishListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var WishListLabel: UILabel!
    @IBOutlet weak private var WishListImag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(product: ProductEntity_firestore) {
        Alamofire.request(product.image).responseImage { response in
            if case .success(let image) = response.result {
                self.WishListImag.image = image
            }
        }
        
     
        self.WishListLabel.text = product.title
    }

}
