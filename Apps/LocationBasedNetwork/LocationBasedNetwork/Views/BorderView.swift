//
//  BorderView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 23/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class BorderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .borderColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
