//
//  MessageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 31/07/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    var friend: Friend? {
        didSet {
            nameLabel.text = friend?.name
            
            if let profileImageName = friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            let message = friend?.messages?.first
            messageLabel.text = message?.text
            
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = Date().timeIntervalSince(date)
                let dayInSeconds: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * dayInSeconds {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elapsedTimeInSeconds > dayInSeconds {
                    dateFormatter.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 34
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "A Friends Message and something else to make this text a little bit longer"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    private let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor(red: 0, green: 134 / 255, blue: 249 / 255, alpha: 1)
                : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            timeLabel.textColor = isHighlighted ? .white : .black
            messageLabel.textColor = isHighlighted ? .white : .black
            
            print(isHighlighted)
        }
    }
    
    override func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(profileImageView)
        self.addSubview(dividerLineView)
        
        setupContainerView()
        
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        profileImageView.set(size: .init(width: 68, height: 68))
        
        dividerLineView.anchor(top: nil,
                               leading: self.leadingAnchor,
                               bottom: self.bottomAnchor,
                               trailing: self.trailingAnchor,
                               leftConstant: 82,
                               height: 1)
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        self.addSubview(containerView)
        
        containerView.anchor(top: self.topAnchor,
                             leading: profileImageView.trailingAnchor,
                             bottom: dividerLineView.topAnchor,
                             trailing: self.trailingAnchor,
                             padding: .init(top: 20, left: 10, bottom: 20, right: 5))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        nameLabel.anchor(top: containerView.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: nil,
                         trailing: timeLabel.leadingAnchor,
                         rightConstant: 8,
                         height: 30)
        
        timeLabel.anchor(top: nameLabel.topAnchor,
                         leading: nil, bottom: nil,
                         trailing: containerView.trailingAnchor,
                         rightConstant: 12,
                         size: .init(width: 80, height: 30))
        
        messageLabel.anchor(top: nameLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: containerView.bottomAnchor,
                            trailing: hasReadImageView.leadingAnchor,
                            rightConstant: 12)
        
        hasReadImageView.anchor(top: timeLabel.bottomAnchor,
                                leading: nil, bottom: nil,
                                trailing: containerView.trailingAnchor,
                                padding: .init(top: 8, left: 8, bottom: 8, right: 8),
                                size: .init(width: 20, height: 20))
    }
}
