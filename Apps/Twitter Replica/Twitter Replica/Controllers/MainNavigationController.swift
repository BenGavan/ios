//
//  ViewController.swift
//  Twitter Replica
//
//  Created by Ben Gavan on 13/06/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        let homeViewController = HomeViewController()
        self.pushViewController(homeViewController, animated: true)
    }


}

