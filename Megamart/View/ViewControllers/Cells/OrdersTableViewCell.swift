//
//  OrdersTableViewCell.swift
//  Megamart
//
//  Created by MAC on 21/07/2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    
    @IBOutlet weak private var date: UILabel!
    @IBOutlet weak private var price: UILabel!
    @IBOutlet weak private var address: UILabel!
    @IBOutlet weak private var phoneNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(date: String, price: Double, address: Order_Address){
        self.date.text = date
        self.price.text = "\(price)"
        self.address.text = "\(address.street) - \(address.city) - \(address.country)"
        self.phoneNumber.text = address.phoneNumber
    }
    
    
}
