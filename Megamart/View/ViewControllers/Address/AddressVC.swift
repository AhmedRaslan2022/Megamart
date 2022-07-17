//
//  AddressVC.swift
//  Megamart
//
//  Created by A on 11/04/1401 AP.
//

import UIKit

class AddressVC: UIViewController {
    
    @IBOutlet weak var customerStreet: UITextField!
    @IBOutlet weak var customerCity: UITextField!
    @IBOutlet weak var customerCountry: UITextField!
    @IBOutlet weak var customerPhoneNumber: UITextField!
    
    
    var order: Order_Model?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveAddress(_ sender: Any) {
        if checkIs_NotEmpty() {
            guard let street = customerStreet.text else { return }
            guard let city = customerCity.text else { return }
            guard let country = customerCountry.text else { return }
            guard let phoneNumber = customerPhoneNumber.text else { return }
            guard var order = order else { return }
            
            order.address = Order_Address(street: street, city: city, country: country, phoneNumber: phoneNumber)
            
            goToPaymentVC(order: order)
        
        }
        
    }
    
    
    
    func checkIs_NotEmpty() -> Bool {

        if customerStreet.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Street", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if customerCity.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your City", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if customerCountry.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Country", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if customerPhoneNumber.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Phone Number", ActionTitle: "Try Again", viewController: self)
            return false
        }

        return true
    }

    
    
    func goToPaymentVC(order: Order_Model) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.payment_storyboard, bundle:nil)
        let addressViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Payment_viewController_id) as! PaymentViewController
        addressViewController.order = order
        self.navigationController?.pushViewController(addressViewController, animated: true)
    }

}
