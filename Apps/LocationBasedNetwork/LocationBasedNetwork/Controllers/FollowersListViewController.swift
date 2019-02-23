//
//  FollowersListViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 25/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class FollowersListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate,FollowersListTopBarDelegate {
    
    weak var mainNavigationController: MainNavigationController?
    
    private let cellId = "cellId"
    
    private var followers: [Follow]? = [Follow]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if let count = self.followers?.count {
                    self.noFollowersLabel.alpha = count <= 0 ? 1 : 0
                }
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FollowersListCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let noFollowersLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Followers to Show"
        label.alpha = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        let topBar = FollowersListTopBar()
        topBar.delegate = self
        
        self.view.addSubview(topBar)
        self.view.addSubview(noFollowersLabel)
        self.view.addSubview(collectionView)
        
        noFollowersLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 50).isActive = true
        noFollowersLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        collectionView.anchor(top: topBar.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: self.view.trailingAnchor)
    }
    
    private func setupData() {
        ApiService.shared.fetchFollowersForCurrentUser { (followers) in
            self.followers = followers
        }
    }
    
    func back() {
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    // MARK: UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FollowersListCollectionViewCell else { return UICollectionViewCell() }
        cell.follow = followers?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return users.count
        if let count = followers?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
}


class FollowersListCollectionViewCell: UICollectionViewCell {
    
    var follow: Follow? {
        didSet {
            displayNameLabel.text = follow?.user?.displayName ?? follow?.user?.username ?? "Display Name"
            usernameLabel.text = follow?.user?.username
//            if let uid = follow?.user?.uid {
//                addButton.alpha = uid == Auth.shared.getUID() ? 0 : 1
//            }
//            if let amFollowing = follow?.user?.amFollowing {
//                print("amFollowing:", amFollowing)
//                let addButtonTitle = amFollowing ? "Following" : "Add"
//                addButton.setTitle(addButtonTitle, for: .normal)
//            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        setupViews()
    }
    
    private lazy var profileImageView: UIView = {
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
    
    private func setupViews() {
        let bottomBorder = BorderView()
        
        let followingView = UIView()
        followingView.translatesAutoresizingMaskIntoConstraints = false
        followingView.backgroundColor = .purple

        self.addSubview(bottomBorder)
        self.addSubview(profileImageView)
        self.addSubview(displayNameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(followingView)
        
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
        
        followingView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        followingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        followingView.setWidth(100)
        followingView.setHeight(50)
        
        displayNameLabel.anchor(top: profileImageView.topAnchor,
                                leading: profileImageView.trailingAnchor,
                                bottom: nil,
                                trailing: followingView.leadingAnchor,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 4).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: followingView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
