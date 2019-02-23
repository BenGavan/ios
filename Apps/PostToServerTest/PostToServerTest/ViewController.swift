//
//  ViewController.swift
//  PostToServerTest
//
//  Created by Ben Gavan on 26/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Post Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(postData), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        view.addSubview(cameraButton)
        
        _ = cameraButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
    }
    
    
    @objc func postData() {
        print("post")
        
        
        let parameters = ["id": "2","name": "jack", "email" : "testEmail1@gmail.com", "password": "testPassword"] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "http://localhost:8080/users")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let url = URL(string: "http://localhost:8080/users")!
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let postString = "id=13&name=Jack"
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(String(describing: error))")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(String(describing: response))")
//            }
//
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(String(describing: responseString))")
//        }
//        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

