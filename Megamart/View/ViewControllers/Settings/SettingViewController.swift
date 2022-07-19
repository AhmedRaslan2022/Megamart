//
//  SettingViewController.swift
//  Megamart
//
//  Created by A on 10/04/1401 AP.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var switchTheme: UISwitch!
    @IBOutlet weak var uiEditprofile: UIButton!
    @IBOutlet weak var uiLogout: UIButton!
    
    var settingsViewModel: SettingsProtocol = Settings_ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        settingsViewModel.binding = { error in
            if let error = error {
                addAlert(title: "Error in signout", message: error.localizedDescription , ActionTitle: "Try Again", viewController: self)
            }else{
                let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
                let homeVC = storyBoard.instantiateViewController(withIdentifier: Constants.tabBar_ViewController_id) as! UITabBarController
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switchTheme.isOn = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func darkMode(_ sender: Any) {
        
        if switchTheme.isOn == true {
            guard (UIApplication.shared.delegate as? AppDelegate) != nil else { return }
            view.window?.overrideUserInterfaceStyle = .dark
         }
        else{
            guard (UIApplication.shared.delegate as? AppDelegate) != nil else { return }
            view.window?.overrideUserInterfaceStyle = .light
        }
        
    }
    
    @IBAction func editPassword(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.authentication_storyboard, bundle:nil)
        let aboutVC = storyBoard.instantiateViewController(withIdentifier: Constants.resetPassword_ViewController_id) as! ResetPassword_ViewController
        self.navigationController?.show(aboutVC, sender: self)
    }
    
    
    
    @IBAction func logout(_ sender: UIButton) {
        let alert = UIAlertController(title: "Attention" , message: "Are you sure you want to log out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
            self.settingsViewModel.signout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func aboutUs(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
        let aboutVC = storyBoard.instantiateViewController(withIdentifier: Constants.about_ViewController_id) as! AboutViewController
        self.present(aboutVC, animated: true, completion: nil)
    }
    
}
