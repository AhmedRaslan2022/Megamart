//
//  OrderTableViewCell.swift
//  Megamart
//
//  Created by Macintosh on 13/07/2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLbel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
