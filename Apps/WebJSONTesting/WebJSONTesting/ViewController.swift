//
//  ViewController.swift
//  WebJSONTesting
//
//  Created by Ben Gavan on 17/05/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Get some data", for: .normal)
        button.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }

    
    @objc fileprivate func handlePress() {
        print("Getting data")
        
        struct Response: Decodable {
            let name: String?
        }
        
        let baseURL = "http://localhost:8001"
        
        let urlString = baseURL + "/testjson"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            guard let data = data else { print("Fuck"); return }
            print(data)
            print(String(bytes: data, encoding: .utf8)!)
            do {
                let resp = try JSONDecoder().decode(Response.self, from: data)
                print("Josn repsonse", resp)
                print(resp.name)
            } catch let jsonError {
                print("Json error: ", jsonError)
            }
            
        }.resume()

    }

}

