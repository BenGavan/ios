//
//  ViewController.swift
//  Ride
//
//  Created by Ben Gavan on 07/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let newRideButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("New Ride", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(newRide), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        view.backgroundColor = .white
        view.addSubview(newRideButton)
        
        _ = newRideButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 100, bottomConstant: 0, rightConstant: 100, widthConstant: 70, heightConstant: 50)
    
    
    }
    
    @objc private func newRide() {
        print("new Ride")
        
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        guard let mainNavivationController = rootViewController as? MainNavigationController else { return }
//
//        mainNavivationController.viewControllers = [RideViewController()]
        
        let newRideViewController = RideViewController()
        present(newRideViewController, animated: true, completion: {
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

