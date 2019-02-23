//
//  VideoCell.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 10/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

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

class VideoCell: UICollectionViewCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                
                let subTitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews as NSNumber)!) •  2 years"
                subtitleTextView.text = subTitleText
            }
            
            // measure titile label
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }

            }
            
        }
    }
    
    private func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsing(urlString: thumbnailImageUrl)
        }
    }
    
    private func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsing(urlString: profileImageUrl)
        } else {
            print("profileImage: Not Retrieved")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Black Space"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO • 1,683,123,123 • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.backgroundColor = .clear
        return textView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    func setupViews() {
        self.addSubview(thumbnailImageView)
        self.addSubview(userProfileImageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleTextView)
        self.addSubview(seperatorView)
        
        _ = thumbnailImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: userProfileImageView.topAnchor, right: self.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        _ = userProfileImageView.anchor(thumbnailImageView.bottomAnchor, left: self.leftAnchor, bottom: seperatorView.topAnchor, right: nil, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 44, heightConstant: 44)
        
        titleLabelHeightConstraint = titleLabel.anchor(thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 4, rightConstant: 16, widthConstant: 0, heightConstant: 44).last
        
        _ = subtitleTextView.anchor(titleLabel.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 2, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 30)
        
        _ = seperatorView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Failed to implement init()")
    }
}
