//
//  RoundedTextField.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 17/12/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    
    var inputHeight: CGFloat = 50
    
    init(placeHolder: String) {
        super.init(frame: CGRect())
        self.placeholder = placeHolder
        self.backgroundColor = .white
        self.heightAnchor.constraint(equalToConstant: inputHeight).isActive = true
        self.layer.cornerRadius = inputHeight / 2
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
