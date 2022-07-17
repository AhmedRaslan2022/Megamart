//
//  PaymentOptionVC.swift
//  Megamart
//
//  Created by A on 11/04/1401 AP.
//

import UIKit
import PassKit

class PaymentOptionVC: UIViewController {

    var order: Order_Model?
    var paymentOptionViewModel: PaymentOption_Protocol = PaymentOption_ViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        responseOf_removeProductsFromCart()
        responseOf_saveOrder()
        
    }
    
    private var paymentRequest: PKPaymentRequest = {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.m.saad19962019@gmail.com"
            request.supportedNetworks = [.visa, .masterCard,.amex,.discover]
            request.supportedCountries = ["EG"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "EG"
            request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Megamart", amount: 100.0 )]
            return request
        }()
    
    @IBAction func applePay(_ sender: UIButton) {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true)
            
    }

}
    
    
    @IBAction func cashOnDelivery(_ sender: UIButton) {
        guard let totalPrice: Double = order?.totalPrice else { return }
        if totalPrice >= 2000 {
            addAlert(title: "Warning", message: "Can not pay this amount cash", ActionTitle: "OK", viewController: self)
        }
        else{
            removeProductsFromCart()
        }
    }
    
    
    func orderPlacement() {
        
        let alert = UIAlertController(title: "Done", message: "Order Saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: Constants.tabBar_ViewController_id) as! UITabBarController
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: false, completion: nil)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

extension PaymentOptionVC: PKPaymentAuthorizationViewControllerDelegate {

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        removeProductsFromCart()
    }

}

//MARK: -                                       Remove Products From Cart

extension PaymentOptionVC {
    
    func removeProductsFromCart() {
        guard let order = order else { return }
        self.paymentOptionViewModel.removeFromBagCard(products: order.products)
    }
    
    func responseOf_removeProductsFromCart() {
        self.paymentOptionViewModel.removeProductsFromCart_status = { error in
            if let error = error {
                print("******************* Error in Remove Products From Cart \(error.localizedDescription)")
            }else{
                self.saveOrder()
            }
        }
    }
    
}


//MARK: -                                       Save Order

extension PaymentOptionVC {
    
    func saveOrder() {
        guard var order = order else { return }
        self.paymentOptionViewModel.saveOrder(order: &order)
    }
    
    func responseOf_saveOrder() {
        self.paymentOptionViewModel.saveOrder_status = { error in
            if let error = error {
                print("******************* Error in Save Order \(error.localizedDescription) ")
            }else{
                self.orderPlacement()
            }
        }
    }
    
}
