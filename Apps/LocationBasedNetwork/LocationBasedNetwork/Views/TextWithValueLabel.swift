//
//  TextWithValueLabel.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 25/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class TextWithValueLabel: UIView {
    
    var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    private let valueLabel = UILabel()
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 1
        self.backgroundColor = .clear
    }
    
    required init(text: String, value: Int) {
        self.text = text
        self.value = value
        
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.alpha = 1
        
//        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = "\(value)"
        valueLabel.backgroundColor = .clear
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        
        self.addSubview(valueLabel)
        self.addSubview(textLabel)
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
        
        self.setHeight(50)
    }
    
    convenience init() {
        self.init(text: "", value: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
