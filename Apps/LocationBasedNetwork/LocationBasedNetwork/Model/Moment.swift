//
//  Moment.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import CoreLocation

enum MomentType {
    case text
    case photo
    case video
}

struct Moment {
    let user: User?
    let text: String?
    let id: String?
    let type: MomentType?
    let time: Date?
    let location: CLLocationCoordinate2D?
}



struct RelpyMoment {
    let user: User?
    let text: String?
    let id: String?
    let replyingTo: Moment?
    let time: Date?
    let location: CLLocationCoordinate2D?
    
}

struct MomentIn: Decodable {
    let user: User?
    let text: String?
    let id: String?
    let time: String?
    let latitude: String?
    let longitude: String?
}


