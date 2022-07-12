//
//  SignUp_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit
import FirebaseAuth


class Register_ViewController: UIViewController {

    @IBOutlet weak var signUp_button: UIButton!
    @IBOutlet weak var userPassword_textField: UITextField!
    @IBOutlet weak var confirmPassword_textField: UITextField!
    @IBOutlet weak var userEmail_textField: UITextField!
    @IBOutlet weak var fullName_textField: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    var register_viewModel : RegiserNewCustomer_protocol = RegisterNewCustomer_viewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
        
        self.hideKeyboardWhenTappedAround()
        
        register_viewModel.binding = { error in
            if let error = error {
                addAlert(title: "Warning", message: error, ActionTitle: "cancle", viewController: self)
            }else{
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
    
    
    
    
    @IBAction func signUp(_ sender: UIButton) {
        if checkIs_NotEmpty(){
            if let name = fullName_textField.text, let email = userEmail_textField.text,
               let password = userPassword_textField.text, let confirmPassword = confirmPassword_textField.text {

                if ( register_viewModel.checkPassword(password: password , ConfirmPassword: confirmPassword)) {
                    self.register_viewModel.createNewCustomer(email: email, name: name, password: password, conformPassword: confirmPassword)
                }
            } else
                {
                addAlert(title: "Warning", message: "Password and confirm password do not match", ActionTitle: "Try Again", viewController: self)
                userPassword_textField.text = ""
                confirmPassword_textField.text = ""
            }
        }
        
    }
    
    
    
    
    func checkIs_NotEmpty() -> Bool {

        if fullName_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Full Name", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if userEmail_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Email", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if userPassword_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your password", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if confirmPassword_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please confirm your password", ActionTitle: "Try Again", viewController: self)
            return false
        }
        return true
    }

}
