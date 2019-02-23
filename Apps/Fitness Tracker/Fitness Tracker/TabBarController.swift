//
//  TabBarController.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 24/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        homeViewController.navigationItem.title = "Home"
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendRequestsController = UIViewController()
        friendRequestsController.navigationItem.title = "Request"
        let secondNavigationController = UINavigationController(rootViewController: friendRequestsController)
        secondNavigationController.title = "Request"
        secondNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let recordVC = RecordViewController()
        recordVC.navigationItem.title = "Record"
        let recordController = UINavigationController(rootViewController: recordVC)
        recordController.title = "Record"
        recordController.tabBarItem.image = UIImage()
    
        viewControllers = [navigationController, secondNavigationController, recordController]
        
        tabBar.isTranslucent = false
        
        let topBoarder = CALayer()
        topBoarder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBoarder.backgroundColor = UIColor(r: 229, g: 231, b: 234).cgColor
        
        
        tabBar.layer.addSublayer(topBoarder)
        tabBar.clipsToBounds = true
        

    }
    
    

    

}
