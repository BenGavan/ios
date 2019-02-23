//
//  User.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 15/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

struct Follow: Codable {
    var user: User?
    var since: Int?
}

struct User: Codable {
    var uid: String?
    var displayName: String?
    var username: String?
    var profileImageUrl: String?
    var amFollowing: Bool?
    var numberOfFollowers: Int?
    var numberFollowing: Int?
    var numberOfPosts: Int?
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(User.self, from: data)
    }
    
    init() {
        self.init(uid: "", displayName: "", userName: "", profileImageUrl: "", amFollowing: nil)
    }
    
    init(uid: String?, displayName: String?, userName: String?, profileImageUrl: String?, amFollowing: Bool?) {
        self.uid = uid
        self.displayName = displayName
        self.username = userName
        self.profileImageUrl = profileImageUrl
        self.amFollowing = amFollowing
    }
    
    func getProfilePicture() -> UIImage? {
        // gets profile picture for this user's profile image url
        guard let url = self.profileImageUrl else { return nil }
        print(url)
        return UIImage()
    }
}



struct NewUser {
    var name: String?
    var userName: String?
    var email: String?
    var password: String?
    var profileImage: UIImage?
}




