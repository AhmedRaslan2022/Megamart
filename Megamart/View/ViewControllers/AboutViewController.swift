//
//  AboutViewController.swift
//  Megamart
//
//  Created by Macintosh on 18/07/2022.
//

import UIKit

class AboutViewController: UIViewController {
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

         

            

    @IBAction func raslanGithub(_ sender: Any) {
       
        guard let url = URL(string: GithubLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func saadGithb(_ sender: Any) {
        guard let url = URL(string: GithubLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      
    }
    @IBAction func sophyGithub(_ sender: Any) {
        guard let url = URL(string: GithubLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
       
    }
    @IBAction func sophyLinkedin(_ sender: Any) {
        
        guard let url = URL(string: LinkedinLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func saadLinkedIn(_ sender: Any) {
        guard let url = URL(string: LinkedinLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func RaslanLikedin(_ sender: Any) {
        guard let url = URL(string: LinkedinLinks.raslanGit.rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
