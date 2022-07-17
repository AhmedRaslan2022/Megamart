//
//  PaymentViewController.swift
//  Megamart
//
//  Created by A on 11/04/1401 AP.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var shoppingFees: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var coupon: UILabel!
    
    var order: Order_Model?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let order = order {
            self.totalPrice.text = order.totalPrice
            self.coupon.text = "\(defaults.double(forKey: Userdefaults_key.couponValue.rawValue))"
            self.discount.text = "\(calculateDiscountValue())"
            self.shoppingFees.text = "0.0"
            self.grandTotal.text = "\(calculateGrandPrice())"
        }

    }
    
    

    @IBAction func paymentOption(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.payment_storyboard, bundle:nil)
        let paymentOpetionViewController = storyBoard.instantiateViewController(withIdentifier: Constants.PaymentOption_viewController_id) as! PaymentOptionVC
        guard let order = order else { return }
        paymentOpetionViewController.order = order
        self.navigationController?.pushViewController(paymentOpetionViewController, animated: true)
    }
    
    
    func calculateDiscountValue() -> Double {
        var discountValue: Double = 0.0
        guard let order = order else { return 0.0 }
        if let totalPrice = Double(order.totalPrice) {
             discountValue = defaults.double(forKey: Userdefaults_key.couponValue.rawValue) * totalPrice
        }
        return discountValue
    }
    
    func calculateGrandPrice() -> Double {
        var grandPrice: Double = 0.0
        guard let order = order else { return 0.0 }
        if let totalPrice = Double(order.totalPrice) {
            grandPrice = totalPrice - calculateDiscountValue()
        }
        return grandPrice
    }
    
}
