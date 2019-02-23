//
//  Model.swift
//  appstore1
//
//  Created by Ben Gavan on 17/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

struct AppCategory: Decodable {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    static func fetchFeaturedApps() {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }

            do {
                
                if error != nil {
                    print(error as Any)
                    print("Why!!!!!!")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let videos = try JSONDecoder().decode(AppCategory.self, from: data)
                    
                    print(videos)
                    
                } catch let jsonErr {
                    print("Error serializing json...", jsonErr)
                }
                
                
                
                
                
//                let appCategory = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                let appCategory = try JSONDecoder().decode(AppCategory.self, from: data!)

//                print(appCategory)
//                var appCategories =
//
//                for dict in json["categories"] as! [[String: Any]] {
//                    let appCategory = AppCategory()
//                    appCategory.setValuesForKeys(dict)
//                }
            } catch let err{
               print(err)
            }
            
            
        }.resume()
    }
    
    static func sampleApplCategories() -> [AppCategory] {
        var apps = [App]()
        
        let frozenApp = App(Id: nil, Name: "Disney Build it: Frozen", Category: "Entertainment", ImageName: "frozen", Price: 3.99)
        
        apps.append(frozenApp)
        
        let bestNewAppCategory = AppCategory(name: "Best New Apps", apps: apps, type: "")
        
        
        let telepaintApp = App(Id: nil, Name: "Telepaint", Category: "Games", ImageName: "telepaint", Price: 2.99)
//        telepaintApp.name = "Telepaint"
//        telepaintApp.category = "Games"
//        telepaintApp.imageName = "telepaint"
//        telepaintApp.price = NSNumber(value: 2.99)
        
        var bestNewGamesApps = [App]()
        bestNewGamesApps.append(telepaintApp)
        
        let bestNewGameCategory = AppCategory(name: "Best New Games", apps: bestNewGamesApps, type: "")
//        bestNewGameCategory.name = "Best New Games"
//        bestNewGameCategory.apps = bestNewGamesApps
        
        return [bestNewAppCategory, bestNewGameCategory]
    }
}

struct App: Decodable {
    
    var Id: Int?
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Float?
    
}
