//
//  GFRepoItemVC.swift
//  GithubFinder
//
//  Created by Diego Oruna on 7/08/20.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configItems()
    }
    
    private func configItems(){
        itemInfoViewOne.set(itemInfoType: .repo, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func handleTap() {
        delegate.didTapGithubProfile(for: user)
    }
    
}
