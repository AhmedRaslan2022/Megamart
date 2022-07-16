//
//  BagTableViewCell.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit
import Alamofire
import AlamofireImage

protocol DeleteProductFromBagCard_protocol {
    func deleteProductFromBagCard (productId: String)
}

class BagTableViewCell: UITableViewCell {
    @IBOutlet weak var bagImage: UIImageView!
    
    @IBOutlet weak var uiMinus: UIButton!
    @IBOutlet weak var uiPlus: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var delegate: DeleteProductFromBagCard_protocol?
    var productId: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func setCellBagCard(product: ProductBagCard_firestore) {
        Alamofire.request(product.image).responseImage { response in
            if case .success(let image) = response.result {
                self.bagImage.image = image
            }
        }
        
        self.title.text = product.title
        self.price.text = product.price
        self.productId = product.id
    }

    @IBAction func minusAction(_ sender: Any) {
    }
    
    
    @IBAction func plusAction(_ sender: Any) {
    }
}
