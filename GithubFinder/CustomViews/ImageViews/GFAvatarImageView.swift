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
    
    func downloadImage(from urlString:String){
        
        let cachedKey = NSString(string: urlString)
//        self.image = #imageLiteral(resourceName: "empty-state-logo")
        
        if let image = cache.object(forKey: cachedKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            
            guard let self = self else {return}
            
            if err != nil {return}
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else { return }
            
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cachedKey)
            
            DispatchQueue.main.async {
//                self.image = nil
                self.image = image
            }
            
        }
        
        task.resume()
        
    }
    
}
