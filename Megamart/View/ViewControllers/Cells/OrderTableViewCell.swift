//
//  OrderTableViewCell.swift
//  Megamart
//
//  Created by Macintosh on 13/07/2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var CreatedAtLabel: UILabel!
    @IBOutlet weak var priceLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
