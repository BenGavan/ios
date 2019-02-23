//
//  UserDefaults+helpers.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 27/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let shared = UserDefaults.standard
    
//    private enum Keys: String {
//        case isLoggedIn
//        case token
//        case username
//        case password
//        case email
//        case firstName
//        case lastName
//    }
    
    private struct Keys {
        static let isLoggedIn = "isLoggedIn"
        static let token = "token"
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let firstname = "firstname"
        static let lastname = "lastname"
        static let uid = "uid"
    }
    
    // logged In - whether or not a user is logged in
    func setLoggedIn(value: Bool) {
        set(value, forKey: Keys.isLoggedIn)
        self.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: Keys.isLoggedIn)
    }
    
    // Token - used to comunicate w/ server
    func set(token: String) {
        set(token, forKey: Keys.token)
        self.synchronize()
    }
    
    func getToken() -> String? {
        return string(forKey: Keys.token)
    }
    
    // UID - of the current signed in user
    func set(uid: String) {
        set(uid, forKey: Keys.uid)
        self.synchronize()
    }
    
    func getUID() -> String? {
        return string(forKey: Keys.uid)
    }
    
    // Username - of current signed in user
    func set(username: String) {
        set(username, forKey: Keys.username)
        self.synchronize()
    }
    
    func getUsername() -> String? {
        return string(forKey: Keys.username)
    }
    
    // Email - of current sign in user
    
    func set(email: String) {
        set(email, forKey: Keys.email)
        self.synchronize()
    }
    
    func getEmail() -> String? {
        return string(forKey: Keys.email)
    }
    
    // Password - of current signed in user
    func set(password: String) {
        set(password, forKey: Keys.password)
        self.synchronize()
    }
    
    func getPassword() -> String? {
        return string(forKey: Keys.password)
    }
    
    // First name - of current signed in user
    func set(firstname: String) {
        set(firstname, forKey: Keys.firstname)
        self.synchronize()
    }
    
    func getFirstname() -> String? {
        return string(forKey: Keys.firstname)
    }
    
    
    // Last name - of current signed in user
    func set(lastname: String) {
        set(lastname, forKey: Keys.lastname)
        self.synchronize()
    }
    
    func getLastname() -> String? {
        return string(forKey: Keys.lastname)
    }
}
