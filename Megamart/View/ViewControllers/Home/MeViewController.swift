//
//  MeViewController.swift
//  Megamart
//
//  Created by Macintosh on 02/07/2022.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var wishListLabel: UILabel!
    
    @IBOutlet weak var wishlistCollection: UICollectionView!
    @IBOutlet weak var ordersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    
    @IBAction func orderMore(_ sender: Any) {
        
    }
    
    
  
    @IBAction func wishListMore(_ sender: Any) {
    }
    
    
    
    
//MARK: -                    Register and Login Buttons Buttons
    
    
        @IBAction func goLogin(_ sender: UIButton) {
        }
    
    @IBAction func goRegister(_ sender: Any) {
    }
    

    
    
    
    
//MARK: -                    Navigation Bar Buttons
    
    
    @IBAction func goCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.bag_storyboard,bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as? BagViewController{
            self.navigationController?.pushViewController(cartVC, animated: true)
      }
    
   }
       
    @IBAction func goSettings_ViewController(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.setting_storyboard, bundle:nil)
        let settingsVC = storyBoard.instantiateViewController(withIdentifier: Constants.Setting_viewController_id) as! SettingViewController
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    

}
