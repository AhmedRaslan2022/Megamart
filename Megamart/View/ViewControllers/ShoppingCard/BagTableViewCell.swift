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


protocol DecreaseIncrease_protocol {
    func cartIncrease (productIndex: Int?)
    func cartDecrease (productIndex: Int?)
}


class BagTableViewCell: UITableViewCell {
    @IBOutlet weak var bagImage: UIImageView!
    
    @IBOutlet weak var uiMinus: UIButton!
    @IBOutlet weak var uiPlus: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var delegate: DecreaseIncrease_protocol?
    var counter: Int = 1
    var productId: String?
    var productBag : ProductModel?
    var bagCardViewModel: BagCard_protocol = BagCard_viewModel()
    var productIndex: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

    
    
    func setCellBagCard(product: ProductBagCard_firestore,productIndex: Int) {
        self.productIndex = productIndex
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
        if counter == 1 {
            counter = 1
            self.count.text = "\(counter)"
        }
        else{
            counter -= 1
            self.count.text = "\(counter)"
            self.delegate?.cartDecrease (productIndex: productIndex)
        }
    }
    
    
    
    @IBAction func plusAction(_ sender: Any) {
        if counter == 5 {
            counter = 5
            self.count.text = "\(counter)"
        }
        else{
            counter += 1
            self.count.text = "\(counter)"
            self.delegate?.cartIncrease (productIndex: productIndex)
        }
        
    }
}
