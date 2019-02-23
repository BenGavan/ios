//
//  UserDefaults+helpers.swift
//  Dot Attack
//
//  Created by Ben Gavan on 16/10/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case highScore
    }
    
    func setHighScore(value: Int) {
        set(value, forKey: UserDefaultsKeys.highScore.rawValue)
        synchronize()
    }
    
    func getHighScore() -> Int {
        return value(forKey: UserDefaultsKeys.highScore.rawValue) as? Int ?? 0
    }
    
}
