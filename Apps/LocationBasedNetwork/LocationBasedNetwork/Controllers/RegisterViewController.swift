//
//  RegisterViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 13/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

struct Token: Codable {
    let id: String?
    let token: String?
}

struct RegisterResponse: Codable {
    let isUsernameAvailable: Bool?
    let isEmailAvailable: Bool?
    let isPhoneNumberAvailable: Bool?
    let isUserRegistrationSuccessful: Bool?
    let uid: String?
}

class RegisterViewController: UIViewController {
    
    weak var mainNavigationController: MainNavigationController?
    
    private static let inputHeight: CGFloat = 50
    
    let displayNameTextField = RoundedTextField(placeHolder: "display name")
    let usernameTextField = RoundedTextField(placeHolder: "username")
    let emailTextField = RoundedTextField(placeHolder: "email")
    let phoneNumberTextField = RoundedTextField(placeHolder: "phone number")
    
    let passwordTextField: RoundedTextField = {
        let textField = RoundedTextField(placeHolder: "password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let registerButton: RegisterButton = {
        let button = RegisterButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.heightAnchor.constraint(equalToConstant: inputHeight).isActive = true
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .disabled)
        button.setTitleColor(UIColor.black, for: UIControl.State.selected)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var moveToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account?", for: .normal)
        button.setTitleColor(.rgb(r: 130, g: 144, b: 165), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleMoveToLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupStackView()
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
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [displayNameTextField, usernameTextField, emailTextField, phoneNumberTextField, passwordTextField, registerButton, moveToLoginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerY()
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
    }
    
    @objc private func handleRegister() {
        print("registering new user")
        //        signupFor(username: "ben_gavan", password: "password123")
        guard let displayName = displayNameTextField.text,
            let username = usernameTextField.text,
            let email = emailTextField.text,
            let phoneNumber = phoneNumberTextField.text,
            let password = passwordTextField.text
            else { print("Data invalid"); return }
        
        if (displayName == "") || (username == "") || (email == "") || (phoneNumber == "") || (password == "") {
            print("Input Invalid")
            return
        }
        
        
        
        Auth.shared.registerNewUser(displayName: displayName, username: username, email: email, phoneNumber: phoneNumber, password: password, onSuccess: {
            print("Success")
            self.moveToHome()
        }, onFail: { (response) in
            print(response)
            self.showErrorMessages(registerResponse: response)
            })
    }
        
    
    private func showErrorMessages(registerResponse: RegisterResponse) {
        print("Error from registering is:", registerResponse)
    }
    
    private func moveToHome() {
        print("Moving to home")
        DispatchQueue.main.async {
            self.mainNavigationController?.popViewController(animated: true)
            let homeViewController = HomeViewController()
            homeViewController.mainNavigationController = self.mainNavigationController
            self.mainNavigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    @objc private func handleMoveToLogin() {
        print("Moving to login....")
        let loginViewController = LoginViewController()
        loginViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(loginViewController, animated: true)
    }
}


