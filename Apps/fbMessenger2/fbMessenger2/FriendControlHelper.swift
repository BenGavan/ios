//
//  FriendControllHelper.swift
//  fbMessenger
//
//  Created by Ben Gavan on 02/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import CoreData

//class Friend {
//    var name: String?
//    var profileImageName: String?
//}
//
//class Message: NSObject {
//    var text: String?
//    var date: Date?
//    let m = Message()
//    var friend: Friend?
//}

extension FriendsViewController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = delegate?.persistentContainer.viewContext else { return }
        
        do {
            
            let entityNames = ["Friend", "Message"]
            
            for entityName in entityNames {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                request.returnsObjectsAsFaults = false
                
                let results = try context.fetch(request)
                
                guard let objects = results as? [NSManagedObject] else { return }
                
                for object in objects {
                    context.delete(object)
                }
            }
            
            try context.save()
    
        } catch let error {
            print(error)
        }
    }
    
    func setupdata() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = delegate?.persistentContainer.viewContext else { return }
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        _ = FriendsViewController.createMessageWith(text: "Hello, my name is Mark.  Nice to meet you...", friend: mark, minutesAgo: 5, context: context)
        
        createSteveMessagesWith(context: context)
        
        let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        donald.name = "Donald Trump"
        donald.profileImageName = "donald_trump_profile"
        
        FriendsViewController.createMessageWith(text: "You're fired", friend: donald, minutesAgo: 10, context: context)
        
        let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        gandhi.name = "Mahtma Gandhi"
        gandhi.profileImageName = "gandhi"
        
        FriendsViewController.createMessageWith(text: "Love, Peace, and Joy", friend: gandhi, minutesAgo: 60 * 24, context: context, isSender: false)
        
        let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        hillary.name = "Hillary Clinton"
        hillary.profileImageName = "hillary_profile"
        
        _ = FriendsViewController.createMessageWith(text: "Vote for me", friend: hillary, minutesAgo: 8 * 60 * 24, context: context, isSender: false)
        
        do {
            try context.save()
            print("Saved")
        } catch let error {
            print(error)
        }
        
    }
    
    private func createSteveMessagesWith(context: NSManagedObjectContext) {
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        FriendsViewController.createMessageWith(text: "Good morning...", friend: steve, minutesAgo: 4, context: context)
        FriendsViewController.createMessageWith(text: "Hello, How are you?   Hope you are having a good day today.....", friend: steve, minutesAgo: 3.0, context: context, isSender: false)
        FriendsViewController.createMessageWith(text: "Are you interested in doing something?   We have a wide veriety of apple devices tht will suit your needs do please make your purchase very very soon", friend: steve, minutesAgo: 2, context: context, isSender: false)
        
        // response message
        
        FriendsViewController.createMessageWith(text: "Yes, totally looking to buy an iphone X.", friend: steve, minutesAgo: 1, context: context, isSender: true)
        
        FriendsViewController.createMessageWith(text: "Totally understand that you want the iphome 7 but you will have to wait till september till the new release.  Sorry but that is just how apple works", friend: steve, minutesAgo: 0, context: context)
        
        FriendsViewController.createMessageWith(text: "Absolutely.  I'll just use my gigantic iPhone 6 plus till then", friend: steve, minutesAgo: 0, context: context, isSender: true)

    }
    
    static func createMessageWith(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        
        friend.lastMessage = message
        return message
    }
    
//    func loadData() {
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//
//        guard let context = delegate?.persistentContainer.viewContext else { return }
//
//        if let friends = fetchFriends() {
//
//            messages = [Message]()
//
//            for friend in friends {
//                print("Friend:", friend.name!)
//
//                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
//                request.returnsObjectsAsFaults = false
//                request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                request.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                request.fetchLimit = 1
//
//
//                do {
//                    let results = try context.fetch(request)
//
//                    guard let messagesRecieved = results as? [Message] else { return }
//
//                    messages.append(contentsOf: messagesRecieved)
//                } catch let error {
//                    print(error)
//                }
//            }
//
//
////            messages = messages.sorted(by: {$0.date?.compare({$1.date!}) == .orderedDescending})
//
//            messages.sort(by: { (message1, message2) -> Bool in
//                if message1.date! > message2.date! {
//                    return true
//                } else {
//                    return false
//                }
//            })
//
//        }
    
       
    
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = delegate?.persistentContainer.viewContext else { return nil }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        request.returnsObjectsAsFaults = false

        
        do {
            
            let results = try context.fetch(request)
            
            return results as? [Friend]
            
        } catch let error {
            print(error)
        }

        return nil
    }
}















