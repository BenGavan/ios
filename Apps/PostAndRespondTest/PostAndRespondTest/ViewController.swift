//
//  ViewController.swift
//  PostAndRespondTest
//
//  Created by Ben Gavan on 10/01/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

struct TestStruct: Decodable {
    var hello: String
}

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleTest), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        
        _ = button.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 100, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        
    }
    
    @objc private func handleTest() {
        print("pressed")
        
        let parameters = ["message": "hi"]
        
        guard let url = URL(string: "http://localhost:8080/testpost") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response: :", response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    let testjson = try JSONDecoder().decode(TestStruct.self, from: data)
                    print("json:\n", json)
                    print("decoded:", testjson.hello)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }

   


}


























//
//  UIView+anchors.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        _ = anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}
