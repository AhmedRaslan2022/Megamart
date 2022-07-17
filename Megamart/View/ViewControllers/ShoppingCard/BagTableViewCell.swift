//
//  BagTableViewCell.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit
import Alamofire
import AlamofireImage

protocol UpdateProductCount_protocol {
    func updateProductCount(count: Int, index: Int)
}

class BagTableViewCell: UITableViewCell {
    @IBOutlet weak var bagImage: UIImageView!
    
    @IBOutlet weak var uiMinus: UIButton!
    @IBOutlet weak var uiPlus: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var delegate: UpdateProductCount_protocol?
    var productIndex: Int?
    var product: ProductBagCard_firestore?
    var productCount: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func setCellBagCard(product: ProductBagCard_firestore, productIndex: Int) {
        Alamofire.request(product.image).responseImage { response in
            if case .success(let image) = response.result {
                self.bagImage.image = image
            }
        }
        
        self.title.text = product.title
        self.price.text = String(product.price)
        self.productCount = product.count
        self.product = product
        self.productIndex = productIndex
        
        updateCount()
        
    }

    @IBAction func minusAction(_ sender: Any) {
        if productCount > 1 {
            self.productCount -= 1
            updateCount()
        }
    }
    
    
    @IBAction func plusAction(_ sender: Any) {
        guard let product = product else { return }
        if productCount < 5 || productCount < product.avaliableAmount {
            self.productCount += 1
            updateCount()
        }
    }
    
    
    
    func updateCount() {
        DispatchQueue.main.async {
            self.minusButton_status()
            self.plusButton_status()
            self.count.text = "\(self.productCount)"
        }
        
        guard let productIndex = productIndex else { return }
        self.delegate?.updateProductCount(count: self.productCount, index: productIndex)
        
    }
    
//MARK: -                                   Button Status
    
    func minusButton_status(){
        if self.productCount == 1 {
            self.uiMinus.isEnabled = false
        }else{
            self.uiMinus.isEnabled = true
        }
    }
    
    
    func plusButton_status() {
        guard let product = product else { return }
        if productCount == 5 || productCount == product.avaliableAmount {
            self.uiPlus.isEnabled = false
        }
        else {
            self.uiPlus.isEnabled = true
            
        }
    }
}
