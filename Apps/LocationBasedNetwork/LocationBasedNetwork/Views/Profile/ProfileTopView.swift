//
//  ProfileTopView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 24/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

protocol ProfileTopViewDelegate {
    func moveToPosts()
    func moveToFollowers()
    func moveToFollowing()
    func profileImageTouched()
}

class ProfileTopView: UIView {
    
    var delegate: ProfileTopViewDelegate?
    
    var user: User? {
        didSet {
            displayNameLabel.text = user?.displayName
            usernameLabel.text = user?.username
            followingLabel.value = user?.numberFollowing ?? 0
            followersLabel.value = user?.numberOfFollowers ?? 0
            postsLabel.value = user?.numberOfPosts ?? 0
        }
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 35
        //        imageView.layer.borderColor = UIColor.black.cgColor
        //        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap)))
        return imageView
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
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "There should be some descriptive text here that the user can set and should extend this test text so it wraps to more lines and now test if it dot dot dots"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .borderColor
        label.numberOfLines = 3
        label.backgroundColor = .red
        return label
    }()

//    private let bioLabel: UIView = {
//        let v = UIView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .yellow
//        return v
//    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleFollow), for: .touchUpInside)
        button.alpha = 1
        return button
    }()
    
    private let statsContainerView = UIView()
    
    private let followingLabel = TextWithValueLabel(text: "Following", value: 696)
    private let followersLabel = TextWithValueLabel(text: "Followers", value: 321)
    private let postsLabel = TextWithValueLabel(text: "Posts", value: 123)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    private func setupViews() {
        let bottomBorderView = BorderView()
        let topBorderView = BorderView()
        
        statsContainerView.translatesAutoresizingMaskIntoConstraints = false
        statsContainerView.backgroundColor = .purple
        
        [bottomBorderView, topBorderView, statsContainerView, profileImageView, displayNameLabel, bioLabel].forEach { (view) in
            self.addSubview(view)
        }
        
        topBorderView.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             height: 1)
        
        bottomBorderView.anchor(top: nil,
                                leading: self.leadingAnchor,
                                bottom: self.bottomAnchor,
                                trailing: self.trailingAnchor,
                                height: 1)
        
        profileImageView.anchor(top: self.topAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8),
                                width: 70, height: 70)
        
        statsContainerView.anchor(top: self.topAnchor,
                                  leading: profileImageView.trailingAnchor,
                                  bottom: nil,
                                  trailing: self.trailingAnchor,
                                  padding: .init(top: 8, left: 8, bottom: 8, right: 8),
                                  height: 100)
        
        displayNameLabel.anchor(top: statsContainerView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: nil,
                                padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        bioLabel.anchor(top: displayNameLabel.bottomAnchor,
                        leading: self.leadingAnchor,
                        bottom: nil,
                        trailing: self.trailingAnchor,
                        padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        setupStatsContainerView()
    }
    
    private func setupStatsContainerView() {
        postsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePostsLabelTap)))
        followersLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFollowersLabelTap)))
        followingLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFollowingLabelLabelTap)))
    
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followingLabel, followersLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.top
        stackView.isExclusiveTouch = false
        stackView.isMultipleTouchEnabled = true
        
        statsContainerView.addSubview(stackView)
        
        stackView.anchor(top: statsContainerView.topAnchor, leading: statsContainerView.leadingAnchor, bottom: nil, trailing: statsContainerView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    @objc private func handleFollow() {
        print("Follow")
    }
    
    @objc private func handlePostsLabelTap() {
        delegate?.moveToPosts()
    }
    
    @objc private func handleFollowersLabelTap() {
        delegate?.moveToFollowers()
    }
    
    @objc private func handleFollowingLabelLabelTap() {
        delegate?.moveToFollowing()
    }
    
    @objc private func handleProfileImageTap() {
        delegate?.profileImageTouched()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

















