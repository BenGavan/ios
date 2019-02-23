////
////  LoginCell.swift
////  LocationBasedNetwork
////
////  Created by Ben Gavan on 14/10/2017.
////  Copyright © 2017 Ben Gavan. All rights reserved.
////
//
//import UIKit
//
//class LoginPage: UICollectionViewCell {
//    
//    let logoImageView: UIImageView = {
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
//    
//    let emailTextField: LeftPaddedTextField = {
//        let textField = LeftPaddedTextField()
//        textField.placeholder = "Enter Email"
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.borderWidth = 1
//        textField.keyboardType = .emailAddress
//        return textField
//    }()
//    
//    let passwordTextField: LeftPaddedTextField = {
//        let textField = LeftPaddedTextField()
//        textField.placeholder = "Enter Password"
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.borderWidth = 1
//        textField.isSecureTextEntry = true
//        return textField
//    }()
//    
//    lazy var loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .orange
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        return button
//    }()
//    
//    lazy var signUpButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .orange
//        button.setTitle("Sign up", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
//        return button
//    }()
//    
//    lazy var forgotPasswordTextField: UILabel = {
//        let label = UILabel()
//        label.text = "Forgot Password?"
//        label.textAlignment = .center
//        label.font = label.font.withSize(12)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPassword))
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(tap)
//        return label
//    }()
//    
//    lazy var invalidUsernameAndPasswordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Please enter Valid Username and Password"
//        label.textAlignment = .center
//        label.font = label.font.withSize(12)
//        label.textColor = .red
//        label.alpha = 0
//        return label
//    }()
//    
//    weak var delegate: LoginControllerDelegate?
//    
//    @objc func handleLogin() {
//        if let username = emailTextField.text, let password = passwordTextField.text {
//            if username.count > 0, password.count > 0 {
//                print("Email: \(username) and PassWord: \(password)")
//                delegate?.finishLoggingIn(with: username, password: password)
//            } else {
//                print("Please enter username and password")
//                invalidUsernameAndPasswordLabel.alpha = 1
//            }
//        } else {
//            print("username and password required required")
//            return
//        }
//    }
//    
//    @objc func handleSignUp() {
//        print("sign up")
//        delegate?.finishSignUp()
//    }
//    
//    @objc func forgotPassword() {
//        print("forgot password")
//        delegate?.forgotPassword()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.addSubview(logoImageView)
//        self.addSubview(emailTextField)
//        self.addSubview(passwordTextField)
//        self.addSubview(loginButton)
//        self.addSubview(signUpButton)
//        self.addSubview(invalidUsernameAndPasswordLabel)
//        self.addSubview(forgotPasswordTextField)
//        
//        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
//        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        
//        _ = emailTextField.anchor(logoImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = signUpButton.anchor(loginButton.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = forgotPasswordTextField.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
//        
//        _ = invalidUsernameAndPasswordLabel.anchor(nil, left: emailTextField.leftAnchor, bottom: emailTextField.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//    }
//    
//    func invalidCredentials() {
//        invalidUsernameAndPasswordLabel.alpha = 1
//    }
//    
//    func displayLoginError() {
//        print("displaying invalid username or password warning")
//        
//        DispatchQueue.main.async {
//            self.invalidUsernameAndPasswordLabel.alpha = 1
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//class ForgotPasswordView: UIView {
//    
//    let logoImageView: UIImageView = {
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
//    
//    let emailTextField: LeftPaddedTextField = {
//        let textField = LeftPaddedTextField()
//        textField.placeholder = "Enter Email"
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.borderWidth = 1
//        textField.keyboardType = .emailAddress
//        return textField
//    }()
//    
//    lazy var sendCodeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .orange
//        button.setTitle("Send Code", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(sendResetPasswordCode), for: .touchUpInside)
//        return button
//    }()
//    
//    lazy var cancelLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Cancel"
//        label.textAlignment = .center
//        label.font = label.font.withSize(12)
//        label.textColor = .orange
//        let tap = UITapGestureRecognizer(target: self, action: #selector(cancel))
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(tap)
//        return label
//    }()
//    
//    weak var delegate: LoginControllerDelegate?
//
//    func setupViews() {
//        self.backgroundColor = .white
//
//        self.addSubview(logoImageView)
//        self.addSubview(emailTextField)
//        self.addSubview(sendCodeButton)
//        self.addSubview(cancelLabel)
//        
//        _ = logoImageView.anchor(self.centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
//        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//
//        
//        _ = emailTextField.anchor(logoImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = sendCodeButton.anchor(emailTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = cancelLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 50, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    @objc func sendResetPasswordCode() {
//        print("send reset code")
//    }
//    
//    @objc func cancel() {
//        delegate?.cancel()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class ForgotPasswordEnterCodeView: UIView {
//    
//    let logoImageView: UIImageView = {
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
//    
//    let codeTextField: LeftPaddedTextField = {
//        let textField = LeftPaddedTextField()
//        textField.placeholder = "Enter Code"
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.borderWidth = 1
//        textField.keyboardType = .emailAddress
//        return textField
//    }()
//    
//    lazy var submitButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .orange
//        button.setTitle("Reset Password", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(resetPasswordCode), for: .touchUpInside)
//        return button
//    }()
//    
//    weak var delegate: LoginControllerDelegate?
//    
//    func setupViews() {
//        self.backgroundColor = .white
//        
//        self.addSubview(logoImageView)
//        self.addSubview(codeTextField)
//        self.addSubview(submitButton)
//        
//        _ = logoImageView.anchor(self.centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
//        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        
//        
//        _ = codeTextField.anchor(logoImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//        
//        _ = submitButton.anchor(codeTextField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    @objc func resetPasswordCode() {
//        print("validating code and then redirrect to new password screen")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
