//
//  Tweet.swift
//  Twitter Replica
//
//  Created by Ben Gavan on 13/06/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    let uid: String?
    let text: String?
    let timeStamp: String?
}
