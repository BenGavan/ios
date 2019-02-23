//
//  ApiService.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 31/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation

class ApiService {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchHomeFeed(completion: @escaping ([Video]) -> ()) {     
        fetchFeedFor(url: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedFor(url: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedFor(url: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    private func fetchFeedFor(url: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                print("Why!!!!!!")
                return
            }

            guard let data = data else { return }
            
            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                
                DispatchQueue.main.async( execute: {
                    completion(videos)
                })
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
        }.resume()
    }
    
}
