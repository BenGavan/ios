//
//  Auth.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 11/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import Foundation

class Auth {

    private struct LoginResponse: Codable {
        let uid: String?
    }
    
    private struct LogoutResponse: Codable {
        let isLoggedOut: Bool?
    }
    
    private struct MessagesResponse: Codable {
        let isLoggedIn: Bool?
        let messages: [ServerSideMessage]?
    }
    
    public static let shared = Auth()
    
    private var uid: String?
    
    let baseUrl = "http://localhost:8080"
    
    func test() {
        guard let url = URL(string: "\(baseUrl)/test") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    print("error \(statusCode)")
                }
                print(response)
            }
            
            if let data = data {
                print(data)
            }
            }.resume()
    }
    
    func logout(onSuccess: @escaping () -> (), onFail: Optional<() -> ()> = nil){
        print("Logging out")
        let jsonUrlString = baseUrl + "/logout"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            print(data as Any)
            guard let data = data else { return }
            
            do {
                let logoutResponse = try JSONDecoder().decode(LogoutResponse.self, from: data)
                print(logoutResponse)
                
                if logoutResponse.isLoggedOut == true {
                    Auth.shared.clearUID()
                    onSuccess()
                    return
                }
                print("The data: \(data)")
                
                onFail?()
                return
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
    
    func registerNewUser(displayName: String, username: String, email: String, phoneNumber: String, password: String, onSuccess: @escaping () -> (), onFail: @escaping (_ registerResponse: RegisterResponse) -> ()) {
        let username = username.lowercased()
        let email = email.lowercased()
    
        let parameters = ["display_name": displayName,
                          "username": username,
                          "email": email,
                          "phone_number": phoneNumber,
                          "password": password]
        
        guard let url = URL(string: "\(baseUrl)/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("username", forHTTPHeaderField: "username")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        print("Count of body is:", httpBody.count)
        print("arr", parameters)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    print("error \(statusCode)")
                }
                print(response)
            }
            
            if let data = data {
                do {
                    let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    print(registerResponse)
                    
                    print("Username Available:", registerResponse.isUsernameAvailable as Any)
                    print("Email Available:", registerResponse.isEmailAvailable as Any)
                    print("Phone Number Available:", registerResponse.isPhoneNumberAvailable as Any)
                    print("User Registration Successfull:", registerResponse.isUserRegistrationSuccessful as Any)
                    
                    guard let isSuccessful = registerResponse.isUserRegistrationSuccessful else { return }
                    guard let uid = registerResponse.uid else { print("UID nil"); return }
                    
                    if isSuccessful {
                        onSuccess()
                        Auth.shared.set(uid: uid)
                        return
                    }
                    onFail(registerResponse)
                    return
                } catch {
                    print("errrrmmm...")
                    print(error)
                }
            }
            }.resume()
    }
    
    
    
    func set(uid: String?) {
        self.uid = uid
        if let uid = uid {
            UserDefaults.shared.set(uid: uid)
        }
    }
    
    func getUID() -> String? {
        if let uid = self.uid {
            return uid
        }
        return UserDefaults.shared.getUID()
    }
    
    func clearUID() {
        self.set(uid: nil)
    }
    
    func getMessages(onSuccess: @escaping () -> ()) {
        let jsonUrlString = baseUrl + "/messages"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            print(data as Any)
            guard let data = data else { return }
            
            do {
                let logoutResponse = try JSONDecoder().decode(LogoutResponse.self, from: data)
                print(logoutResponse)
                
                if logoutResponse.isLoggedOut == true {
                    Auth.shared.clearUID()
                    onSuccess()
                    return
                }
                return
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            }.resume()
    }
 
}


