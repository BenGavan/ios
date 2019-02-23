//
//  HomeViewController.swift
//  audibleLogin
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "We're logged in"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        let imageView = UIImageView(image: UIImage(named: "home"))
        view.addSubview(imageView)
        _ = imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    @objc func handleSignOut() {
        UserDefaults.standard.setLoggedIn(value: false)
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
        
    }
}
