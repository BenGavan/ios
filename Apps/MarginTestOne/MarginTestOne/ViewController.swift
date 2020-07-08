//
//  ViewController.swift
//  MarginTestOne
//
//  Created by Ben Gavan on 08/11/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = UIView()
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.backgroundColor = .blue
        v1.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        let v2 = UIView()
        v2.translatesAutoresizingMaskIntoConstraints = false
        v2.backgroundColor = .red
        
        view.addSubview(v1)
        
        v1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        v1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        v1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        v1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        v1.addSubview(v2)
        
        v2.topAnchor.constraint(equalTo: v1.layoutMarginsGuide.topAnchor).isActive = true
        v2.leadingAnchor.constraint(equalTo: v1.layoutMarginsGuide.leadingAnchor).isActive = true
        v2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        v2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let something = v1.layoutMarginsGuide.constraintsAffectingLayout(for: .horizontal)
        print(something)
        
    }


}

