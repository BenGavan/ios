//
//  SignUpPage.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 19/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class SignUpPage: UIView {
    
    weak var delegate: SignUpControllerDelegate?
    
    let profileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let nameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Name"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .clear
        return textField
    }()
    
    let userNameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Username"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .clear
        return textField
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .clear
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let confirmPasswordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Confirm Password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Finish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(finishSignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.text = "Cancel"
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        label.textColor = .orange
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveToLogin))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(nameTextField)
        self.addSubview(profileImageView)
        self.addSubview(userNameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(confirmPasswordTextField)
        self.addSubview(signUpButton)
        self.addSubview(cancelLabel)
        
        _ = profileImageView.anchor(self.topAnchor, left: nameTextField.rightAnchor, bottom: userNameTextField.topAnchor, right: self.rightAnchor, topConstant: 100, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 110, heightConstant: 0)
        
        _ = nameTextField.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: profileImageView.leftAnchor, topConstant: 100, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = userNameTextField.anchor(nameTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = emailTextField.anchor(userNameTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = confirmPasswordTextField.anchor(passwordTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = signUpButton.anchor(confirmPasswordTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        _ = cancelLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 50, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    @objc private func finishSignUp() {
        print("sign up")
        
        guard var name = nameTextField.text else { return }
        guard var username = userNameTextField.text else { return }
        guard var email = emailTextField.text else { return }
        guard let passwordFirst = passwordTextField.text else { return }
        guard let passwordSecond = confirmPasswordTextField.text else { return }
        
        if name.isEmpty, username.isEmpty, email.isEmpty, passwordFirst.isEmpty, passwordSecond.isEmpty {
            return
        }
        
        if passwordFirst != passwordSecond {
            displayPasswordMismatch()
            return
        }
        
        name = name.lowercased()
        username = username.lowercased()
        email = email.lowercased()

        let profileImage = UIImage(named: "profile_image")
        let password = passwordFirst
        let newUser = NewUser(name: name, userName: username, email: email, password: password, profileImage: profileImage)
        
        delegate?.finishSigningUp(with: newUser)
    }
    
    @objc func moveToLogin() {
        print("Moving back to login")
        delegate?.backToLogin()
    }
    
    private func displayPasswordMismatch() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
