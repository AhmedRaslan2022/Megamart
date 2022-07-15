//
//  PaymentOptionVC.swift
//  Megamart
//
//  Created by A on 11/04/1401 AP.
//

import UIKit
import PassKit

class PaymentOptionVC: UIViewController {

    var totalPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var paymentRequest: PKPaymentRequest = {
            let request = PKPaymentRequest()
            request.merchantIdentifier = "merchant.m.saad19962019@gmail.com"
            request.supportedNetworks = [.visa, .masterCard,.amex,.discover]
            request.supportedCountries = ["UA","EG"]
            request.merchantCapabilities = .capability3DS
            request.countryCode = "EG"
            request.currencyCode = "EGP"
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Megamart", amount: 10.99)]
            return request
        }()
    
    @IBAction func applePay(_ sender: UIButton) {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controller.delegate = self
            present(controller, animated: true)
            // show alert here
    }

}
    
    
    @IBAction func cashOnDelivery(_ sender: UIButton) {
        guard let totalPrice = self.totalPrice else { return }
        if totalPrice >= 2000 {
            addAlert(title: "Warning", message: "Can not pay this amount cash", ActionTitle: "OK", viewController: self)
        }
        else{
            orderPlacement()
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
}

}
