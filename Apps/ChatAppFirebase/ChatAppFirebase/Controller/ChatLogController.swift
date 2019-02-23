//
//  ChatLogController.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 11/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {
    
    var user: UserData? {
        didSet {
            self.navigationItem.title = user?.name
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        setupInputComponents()
    }
    
    private func setupInputComponents() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        
        self.view.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(sendButton)
        
        sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        
        inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(separatorLineView)
        
        separatorLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc private func handleSend() {
        print(inputTextField.text as Any)
        guard let inputText = inputTextField.text else { return }
        guard let userId = user?.id else { return }
        
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        
        let toId = userId
        let fromId = Auth.auth().currentUser?.uid
        let timeStamp = String(Int(NSDate().timeIntervalSince1970))
        let values = ["text": inputText, "toId": toId, "fromId": fromId, "timestamp": timeStamp]
        childRef.updateChildValues(values)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
}
