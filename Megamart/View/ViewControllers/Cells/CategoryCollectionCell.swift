//
//  CategoryCollectionCell.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBAction func FavouriteButton(_ sender: UIButton) {
    }
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductImag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
