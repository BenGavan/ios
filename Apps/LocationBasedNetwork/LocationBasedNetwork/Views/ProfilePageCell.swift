//
//  ProfilePageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 25/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ProfilePageCell: UICollectionViewCell {
    
    var mainNavigationController: MainNavigationController?
    
    let topView: TopView = {
        let view = TopView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(topView)
        
        _ = topView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopView: UIView {
    
//    let profileImageView: UIImageView = {
//        let image = UIImage(named: "profile_image")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
    
    let profileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let numberOfFollowersLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        return label
    }()
    
    let numberOfFollowingLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ben Gavan"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "ben_gavan"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(profileImageView)
        
        _ = profileImageView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 50, heightConstant: 50)
//        NSLayoutConstraint(item: profileImageView, attribute: .centerX, relatedBy: .equal, toItem: nil, attribute: .centerX, multiplier: 0, constant: 0).isActive = true
        
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
