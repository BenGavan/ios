//
//  Message.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 20/07/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import Foundation

struct Friend: Codable {
    var name: String?
    var profileImageName: String?
    var messages: [Message]?
}

struct Message: Codable {
    var text: String?
    var date: Date?
    var isSentFromThisAccount: Bool?
    var isSeen: Bool?
    var isSent: Bool?
}

struct TheMessage: Codable {
    var text: String?
    var timeStamp: Int?
    var toUID: String?
    var fromUID: String?
    var isSent: Bool?
    var isDelivered: Bool?
    var isSeen: Bool?
    
    func isFromThisAccount() -> Bool {
        if self.fromUID == Auth.shared.getUID() {
            return false
        }
        return true
    }
    
    func getDate() -> Date {
        guard let timeStamp = self.timeStamp else { print("Something went wrong converting timestamp to date:, \(self.timeStamp ?? -1)"); return Date() }
        return Date(timeIntervalSince1970: TimeInterval(timeStamp))
    }
}

struct ServerSideMessage: Codable {
    var toID: String?
    var fromID: String?
    var text: String?
    var timeStamp: Int?
//    var time: Date? {
//        get {
//            guard let timeStamp = self.timeStamp else { return nil }
//            return Date(timeIntervalSince1970: TimeInterval(timeStamp))
//        }
//    }
}
