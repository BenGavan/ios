//
//  MomentCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 15/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class MomentCell: UICollectionViewCell {
    
    let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reply").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let directMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send_message").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Some Sample text"
        textView.backgroundColor = .clear
        return textView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init() was not implemented")
    }
    
    var moment: Moment? {
        didSet{
            messageTextView.text = moment?.text
            
            
        }
    }
    
    private func setUpProfileImage() {
        if let thumbnailImageUrl = moment?.user?.profileImageUrl {
            
            let url = URL(string: thumbnailImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async( execute: {
                    self.profileImageView.image = UIImage(data: data!)
                })
            }).resume()
        }
    }
    
    private func setUpVideo() {
        
    }
    
    private func setUpPicture() {
        
    }
    
    func setupViews() {
//
//        separatorLineView.isHidden = false
//        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        addSubview(messageTextView)
        
        _ = profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        _ = messageTextView.anchor(self.topAnchor, left: profileImageView.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupBottomButtons()
    }
    
    private func setupBottomButtons() {
        let replyButtonContainerView = UIView()
        replyButtonContainerView.backgroundColor = .white
        
        let retweetButtonContainerView = UIView()
        retweetButtonContainerView.backgroundColor = .white
        
        let likeButtonContainerView = UIView()
        likeButtonContainerView.backgroundColor = .white
        
        let directMessageButtonContainerView = UIView()
        directMessageButtonContainerView.backgroundColor = .white
        
        let buttonStackView = UIStackView(arrangedSubviews: [replyButtonContainerView, retweetButtonContainerView, likeButtonContainerView, directMessageButtonContainerView])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        _ = buttonStackView.anchor(nil, left: messageTextView.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        addSubview(replyButton)
        addSubview(retweetButton)
        addSubview(likeButton)
        addSubview(directMessageButton)
        
        _ = replyButton.anchor(replyButtonContainerView.topAnchor, left: replyButtonContainerView.leftAnchor, bottom: replyButtonContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        _ = retweetButton.anchor(retweetButtonContainerView.topAnchor, left: retweetButtonContainerView.leftAnchor, bottom: retweetButtonContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        _ = likeButton.anchor(likeButtonContainerView.topAnchor, left: likeButtonContainerView.leftAnchor, bottom: likeButtonContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        _ = directMessageButton.anchor(directMessageButtonContainerView.topAnchor, left: directMessageButtonContainerView.leftAnchor, bottom: directMessageButtonContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
    }
}

