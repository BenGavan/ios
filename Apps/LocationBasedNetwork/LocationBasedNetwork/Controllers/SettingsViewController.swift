//
//  SettingsViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 13/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, SettingsTopBarDelegate {
    
    weak var mainNavigationController: MainNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .purple
        
        let topBar = SettingsTopBar()
        topBar.delegate = self

        self.view.addSubview(topBar)
        
        topBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                      leading: self.view.leadingAnchor,
                      bottom: nil,
                      trailing: self.view.trailingAnchor,
                      height: 50)
    }
    
    @objc private func handleTap() {
        print("Tappp")
    }
    
    // MARK: SettingsTopBarDelegate
    func back() {
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    // MARK: Selector methods
    @objc private func handleLogout() {
        print("Logging out")
        Auth.shared.logout(onSuccess: {
            DispatchQueue.main.async {
                let loginViewController = LoginViewController()
                loginViewController.mainNavigationController = self.mainNavigationController
                self.mainNavigationController?.pushViewController(loginViewController, animated: true)
            }
        }, onFail: { // onFail
            print("Logout Unsuccessful")
        })
    }
    
    //    func test(something: Optional<() -> ()> = nil) {
    //        if let something = something {
    //            something()
    //        }
    //    }
    
    
    
//    private lazy var logoutButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Logout", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
//        return button
//    }()
}
