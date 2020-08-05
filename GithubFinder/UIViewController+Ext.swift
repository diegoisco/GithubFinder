//
//  UIViewController+Ext.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

extension UIViewController{
    
    func presentGFAlertOnMainThread(title:String, message:String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title:title, message: message, buttonTitle:buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
