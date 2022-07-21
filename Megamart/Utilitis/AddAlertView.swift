//
//  AddAlertView.swift
//  Megamart
//
//  Created by MAC on 02/07/2022.
//

import UIKit

func addAlert(title:String, message:String, ActionTitle:String, viewController: UIViewController) {
    let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: ActionTitle, style: .cancel, handler: nil))
    
    DispatchQueue.main.async {
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

func requestLogin_alert(viewController: UIViewController) {
    
    let alert = UIAlertController(title: "Warning", message: "Please Login first and try again", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    alert.addAction(UIAlertAction(title: "Login", style: .destructive, handler: { _ in
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.authentication_storyboard, bundle:nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: Constants.login_viewController_id) as! Login_ViewController
//        loginViewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.pushViewController(loginViewController, animated: true)
    }))
    
    DispatchQueue.main.async {
        viewController.present(alert, animated: true, completion: nil)
    }

}
