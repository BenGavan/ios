//
//  HomeGoalHeader.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 25/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation
//import LBTAComponents


class GoalsHeader: DatasourceCell {
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        // Initialize
        let items = ["Bike", "Run", "Swim"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        
//         Set up Frame and SegmentedControl
//        let frame = UIScreen.main.bounds
//        customSC.frame = CGRect(x: 0, y: 0, width: frame.width - 20, height: frame.height*0.1)
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor(r: 160, g: 160, b: 160)
        customSC.tintColor = .black
        
        // Add target action method
        customSC.addTarget(self, action: #selector(self.changeColor), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        addSubview(customSC)
        customSC.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
    }
    
    /**
     Handler for when custom Segmented Control changes and will change the
     background color of the view depending on the selection.
     */
    public func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("Run")
        case 2:
            print("Swim")
        default:
            print("Bike")
        }
        //        collectionView?.reloadItems(at: [IndexPath.init(item: 0, section: 0)])
        
    }
    
}
