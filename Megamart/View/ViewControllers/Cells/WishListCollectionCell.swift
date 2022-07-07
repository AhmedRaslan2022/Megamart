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
    
    @IBOutlet weak private var WishListImag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(imageUrl: String) {
        Alamofire.request(imageUrl).responseImage { response in
            if case .success(let image) = response.result {
                self.WishListImag.image = image
            }
        }
        
    }

}
