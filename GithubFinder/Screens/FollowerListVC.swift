//
//  FollowerListVC.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Test", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print(followers.count)
            print(followers)
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
