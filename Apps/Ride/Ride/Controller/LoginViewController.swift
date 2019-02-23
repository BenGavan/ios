//
//  LoginViewController.swift
//  Ride
//
//  Created by Ben Gavan on 07/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(newRide), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        view.addSubview(loginButton)
        
        _ = loginButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 100, bottomConstant: 0, rightConstant: 100, widthConstant: 70, heightConstant: 50)
        
        
    }
    
    @objc private func newRide() {
        print("logging in ")
        
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        guard let mainNavivationController = rootViewController as? MainNavigationController else { return }
//
//        mainNavivationController.viewControllers = [RideViewController()]
        
        
        let homeViewController = HomeViewController()
        present(homeViewController, animated: true, completion: {
            
        })
    }
    
    
}
