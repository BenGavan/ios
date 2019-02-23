//
//  CustomTabBarController.swift
//  fbMessenger2
//
//  Created by Ben Gavan on 19/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsViewController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
//        let viewController = UIViewController()
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.tabBarItem.title = "Calls"
//        navController.tabBarItem.image = UIImage(named: "calls")
        
        viewControllers = [recentMessagesNavController, createDummyNavControllerWith(title: "Calls", imageName: "calls"), createDummyNavControllerWith(title: "Groups", imageName: "groups"), createDummyNavControllerWith(title: "People", imageName: "people"), createDummyNavControllerWith(title: "Settings", imageName: "settings")]
        
    }
    
    private func createDummyNavControllerWith(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
    
}
