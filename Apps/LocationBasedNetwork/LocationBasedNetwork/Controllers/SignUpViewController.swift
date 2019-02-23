//
//  SignUpViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 19/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

//
//  ViewController.swift
//  audibleLogin
//
//  Created by Ben Gavan on 27/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

protocol SignUpControllerDelegate: class {
    func finishSigningUp(with user: NewUser)
    func backToLogin()
}

class SignUpViewController: UIViewController, SignUpControllerDelegate {
    
    weak var mainNavigationController: MainNavigationController?
   
    lazy var signUpPage: SignUpPage = {
        let view = SignUpPage()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        observeKeyBoardNotifications()
    }
    
    func finishSigningUp(with user: NewUser) {
        print("Signing up... with \(user)")
    
        ApiService.shared.signup(with: user, delegate: self)

    }
    
    func proceedToHome() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            homeViewController.mainNavigationController = self.mainNavigationController
            self.mainNavigationController?.pushViewController(homeViewController, animated: true)
        }
    }

    func backToLogin() {
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(signUpPage)
        
        signUpPage.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }
    
    private func observeKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -120 : -50
            
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    
    
    
    
    
    
    
}





