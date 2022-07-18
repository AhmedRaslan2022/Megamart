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
        
        self.customerStreet.delegate = self
        self.customerCity.delegate = self
        self.customerCountry.delegate = self
        self.customerPhoneNumber.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        saveAddress()
    }

}


// MARK: -                          Extension for check is not Empty

extension AddressVC {
    
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

//MARK: -                                       Save Address
    
    func saveAddress() {
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
    
//MARK: -                                       go To Payment
    
    func goToPaymentVC(order: Order_Model) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.payment_storyboard, bundle:nil)
        let addressViewController = storyBoard.instantiateViewController(withIdentifier: Constants.Payment_viewController_id) as! PaymentViewController
        addressViewController.order = order
        self.navigationController?.pushViewController(addressViewController, animated: true)
    }
    

}




//MARK: -                               UITextFieldDelegate


extension AddressVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.customerStreet:
            self.customerCity.becomeFirstResponder()
            
        case self.customerCity:
            self.customerCountry.becomeFirstResponder()
        
        case self.customerCountry:
            self.customerPhoneNumber.becomeFirstResponder()
        
        case self.customerPhoneNumber:
            saveAddress()
        default:
            return false
        }
        
        return true
    }
    
}
