//
//  FavoritesCollectionViewCell.swift
//  Megamart
//
//  Created by MAC on 12/07/2022.
//

import UIKit
import Alamofire
import AlamofireImage

protocol DeleteProductFromFavorites_protocol {
    func deleteProductFromFavorites (productId: String)
}


class FavoritesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var productTitle: UILabel!
    @IBOutlet weak var updateFavorites: UIButton!
    
    var delegate: DeleteProductFromFavorites_protocol?
    var productId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(product: ProductEntity_firestore) {
        AF.request(product.image).responseImage { response in
            if case .success(let image) = response.result {
                self.productImage.image = image
            }
        }
        
        self.productTitle.text = product.title
        self.productId = product.id
    }
    
    
    @IBAction func updateFavorites(_ sender: Any) {
        print("*(((((((((((((((((((((((")
        if let productId = productId {
            print("*(((((((((((((((((((((((&&&&&&&&&&&&&&&&&&&&")
            self.delegate?.deleteProductFromFavorites(productId: productId)
        }
    }
    
}
