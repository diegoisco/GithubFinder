//
//  FollowerListVC.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username:String?{
        didSet{
            print(username ?? "")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
