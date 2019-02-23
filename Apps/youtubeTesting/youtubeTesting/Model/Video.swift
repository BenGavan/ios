//
//  Video.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 11/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

struct Video: Decodable {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
    var uploadDate: Date?
    var duration: Int?
    
    var channel: Channel?
}

struct Channel: Decodable {
    var name: String?
    var profile_image_name: String?
}
