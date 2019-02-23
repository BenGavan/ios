//
//  ViewController.swift
//  NavigationControllerTesting
//
//  Created by Ben Gavan on 31/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.isNavigationBarHidden = true
        
        
        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

