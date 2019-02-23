//
//  UserDefaults+helpers.swift
//  audibleLogin
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}
