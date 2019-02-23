//
//  HomeGoalCell.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 25/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation


class HomeGoalCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet{
            guard let goal = datasourceItem as? Goal else { return }
            
            goalValueLabel.text = "\(goal.distanceAchieved) / \(goal.distanceGoal)"
            
            switch goal.goalType{
            case .BIKE:
                typeLabel.text = "Bike Goal"
            case .RUN:
                typeLabel.text = "Run Goal"
            case .SWIM:
                break
            }
        }
        
    }
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        return label
    }()
    
    let goalValueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.text = "0/100km"
        return label
    }()
    
    let bar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(bar)
        addSubview(typeLabel)
        addSubview(goalValueLabel)
        
        typeLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bar.anchor(typeLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 2, leftConstant: 10, bottomConstant: 2, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        goalValueLabel.anchor(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: bar.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}
