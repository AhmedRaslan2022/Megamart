//
//  CategoryCollectionCell.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage


class CategoryCollectionCell: UICollectionViewCell {
    
    @IBAction func favouriteButton(_ sender: UIButton) {
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(imageUrl: String) {
        Alamofire.request(imageUrl).responseImage { response in
            if case .success(let image) = response.result {
                self.productImag.image = image
            }
        }
        
    }

}
