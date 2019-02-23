//
//  AddFriendViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 20/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

protocol AddFriendCollectionViewCellDelegate {
    func follow(user: User)
    func unFollow(user: User)
}

class AddFriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddFriendCollectionViewCellDelegate {
    
    private let TAG = "AddFriendViewController"
    
    weak var mainNavigationController: MainNavigationController?

    let cellId = "cellId"
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "username"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(usernameTextFieldEditingDidChange), for: UIControl.Event.editingChanged)
        return textField
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.alpha = 1
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(AddFriendCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupViews()
    }
    
    var users: [User]?
    
    private func setupViews() {
        let borderView = BorderView()
    
        self.view.addSubview(borderView)
        self.view.addSubview(backButton)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(collectionView)
        
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        backButton.centerYAnchor.constraint(equalTo: usernameTextField.centerYAnchor).isActive = true
        backButton.setWidth(40)
        
        usernameTextField.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                 leading: backButton.trailingAnchor,
                                 bottom: nil,
                                 trailing: self.view.trailingAnchor,
                                 padding: .init(top: 8, left: 8, bottom: 8, right: 8),
                                 height: 50)
        
        borderView.anchor(top: usernameTextField.bottomAnchor,
                          leading: self.view.leadingAnchor,
                          bottom: nil,
                          trailing: self.view.trailingAnchor,
                          topConstant: 8,
                          height: 1)
        
        collectionView.anchor(top: borderView.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: self.view.bottomAnchor,
                              trailing: self.view.trailingAnchor)
    }
    
    @objc func usernameTextFieldEditingDidChange() {
        guard let username = usernameTextField.text?.lowercased() else { return }
        print(TAG, "username: \(username)")
        ApiService.shared.getUserInfoFor(username: username) { (user) in
            if let user = user {
                if user.uid != "" {
                    if user.username != username {
                        return
                    }
                    self.users = [user]
                } else {
                    self.users = nil
                }
            } else {
                self.users = nil
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func handleBack() {
        print("Moving back")
        self.mainNavigationController?.popViewController(animated: true)
    }
    
    // MARK: UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = users?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Custom height")
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AddFriendCollectionViewCell else { return UICollectionViewCell() }
        cell.user = users?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    // MARK: AddFriendCollectionViewDelegate
    func follow(user: User) {
        print("Adding:", user)
        guard let uid = user.uid else { return }
        ApiService.shared.follow(uid: uid) { (uid, isSuccess) in
            print(uid, isSuccess)
        }
    }
    
    func unFollow(user: User) {
        print("un-following:", user)
        guard let uid = user.uid else { return }
        ApiService.shared.unFollow(uid: uid) { (uid, isSuccessful) in
            print("Unfollowing", uid, "isSuccessful:", isSuccessful)
        }
    }
}








