//
//  ViewController.swift
//  AnimatedHamburger
//
//  Created by Ben Gavan on 06/06/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let ham = Hamburger()
        ham.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(ham)

        ham.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ham.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
