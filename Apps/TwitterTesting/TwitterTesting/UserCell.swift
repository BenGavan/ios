//
//  UserCell.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 22/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import LBTAComponents

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let user = datasourceItem as? User else { return }
            nameLabel.text = user.name
            userNameLabel.text = user.userName
            bioTextView.text = user.bioText            
            profileImageView.loadImage(urlString: user.profileImageURL)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ben Gavan"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let profileImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ben_gavan"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "CEO and Founder of a company which doesn't exist yet"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .clear
        return textView
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(userNameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        userNameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bioTextView.anchor(userNameLabel.bottomAnchor, left: userNameLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: -4, leftConstant: -4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        followButton.anchor(self.topAnchor, left: nil, bottom:nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
    }
}
