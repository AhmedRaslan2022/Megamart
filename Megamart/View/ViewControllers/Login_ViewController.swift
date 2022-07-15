//
//  Login_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit
import FirebaseAuth

class Login_ViewController: UIViewController {

    @IBOutlet weak var signUp_button: UIButton!
    @IBOutlet weak var signIn_button: UIButton!
    @IBOutlet weak var userPassword_textField: UITextField!
    @IBOutlet weak var userEmail_textField: UITextField!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var backgroundView: UIView!

    var login_viewModel: Login_protocol = Login_viewModel()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
        
        // check is logged in before or not
        if self.defaults.string(forKey: Userdefaults_key.customerId.rawValue) != nil  {
            self.navigateTo_HomeViewController()
        }
        
        userEmail_textField.delegate = self
        userPassword_textField.delegate = self
        
        
        login_viewModel.binding = { error in
            if let error = error {
                addAlert(title: "Warning", message: error, ActionTitle: "Try Again", viewController: self)
            }
            else {
                self.navigateTo_HomeViewController()
                print("%%%%%%%%% %%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
            }
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        login_viewModel.retriveAllCustomer()
    }
    
    
    func navigateTo_HomeViewController() {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: Constants.tabBar_ViewController_id) as! UITabBarController
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: false, completion: nil)
    }
    
    
    func login() {
        if checkIs_NotEmpty() {
            if let email = userEmail_textField.text, let  password = userPassword_textField.text{
                login_viewModel.login(userName: email, password: password)
            }
        }
    }
    
    
    
//MARK: -                               Buttons Action
    
    
    
    @IBAction func login(_ sender: Any) {
        login()
    }
    
    @IBAction func signup(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.SignUp_viewController_id) {
            self.navigationController?.show(vc, sender: self)
        }
    }

    func checkIs_NotEmpty() -> Bool {

        if userEmail_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your Email", ActionTitle: "Try Again", viewController: self)
            return false
        }
        if userPassword_textField.text!.isEmpty {
            addAlert(title: "Warning", message: "Please enter your password", ActionTitle: "Try Again", viewController: self)
            return false
        }

        return true
    }
    
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        if let resetPasswordViewController = storyboard?.instantiateViewController(withIdentifier: Constants.resetPassword_ViewController_id){
            self.navigationController?.show(resetPasswordViewController, sender: self)
        }
        
    }
    
    
    
    
}

//MARK: -                               UITextFieldDelegate


extension Login_ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userEmail_textField {
            self.userPassword_textField.becomeFirstResponder()
        }
        if textField == self.userPassword_textField {
            login()
        }
        return true
    }
    
}
