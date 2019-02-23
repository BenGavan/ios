//
//  NewMomentView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 27/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit


class NewMomentView: UIView {
    
    let newMomentTextBody: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text Here..."
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .twitter
        return textField
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(postMoment), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(cancelMoment), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(newMomentTextBody)
        self.addSubview(postButton)
        self.addSubview(cancelButton)
        
        postButton.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 70, height: 0))
        
        cancelButton.anchor(top: postButton.bottomAnchor, leading: postButton.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        
        newMomentTextBody.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: postButton.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init() was not implemented")
    }
}


extension NewMomentView {
    @objc func postMoment() {
        print("posting")
        
        guard let momentText = newMomentTextBody.text else { return }
        
        if momentText.utf8CString.count > 0 {
            ApiService.shared.postMoment(with: momentText)
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelMoment() {
        print("cancel")
        self.removeFromSuperview()
    }
}
