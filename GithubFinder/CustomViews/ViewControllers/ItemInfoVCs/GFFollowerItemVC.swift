//
//  GFFollowerItemVC.swift
//  GithubFinder
//
//  Created by Diego Oruna on 7/08/20.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configItems()
    }
    
    private func configItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func handleTap() {
        delegate.didTapGetFollowers(for: user)
    }
    
}
