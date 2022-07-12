//
//  Dismiss Keyboard.swift
//  Megamart
//
//  Created by MAC on 11/07/2022.
//

import UIKit

    
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
