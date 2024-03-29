//
//  HomeDatasource.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 21/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

extension Collection where Iterator.Element == JSON {
    func decode<T: JSONDecodable>() throws -> [T] {
        return try map{try T(json: $0)}
    }
}

class HomeDatasource: Datasource, JSONDecodable {
    
    let users: [User]
    
    required init(json: JSON) throws {
    
        guard let userJsonArray = json["users"].array, let tweetsJsonArray = json["tweets"].array else {
            throw NSError(domain: "com.letsbuildthatapp", code: 1, userInfo: [NSLocalizedDescriptionKey: "parsing json not valid"])
        }

//        self.users = userJsonArray.map{return User(json: $0)}
//        self.tweets = tweetsJsonArray.map{return Tweet(json: $0)}
        
        self.users = try userJsonArray.decode()
        self.tweets = try tweetsJsonArray.decode()
        
    }
    
    let tweets: [Tweet]
        
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
}
