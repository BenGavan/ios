//
//  RegisterButton.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 16/12/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class RegisterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("Register", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gradientLayer: CAGradientLayer!
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .red
        
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            let startColor = UIColor.rgb(r: 108, g: 220, b: 158).cgColor
            let endColor = UIColor.rgb(r: 68, g: 199, b: 238).cgColor
            gradientLayer.colors = [startColor, endColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            layer.insertSublayer(gradientLayer, at: 0)
        }
        
        gradientLayer.frame = rect
        layer.cornerRadius = rect.height / 2
        layer.masksToBounds = true
        super.draw(rect)
    }
    
}
