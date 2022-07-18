//
//  OrderCollectionViewCell.swift
//  Megamart
//
//  Created by Macintosh on 18/07/2022.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
