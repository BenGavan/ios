//
//  NotificationPageTopBarView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 13/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

protocol NotificationPageTopBarDelegate {
    func moveToProfile()
    func moveToAddFriends()
}

class NotificationPageTopBarView: UIView {
    
    var delegate: NotificationPageTopBarDelegate?
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleProfileTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Friends", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleAddFriendsTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        
        self.addSubview(containerView)
        self.addSubview(dividerLineView)
        
        dividerLineView.anchor(top: nil,
                               leading: self.leadingAnchor,
                               bottom: self.bottomAnchor,
                               trailing: self.trailingAnchor,
                               height: 1)
        
        
        containerView.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             bottom: dividerLineView.topAnchor,
                             trailing: self.trailingAnchor)
    }
    
    private func setupContainerView() {
        containerView.addSubview(profileButton)
        containerView.addSubview(notificationLabel)
        containerView.addSubview(addFriendsButton)
        
        profileButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        profileButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        
        notificationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        notificationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        
        addFriendsButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        addFriendsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
    }
    
    @objc private func handleProfileTap() {
        print("Moving to profile....")
        delegate?.moveToProfile()
    }
    
    @objc private func handleAddFriendsTap() {
        print("Moving to friend search...")
        delegate?.moveToAddFriends()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
