//
//  SignUp_ViewController.swift
//  Megamart
//
//  Created by MAC on 01/07/2022.
//

import UIKit

class SignUp_ViewController: UIViewController {

    @IBOutlet weak var signUp_button: UIButton!
    @IBOutlet weak var userPassword_textField: UITextField!
    @IBOutlet weak var conformPassword_textField: UITextField!
    @IBOutlet weak var userEmail_textField: UITextField!
    @IBOutlet weak var fullName_textField: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.layer.cornerRadius = 30
        backgroundView.layer.cornerRadius = 30
    }
    


}
