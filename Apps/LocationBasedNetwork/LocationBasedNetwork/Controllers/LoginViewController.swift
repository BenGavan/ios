//
//  ViewController.swift
//  audibleLogin
//
//  Created by Ben Gavan on 27/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
    func finishLoggingIn(with username: String, password: String)
    func finishSignUp()
//    func forgotPassword()
    func cancel()
}

class LoginViewController: UIViewController, LoginControllerDelegate {
    
    let emailTextField = RoundedTextField(placeHolder: "email, username, or phone number")
    
    let passwordTextField: RoundedTextField = {
        let textField = RoundedTextField(placeHolder: "password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: RegisterButton = {
        let button = RegisterButton(type: .system)
        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var moveToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? register here...", for: .normal)
        button.setTitleColor(.rgb(r: 130, g: 144, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleMoveToRegister), for: .touchUpInside)
        return button
    }()

    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.rgb(r: 130, g: 144, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    weak var mainNavigationController: MainNavigationController?

//    lazy var loginPage: LoginPage = {
//        let loginPage = LoginPage()
//        loginPage.delegate = self
//        return loginPage
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        observeKeyBoardNotifications()
        setupGradient()
        setupStackView()
//        setupViews()
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, moveToRegisterButton, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerY()
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func setupViews() {
        
        [emailTextField, passwordTextField, loginButton, moveToRegisterButton].forEach { (view) in
            self.view.addSubview(view)
        }
        
        let verticalSeparationPadding: CGFloat = 15
        
        emailTextField.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                              leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.safeAreaLayoutGuide.trailingAnchor,
                              padding: .init(top: 100, left: 50, bottom: 0, right: 50),
                              size: .init(width: 0, height: 50))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                                 leading: emailTextField.leadingAnchor,
                                 bottom: nil,
                                 trailing: emailTextField.trailingAnchor,
                                 padding: .init(top: verticalSeparationPadding, left: 0, bottom: 0, right: 0),
                                 size: .init(width: 0, height: 50))
        
        loginButton.anchor(top: passwordTextField.bottomAnchor,
                           leading: passwordTextField.leadingAnchor,
                           bottom: nil,
                           trailing: passwordTextField.trailingAnchor,
                           padding: .init(top: verticalSeparationPadding, left: 0, bottom: 0, right: 0),
                           size: .init(width: 0, height: 50))
        
        moveToRegisterButton.anchor(top: loginButton.bottomAnchor,
                                    leading: loginButton.leadingAnchor,
                                    bottom: nil,
                                    trailing: loginButton.trailingAnchor,
                                    padding: .init(top: verticalSeparationPadding, left: 0, bottom: 0, right: 0),
                                    size: .init(width: 0, height: 50))
     
//        loginPage.fillSuperView()
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor.rgb(r: 68, g: 80, b: 95).cgColor
        let bottomColor = UIColor.rgb(r: 49, g: 60, b: 76).cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0, 1]
        
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func observeKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -120 : -50
            
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc private func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func displayLoginError() {
        print("calling login page to display error")
//        loginPage.displayLoginError()
    }

    func finishLoggingIn(with username: String, password: String) {
        ApiService.shared.login(with: username, password: password, delegate: self)
    }
    
    func moveToHome() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            homeViewController.mainNavigationController = self.mainNavigationController
            self.mainNavigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    func finishSignUp() {
        let signupViewController = SignUpViewController()
        signupViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @objc func handleForgotPassword() {
        print("forgot password being Handled")
        
//        let forgotPasswordView = ForgotPasswordView()
//
//        view.addSubview(forgotPasswordView)
//        _ = forgotPasswordView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func cancel() {
        
    }
    
    
    @objc private func handleLogin() {
        print("Logging in")
    }
    
    @objc private func handleMoveToRegister() {
        print("Moving to register screen")
//        let registerViewController = RegisterViewController()
//        registerViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.popViewController(animated: true)
//        self.mainNavigationController?.pushViewController(registerViewController, animated: true)
    }
}


