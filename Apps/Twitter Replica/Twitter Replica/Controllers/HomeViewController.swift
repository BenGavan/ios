//
//  HomeViewController.swift
//  Twitter Replica
//
//  Created by Ben Gavan on 13/06/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    // MARK: overides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(collectionView)
        
        collectionView.fillSuperView()
        
    }
    
    
    // MARK: CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
}


class TweetCollectionViewCell: UICollectionViewCell {
    
    private let profileImage: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Here"
        label.backgroundColor = .purple
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@username"
        label.backgroundColor = .purple
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Some reallllyyyyy looooonnngggg text here which could be a maximum of a value which I don't know"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(textLabel)
        
        profileImage.anchor(top: self.topAnchor,
                            leading: self.leadingAnchor,
                            padding: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3),
                            width: 50,
                            height: 50)
        
        nameLabel.anchor(top: self.topAnchor,
                         leading: profileImage.trailingAnchor,
                         padding: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3),
                         height: 30)
        
        usernameLabel.anchor(top: self.topAnchor,
                             leading: nameLabel.trailingAnchor,
                             padding: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3),
                             height: 30)
        
        textLabel.anchor(top: nameLabel.bottomAnchor,
                         leading: nameLabel.leadingAnchor,
                         trailing: self.trailingAnchor,
                         padding: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 3))
        
    }
    
    private func setupBottomStackView() {
        let stackView = UIStackView(arrangedSubviews: <#T##[UIView]#>)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
