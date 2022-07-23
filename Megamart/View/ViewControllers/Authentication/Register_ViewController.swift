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
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var fullName_textField: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    var register_viewModel : RegiserNewCustomer_protocol = RegisterNewCustomer_viewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
        logoImage.layer.cornerRadius = 20
        logoImage.layer.cornerRadius = 20
        
        
        self.userEmail_textField.delegate = self
        self.userPassword_textField.delegate = self
        self.confirmPassword_textField.delegate = self
        self.fullName_textField.delegate = self
        
        register_viewModel.binding = { error in
            if let error = error {
                addAlert(title: "Warning", message: error, ActionTitle: "cancel", viewController: self)
            }else{
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        register_viewModel.retriveAllCustomer()
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        register()
    }
    
    
//MARK: -                               Register Method

    func register() {
        if checkIs_NotEmpty(){
            if let name = fullName_textField.text, let email = userEmail_textField.text,
               let password = userPassword_textField.text, let confirmPassword = confirmPassword_textField.text {

                if ( register_viewModel.checkPassword(password: password , ConfirmPassword: confirmPassword)) {
                    self.register_viewModel.createNewCustomer(email: email, name: name, password: password, conformPassword: confirmPassword)
                }
                else
                    {
                    addAlert(title: "Warning", message: "Password and confirm password do not match", ActionTitle: "Try Again", viewController: self)
                    userPassword_textField.text = ""
                    confirmPassword_textField.text = ""
                }
            }
        }
    }
    
//MARK: -                               Check is not Empty

    
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


//MARK: -                               UITextFieldDelegate


extension Register_ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.fullName_textField:
            self.userEmail_textField.becomeFirstResponder()
            
        case self.userEmail_textField:
            self.userPassword_textField.becomeFirstResponder()
        
        case self.userPassword_textField:
            self.confirmPassword_textField.becomeFirstResponder()
        
        case self.confirmPassword_textField:
            register()
        default:
            return false
        }
        
        return true
    }
    
}
