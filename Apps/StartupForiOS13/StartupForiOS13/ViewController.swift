//
//  ViewController.swift
//  StartupForiOS13
//
//  Created by Ben Gavan on 30/10/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey there"
        
        self.view.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

