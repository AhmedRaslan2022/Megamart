//
//  ResetPassword_ViewController.swift
//  Megamart
//
//  Created by MAC on 10/07/2022.
//

import UIKit
import Firebase

class ResetPassword_ViewController: UIViewController {

    
    @IBOutlet weak var updatePasswordView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userEmail_textField: UITextField!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    
    var restPasswordViewModel: ResetPassword_protocol  = ResetPassword_viewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePasswordView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
        logoImage.layer.cornerRadius = 20
        logoImage.layer.cornerRadius = 20

        addAlert(title: "notiation", message: "Please, after updating the password, re-confirm it from your email", ActionTitle: "OK", viewController: self)
        
        self.restPasswordViewModel.bindingData_api = { error in
            print("^^^^^^^^^^^ ^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^")
            if let error = error {
                
                addAlert(title: "Error", message: error.localizedDescription, ActionTitle: "Try Again", viewController: self)
            }
            else
            {

                let alert = UIAlertController(title: "Attention" , message: "44444 Please, after updating the password, re-confirm it from your email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
            
        
    }


    @IBAction func updatePassword(_ sender: UIButton) {
        if checkIs_NotEmpty() {
            guard let userEmail = userEmail_textField.text else { return }
            guard let password = newPassword.text else { return }
            guard let conformPassword = conformPassword.text else { return }
            if restPasswordViewModel.checkPassword(password: password, ConformPassword: conformPassword){
                self.restPasswordViewModel.restPassword_firebase(userEmail: userEmail)
                self.restPasswordViewModel.restPassword_api(userEmail: userEmail, newPassword: password)
            }else{
                addAlert(title: "Warning", message: "Password and confirm password do not match", ActionTitle: "Try Again", viewController: self)
            }
        }
    }
    
    
    
    func checkIs_NotEmpty() -> Bool {

        if userEmail_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Email", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if newPassword.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter new password", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if conformPassword.text!.isEmpty {
            addAlert(title: "Warning", message: "Please conform your password", ActionTitle: "Try Again", viewController: self)
            return false
        }
        
        return true
    }
    
}
