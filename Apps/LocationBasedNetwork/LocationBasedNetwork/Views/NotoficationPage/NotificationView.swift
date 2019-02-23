//
//  NotificationView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 13/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class NotificationView: UIView, UITableViewDelegate, UITableViewDataSource, NotificationPageTopBarDelegate {
    
    private let cellId = "cellId"
    
    var delegate: NotificationPageDelegate?
    
    lazy var topBar: NotificationPageTopBarView = {
        let v = NotificationPageTopBarView()
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 2
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//        cv.backgroundColor = .clear
//        cv.alwaysBounceVertical = true
//        cv.dataSource = self
//        cv.delegate = self
//        cv.isPagingEnabled = true
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        return cv
//    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(NotificationTableViewCell.self, forCellReuseIdentifier: cellId)
        tv.backgroundColor = .white
        tv.tableFooterView = UIView(frame: .zero)
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBack))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(topBar)
//        self.addSubview(collectionView)
        self.addSubview(tableView)
        self.addSubview(backView)
        
        topBar.anchor(top: self.topAnchor,
                      leading: self.leadingAnchor,
                      bottom: nil,
                      trailing: self.trailingAnchor,
                      height: 70)
        
//        collectionView.anchor(top: topBar.bottomAnchor,
//                              leading: self.leadingAnchor,
//                              bottom: backView.topAnchor,
//                              trailing: self.trailingAnchor)
        
        tableView.anchor(top: topBar.bottomAnchor,
                              leading: self.leadingAnchor,
                              bottom: backView.topAnchor,
                              trailing: self.trailingAnchor)
        
        backView.anchor(top: nil,
                        leading: self.leadingAnchor,
                        bottom: self.bottomAnchor,
                        trailing: self.trailingAnchor,
                        height: 50)

    }
    
    func moveToProfile() {
        print("Going to profile")
        delegate?.moveToProfile()
    }
    
    func moveToAddFriends() {
        delegate?.moveToAddFriends()
    }
    
    @objc private func handleBack() {
        print("Going back")
        delegate?.moveNotificationViewBack()
    }
    
//    // MARK: UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NotificationCollectionViewCell else { return UICollectionViewCell() }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: 100)
//    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NotificationTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class NotificationTableViewCell: UITableViewCell {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 35
        //        imageView.layer.borderColor = UIColor.black.cgColor
        //        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Display Name Here"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let startedFollowingYouLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Started following you"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        self.addSubview(displayNameLabel)
        self.addSubview(startedFollowingYouLabel)
        
        profileImageView.anchor(top: self.topAnchor,
                                leading: self.leadingAnchor,
                                bottom: self.bottomAnchor,
                                trailing: nil,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8),
                                width: 70, height: 70)
        
        displayNameLabel.anchor(top: profileImageView.topAnchor,
                                leading: profileImageView.trailingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        startedFollowingYouLabel.anchor(top: displayNameLabel.bottomAnchor,
                                        leading: displayNameLabel.leadingAnchor,
                                        bottom: nil,
                                        trailing: displayNameLabel.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//class NotificationCollectionViewCell: UICollectionViewCell {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    private func setupViews() {
//        self.backgroundColor = .purple
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


