//
//  ViewController.swift
//  serverRequestTesting1
//
//  Created by Ben Gavan on 03/10/2017.
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


struct Test: Decodable {
    let message: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        let jsonUrlString = "http://localhost:8080/hi"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            
            
            do {
                let websiteDistription = try JSONDecoder().decode(Test.self, from: data)
             
                print(websiteDistription)
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
            
            
            }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

