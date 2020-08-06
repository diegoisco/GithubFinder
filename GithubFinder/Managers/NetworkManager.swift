//
//  NetworkManager.swift
//  GithubFinder
//
//  Created by Diego Oruna on 5/08/20.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username:String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void){
        
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let _ = err{
                completed(nil, .unableToComplete)
            }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch{
//                completed(nil, "The data received from the server was invalid. Please try again")
                completed(nil, .invalidData)
            }
            
        }
        
        task.resume()
        
    }
}
