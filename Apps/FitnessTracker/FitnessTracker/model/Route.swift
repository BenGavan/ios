//
//  Route.swift
//  FitnessTracker
//
//  Created by Ben Gavan on 27/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import Foundation

struct Route: Encodable {
    var date: String?
    var duration: Int?
    var distance: Double?
    var averageSpeed: Double?
    var points: [Point]?
    
}

struct Point: Encodable {
    var longitude: Double
    var latitude: Double
    var altitude: Double
    var speed: Double
}
