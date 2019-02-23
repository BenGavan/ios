//
//  MainNavigationControl.swift
//  audibleLogin
//
//  Created by Ben Gavan on 29/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isLoggedIn() {
            let homeViewController = HomeViewController()
            viewControllers = [homeViewController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: {
            
        })
    }
    
}






