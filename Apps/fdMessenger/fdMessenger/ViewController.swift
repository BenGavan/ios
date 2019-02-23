//
//  ViewController.swift
//  fdMessenger
//
//  Created by Ben Gavan on 09/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
        
    }

}



class FriendCell: BaseCell {
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.blue
        
        addSubview(profileImageView)
        
        addConstraint(NSLayoutConstraint.constraints(withVisualFormat: "M:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
        addConstraint(NSLayoutConstraint.constraints(withVisualFormat: "M:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
    }
    
    
    
}

class BaseCell: UICollectionViewCell {
     override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }
}

