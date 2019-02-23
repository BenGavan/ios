//
//  TopMenuBar.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 14/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//


import UIKit

class TopMenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 32)
        cv.backgroundColor = .white
        cv.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.borderColor
        return view
    }()
    
    let cellId = "cellId"
//    let imageNames = ["messages", "location_pin", "notification_icon",  "account"]
    let imageNames = ["messages", "location_pin", "account"]
    let header = ["Chat", "People", "Search","Profile"]
    
    var homeViewController: HomeViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(collectionView)
        addSubview(bottomBorder)
        
        bottomBorder.anchor(top: collectionView.bottomAnchor,
                            leading: self.leadingAnchor,
                            bottom: self.bottomAnchor,
                            trailing: self.trailingAnchor,
                            height: 1)
        
        collectionView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: bottomBorder.topAnchor,
                              trailing: self.trailingAnchor)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
//        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        cell.tintColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / CGFloat(imageNames.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        homeViewController?.scrollTo(menuIndex: index)

        switch index {
        case 0:
            print("Scrolling to messages....")
        case 1:
            print("Scrolling to map....")
        case 2:
            print("Scrolling to Camera....")
        default:
            print("Someting went wrong :(")
        }
        
//        switch index {
//        case 0:
//            print("Scrolling to messages....")
//        case 1:
//            print("Scrolling to map....")
//        case 2:
//            print("Starting notifications...")
//        case 3:
//            print("Scrolling to Profile....")
//        default:
//            print("Someting went wrong :(")
//        }
        

//        if index != 2 {
//            if index == 3 {
//                index -= 1
//            }
//            homeViewController?.scrollTo(menuIndex: index)
//        } else {
//            print("Searching")
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init() was not implemented")
    }
}


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Failed to implement init()")
    }
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .orange : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .orange : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        imageView.set(width: 30, height: 30)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}















