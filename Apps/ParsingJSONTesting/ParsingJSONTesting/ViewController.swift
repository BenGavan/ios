//
//  ViewController.swift
//  ParsingJSONTesting
//
//  Created by Ben Gavan on 01/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                let websiteDistription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                
                print(websiteDistription.name, websiteDistription.description)
                
//                let courses = try JSONDecoder().decode([Course].self, from: data)
//
//                print(courses[1].name)
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//                print(json)
//
//                let course = Course(json: json)
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
         
            
        }.resume()
        
//        let myCourse = Course(id: 1, name: "my course", link: "someLink", imageUrl: "some image url")
//
//        print(myCourse)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

