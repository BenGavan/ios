//
//  AddFriendCollectionViewCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 23/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class AddFriendCollectionViewCell: UICollectionViewCell {
    
    var delegate: AddFriendCollectionViewCellDelegate?
    
    var user: User? {
        didSet {
            displayNameLabel.text = user?.displayName ?? user?.username ?? "Display Name"
            usernameLabel.text = user?.username
            if let uid = user?.uid {
                addButton.alpha = uid == Auth.shared.getUID() ? 0 : 1
            }
            if let amFollowing = user?.amFollowing {
                print("amFollowing:", amFollowing)
                let addButtonTitle = amFollowing ? "Following" : "Add"
                addButton.setTitle(addButtonTitle, for: .normal)
            }
        }
    }
    
    private let profileImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Display Name Here"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "Username_Here"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .borderColor
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        button.alpha = 1
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        let bottomBorder = BorderView()
        
        self.addSubview(bottomBorder)
        self.addSubview(profileImageView)
        self.addSubview(displayNameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(addButton)
        
        self.backgroundColor = .white
        
        bottomBorder.anchor(top: nil,
                            leading: self.leadingAnchor,
                            bottom: self.bottomAnchor,
                            trailing: self.trailingAnchor,
                            height: 1)
        
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        profileImageView.setWidth(60)
        profileImageView.setHeight(60)
        
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        addButton.setWidth(100)
        
        displayNameLabel.anchor(top: profileImageView.topAnchor,
                                leading: profileImageView.trailingAnchor,
                                bottom: nil,
                                trailing: addButton.leadingAnchor,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 4).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc private func handleAdd() {
        print("Adding")
        guard let unWrappedUser = user else { return }
        if unWrappedUser.amFollowing == true {
            delegate?.unFollow(user: unWrappedUser)
            addButton.setTitle("Add", for: .normal)
            user?.amFollowing = false
        } else {
            delegate?.follow(user: unWrappedUser)
            addButton.setTitle("Following", for: .normal)
            user?.amFollowing = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








