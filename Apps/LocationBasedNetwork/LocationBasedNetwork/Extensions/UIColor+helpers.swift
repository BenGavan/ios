//
//  UIColor+helpers.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 14/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let borderColor = UIColor(white: 0.5, alpha: 0.5)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(r: 0, g: 119, b: 245)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
