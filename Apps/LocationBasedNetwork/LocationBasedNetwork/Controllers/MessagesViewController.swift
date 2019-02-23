//
//  MessagesViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 26/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        cv.backgroundColor = .white
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.alwaysBounceVertical = true
        return cv
    }()
    
//    var messages = [Message]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupdata()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return messages.count
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
//        let message = messages[indexPath.item]
//        cell.message = message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let layout = UICollectionViewFlowLayout()
//        let controller = ChatLogController(collectionViewLayout: layout)
//        controller.friend = messages[indexPath.item].friend
//        navigationController?.pushViewController(controller, animated: true)
//    }
}
