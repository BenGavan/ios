//
//  FriendControllHelper.swift
//  fbMessenger
//
//  Created by Ben Gavan on 02/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class Friend1 {
    var name: String?
    var profileImageName: String?
}

class Message1: NSObject {
    var text: String?
    var date: Date?
    let m = Message()
    var friend: Friend?
}

extension FriendsViewController {
    
    func setupdata() {
        let mark = Friend()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let message = Message()
        message.friend = mark
        message.text = "Hello, my name is Mark.  Nice to meet you..."
        message.date = Date()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Apple creates devices for the world"
        messageSteve.date = Date()
        
        messages = [message, messageSteve]
    }
}
