//
//  BrandCollectionViewCell.swift
//  Megamart
//
//  Created by Macintosh on 05/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage


class BrandsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func setCell(imageUrl: String) {
        AF.request(imageUrl).responseImage { response in
            if case .success(let image) = response.result {
                self.brandImage.image = image
            }
        }
        
    }

}
