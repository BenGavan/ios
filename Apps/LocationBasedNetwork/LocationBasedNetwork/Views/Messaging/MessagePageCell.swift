//
//  MessagePageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 25/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

extension MessagePageCell {
    
    private func setupData() {
        let message1 = Message(text: "Hi, How are you today", date: Date(), isSentFromThisAccount: true, isSeen: true, isSent: true)
        let message2 = Message(text: "I'm good thanks", date: Date(), isSentFromThisAccount: false, isSeen: true, isSent: false)
        
        let messages1 = [message1, message2]
        
        let friend1 = Friend(name: "Friend1", profileImageName: "profile_image", messages: messages1)
        
        friends = [friend1]
    }
}



class MessagePageCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var mainNavigationController: MainNavigationController?
    
    private let messageCellId = "messageCellId"
    private let storyLiveSelectCellId = "storyLiveSelectCellId"
    
    var friends: [Friend]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MessageCell.self, forCellWithReuseIdentifier: messageCellId)
        cv.register(StoryLiveSelectCell.self, forCellWithReuseIdentifier: storyLiveSelectCellId)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupData()
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .red

        self.addSubview(collectionView)
    
        collectionView.anchor(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: self.bottomAnchor,
                              trailing: self.trailingAnchor,
                              topConstant: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = friends?.count {
            return count + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let messageIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyLiveSelectCellId, for: indexPath) as? StoryLiveSelectCell else { return UICollectionViewCell() }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageCellId, for: indexPath) as! MessageCell
        cell.friend = friends?[messageIndex]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row - 1
        let chatViewController = ChatViewController()
        mainNavigationController?.pushViewController(chatViewController, animated: true)
        mainNavigationController?.isNavigationBarHidden = false
        chatViewController.friend = friends?[index]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





