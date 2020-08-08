//
//  UserInfoVC.swift
//  GithubFinder
//
//  Created by Diego Oruna on 6/08/20.
//

import UIKit

protocol UserInfoVCDelegate:class {
    func didTapGithubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews:[UIView] = []
    
    var username:String!
    weak var delegate:FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getUserInfo()
        layoutUI()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        
        NetworkManager.shared.getUser(for: username) {[weak self] (result) in
            
            guard let self = self else {return}
            
            switch result{
            
            case .failure(let err):
                self.presentGFAlertOnMainThread(title: "Something went wront", message: err.rawValue, buttonTitle: "Ok")
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            }
            
        }
        
    }
    
    func configureUIElements(with user:User){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    @objc func handleDone(){
        dismiss(animated: true, completion: nil)
    }
    
    func layoutUI(){
        
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC:UIViewController, to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension UserInfoVC:UserInfoVCDelegate{
    
    func didTapGithubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "Url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)

    }
    
    func didTapGetFollowers(for user: User) {
        
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 😣", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
