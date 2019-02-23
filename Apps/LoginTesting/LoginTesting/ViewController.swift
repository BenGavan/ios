//
//  ViewController.swift
//  LoginTesting
//
//  Created by Ben Gavan on 02/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import CoreLocation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case username
        case email
        case password
    }
    
    func setUsername(value: String) {
        set(value, forKey: UserDefaultsKeys.username.rawValue)
        synchronize()
    }
    
    func getUsername() -> String? {
        if let username = string(forKey: UserDefaultsKeys.username.rawValue) {
            return username
        }
        return nil
    }
    
    func setPassword(value: String) {
        set(value, forKey: UserDefaultsKeys.password.rawValue)
        synchronize()
    }
    
    func getPassword() -> String? {
        return string(forKey: UserDefaultsKeys.password.rawValue)
    }
    
    
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}




class ViewController: UIViewController {
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
 
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleGet), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
        self.view.addSubview(getButton)
        
        _ = usernameTextField.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        _ = passwordTextField.anchor(usernameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        _ = signupButton.anchor(passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        _ = loginButton.anchor(signupButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)

        _ = getButton.anchor(loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)


    }
    
    
    @objc func handleLogin() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
    
        print(username, password)
    
        loginFor(username: username, password: password)
    
    }
    
    @objc func handleSignup() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        print(username, password)
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.setUsername(value: username)
        userDefaults.setPassword(value: password)
        
        signupFor(username: username, password: password)
    }
    
    @objc func handleGet() {
        fetchMoments()
    }
    
    

    private func signupFor(username: String, password: String) {
        let parameters = ["username": username, "email": "ben.gavan2000@gmail.com", "password": password]
        
        guard let url = URL(string: "http://localhost:8080/mobileregister") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            let defaults = UserDefaults.standard
            if let username = defaults.getUsername(), let password = defaults.getPassword() {
                
                self.loginFor(username: username, password: password)
            }
            
            }.resume()
    }
    
    private func loginFor(username: String, password: String) {
        let parameters = ["username": username, "email": "ben.gavan2000@gmail.com", "password": password]
        
        guard let url = URL(string: "http://localhost:8080/mobilelogin") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    
    private func fetchMoments() {
        let jsonUrlString = "http://localhost:8080/test"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                
                
               
                
                print(String(describing: data))
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
            }.resume()
    }

}


struct MomentOut {
    let user: String
    let text: String
    let id: String
    let time: String
    let latitude: String
    let longitude: String
}

enum MomentType {
    case text
    case photo
    case video
}

struct User: Decodable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var userName: String?
    var profileImageUrl: String?
}

struct Moment {
    let user: User?
    let text: String?
    let id: String?
    let type: MomentType?
    let time: Date?
    let location: CLLocationCoordinate2D?
}

struct MomentIn: Decodable {
    let user: User?
    let text: String?
    let id: String?
    let time: String?
    let latitude: String?
    let longitude: String?
}
