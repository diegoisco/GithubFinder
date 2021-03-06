//
//  GFAvatarImageView.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = #imageLiteral(resourceName: "empty-state-logo")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
