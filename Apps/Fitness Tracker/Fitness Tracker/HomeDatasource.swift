//
//  HomeDatasource.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 25/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation
//import LBTAComponents

class HomeDatasource: Datasource {
    
    let goal1 = Goal.init(goalType: .BIKE, distanceGoal: 10, distanceAchieved: 4)
    let goal2 = Goal.init(goalType: .RUN, distanceGoal: 5, distanceAchieved: 1)
    
    let bikeGoals = [Goal.init(goalType: .BIKE, distanceGoal: 10, distanceAchieved: 4), Goal.init(goalType: .RUN, distanceGoal: 5, distanceAchieved: 1)]
    
    let swimGoals = [Goal.init(goalType: .SWIM, distanceGoal: 10, distanceAchieved: 4)]
    
    
    

    override func footerClasses() -> [DatasourceCell.Type]? {
        return [HomeGoalsFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [GoalsHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [HomeGoalCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return bikeGoals[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return bikeGoals.count
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
}
