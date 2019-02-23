//
//  User.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 22/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON

struct User: JSONDecodable {
    let name: String
    let userName: String
    let bioText: String
    let profileImageURL: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImageURL = json["profileImageURL"].stringValue
    }
    
}
