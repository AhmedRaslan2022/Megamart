//
//  MeViewController.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func goSettings_ViewController(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
        let settingsVC = storyBoard.instantiateViewController(withIdentifier: Constants.Setting_viewController_id) as! SettingViewController
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }

}
