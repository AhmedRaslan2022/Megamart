//
//  SplashScreenViewController.swift
//  Megamart
//
//  Created by MAC on 19/07/2022.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {


    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "splashScreen")
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        animationView?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if Login_Verification() {
                let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Main_storyboard, bundle:nil)
                let homeVC = storyBoard.instantiateViewController(withIdentifier: Constants.tabBar_ViewController_id) as! UITabBarController
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: false, completion: nil)
            }
            else{
                let storyBoard : UIStoryboard = UIStoryboard(name: Constants.authentication_storyboard, bundle:nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: Constants.login_viewController_id) as! Login_ViewController
//                homeVC.modalPresentationStyle = .fullScreen
                self.navigationController?.show(loginVC, sender: self)
            }
        }
    }
    

}
