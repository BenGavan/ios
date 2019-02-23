//
//  MainNavigationController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 14/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.isNavigationBarHidden = true
        
        ApiService.shared.fetchCurrentUserData { (user) in
            Auth.shared.set(uid: user.uid)
        }
        
        
        ApiService.shared.fetchFollowersForCurrentUser { (followers) in
            print("followers:", followers)
        }
        
        ApiService.shared.fetchFollowingForCurrentUser { (following) in
            print("following:", following)
        }
        
        if isLoggedIn() {
            let homeViewController = HomeViewController()
            homeViewController.mainNavigationController = self
            self.pushViewController(homeViewController, animated: true)
        } else {
//            let loginController = LoginViewController()
//            loginController.mainNavigationController = self
//            self.pushViewController(loginController, animated: true)
            
            let registerViewController = RegisterViewController()
            registerViewController.mainNavigationController = self
            self.pushViewController(registerViewController, animated: true)
            self.popViewController(animated: true)
//            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
//        return UserDefaults.standard.isLoggedIn()
        return false 
        if let uid = Auth.shared.getUID() {
            print("uid:", uid)
            Auth.shared.test()
            return true
        }
        
        return false 
    }
    
    @objc func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: {
            
        })
    }
    
    @objc func showHomeViewController() {
        let homeViewController = HomeViewController()
        present(homeViewController, animated: true, completion: {
            
        })
    }
}
