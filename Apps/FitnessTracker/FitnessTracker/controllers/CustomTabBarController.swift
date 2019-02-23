//
//  CustomTabBarController.swift
//  FitnessTracker
//
//  Created by Ben Gavan on 26/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem.title = "Home"
        
        let recordViewController = RecordViewController()
        recordViewController.tabBarItem.title = "Record"
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.title = "Profile"
        
        self.viewControllers = [homeViewController, profileViewController, recordViewController,createDummyNavControllerWith(title: "Settings", imageName: "settings"), createDummyNavControllerWith(title: "Options", imageName: "settings"), createDummyNavControllerWith(title: "Record", imageName: "settings")]
        
    }
    
    private func createDummyNavControllerWith(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
    
}
