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
    @IBOutlet weak var uiLanguage: UIButton!
    
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
    
}
