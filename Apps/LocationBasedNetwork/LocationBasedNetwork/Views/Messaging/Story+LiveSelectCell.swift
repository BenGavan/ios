//
//  Story+LiveSelectCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 31/07/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class StoryLiveSelectCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 35
        //        imageView.layer.borderColor = UIColor.black.cgColor
        //        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .red
        
        self.addSubview(collectionView)
        collectionView.fillSuperView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
