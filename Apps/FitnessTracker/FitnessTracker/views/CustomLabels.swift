//
//  DistanceLabel.swift
//  FitnessTracker
//
//  Created by Ben Gavan on 25/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class DistanceLabel: UILabel {
    
    var distance: Double = 0 {
        didSet {
            if distance < 1000 {
                self.text = "\(Int(distance)) meters"
            } else {
                self.text = "\((distance / 1000).rounded(toPlaces: 2)) km"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "0 meters"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TimeLabel: UILabel {
    
    var time: Double = 0 {
        didSet {
            let hours = Int(time / 3600)
            let minutes = Int((time - Double(60 * hours)) / 60)
            let seconds = Int((time - Double((hours * 3600)) - Double(minutes * 60)).truncatingRemainder(dividingBy: 60))
            
            self.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "00:00:00"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
