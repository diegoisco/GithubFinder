//
//  NetworkManager.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username:String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void){
        
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let _ = err{
                completed(.failure(.unableToComplete))
            }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch{
//                completed(nil, "The data received from the server was invalid. Please try again")
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    func getUser(for username:String, completed: @escaping (Result<User, GFError>) -> ()){
        
        let endpoint = baseURL + username
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let _ = err{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            //Decoding data
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
    func downloadImage(from urlString:String, completed: @escaping (UIImage?) -> ()){
        
        let cachedKey = NSString(string: urlString)
//        self.image = #imageLiteral(resourceName: "empty-state-logo")
        
        if let image = cache.object(forKey: cachedKey){
//            self.image = image
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            
            guard let self = self,
                  err == nil,
                  let res = res as? HTTPURLResponse, res.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else{
                completed(nil)
                return
            }
        
            self.cache.setObject(image, forKey: cachedKey)
            
            DispatchQueue.main.async {
                completed(image)
            }
            
        }
        
        task.resume()
        
    }
    
}
