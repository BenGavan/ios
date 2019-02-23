//
//  ViewController.swift
//  fbMessenger
//
//  Created by Ben Gavan on 25/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class FriendsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupdata()
        
        navigationItem.title = "Recent"
        collectionView?.backgroundColor = .white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        let message = messages[indexPath.item]
        cell.message = message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
}

class MessageCell: BaseCell {

    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "A Friends Message and something else to make this text a little bit longer"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        self.addSubview(dividerLineView)
        
        setupContainerView()
        
        _ = profileImageView.anchor(nil, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 68, heightConstant: 68)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        _ = dividerLineView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 82, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        self.addSubview(containerView)
        
        _ = containerView.anchor(self.topAnchor, left: profileImageView.rightAnchor, bottom: dividerLineView.topAnchor, right: self.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 20, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        _ = nameLabel.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nameLabel.topAnchor, right: timeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 30)
        
        _ = timeLabel.anchor(nameLabel.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 80, heightConstant: 30)
        
        _ = messageLabel.anchor(nameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: hasReadImageView.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        _ = hasReadImageView.anchor(timeLabel.bottomAnchor, left: messageLabel.rightAnchor, bottom: messageLabel.bottomAnchor, right: containerView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 20, heightConstant: 20)
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
        self.backgroundColor = .blue
    }
}

