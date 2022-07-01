//
//  BagTableViewCell.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit

class BagTableViewCell: UITableViewCell {
    @IBOutlet weak var bagImage: UIImageView!
    
    @IBOutlet weak var uiMinus: UIButton!
    @IBOutlet weak var uiPlus: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
