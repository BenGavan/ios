//
//  Goals.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 24/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation

enum GoalType {
    case BIKE
    case RUN
    case SWIM
}

struct Goal {
    var goalType: GoalType
    var distanceGoal: Int
    var distanceAchieved: Int
}
