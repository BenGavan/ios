//
//  BackButton.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 24/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "backArrow")
        if image == nil { print("image for pause button not found") }
        
        self.setImage(image, for: .normal)
        self.set(size: .init(width: 40, height: 35))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "settings")
        if image == nil { print("image for settings button not found") }
        
        self.setImage(image, for: .normal)
        self.set(size: .init(width: 40, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
