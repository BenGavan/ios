//
//  CategoryCell.swift
//  appstore1
//
//  Created by Ben Gavan on 17/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var appCategory: AppCategory? {
        didSet {
            guard let name = appCategory?.name else { return }
            nameLabel.text = name
        }
    }
    
    lazy var appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.addSubview(appCollectionView)
        self.addSubview(dividerLineView)
        self.addSubview(nameLabel)
        
        _ = nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: appCollectionView.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        _ = appCollectionView.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: dividerLineView.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = dividerLineView.anchor(appCollectionView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AppCell: UICollectionViewCell {
    
    var app: App? {
        didSet {
            guard let name = app?.Name else { return }
            nameLabel.text = name
            
            guard let category = app?.Category else { return }
            categoryLabel.text = category
            
            guard let price = app?.Price else {
                priceLabel.text = ""
                return
            }
            priceLabel.text = "£\(price)"
            
            guard let imageName = app?.ImageName else { return }
            imageView.image = UIImage(named: imageName)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(named: "frozen")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "£3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(categoryLabel)
        self.addSubview(priceLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        nameLabel.frame = CGRect(x: 0, y: self.frame.width + 2, width: self.frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: self.frame.width + 38, width: self.frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: self.frame.width + 56, width: self.frame.width, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













