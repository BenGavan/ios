//
//  ViewController.swift
//  BasicLoadingSolidCircleAnimation
//
//  Created by Ben Gavan on 10/07/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let circle = UIView()
    var displayLink: CADisplayLink!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCircle()
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleAnimations))
        displayLink.add(to: RunLoop.main, forMode: .default)
    }
    
    var value: CGFloat = 0
    var invert = false
    
    @objc private func handleAnimations() {
        invert ? (value -= 1) : (value += 1)
        circle.backgroundColor = UIColor.red.withAlphaComponent(value / 100)
        if value > 100 || value < 1 {
            invert = !invert
        }
        print(value)
    }
    
    private func setupCircle() {
        view.addSubview(circle)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .red
        circle.layer.cornerRadius = 50
        
        circle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }


}

