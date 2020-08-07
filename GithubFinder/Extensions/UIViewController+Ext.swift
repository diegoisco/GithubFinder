//
//  UIViewController+Ext.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

fileprivate var containerView:UIView!

extension UIViewController{
    
    func presentGFAlertOnMainThread(title:String, message:String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title:title, message: message, buttonTitle:buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
    }
    
    func showEmptyStateView(with message:String, in view:UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
