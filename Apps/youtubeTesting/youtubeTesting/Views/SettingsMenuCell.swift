//
//  SettingsCell.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 29/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class SettingsMenuCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var setting: Setting? {
        didSet {
            if let imageName = setting?.imageName, let name = setting?.name {
                nameLabel.text = name.rawValue
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(nameLabel)
        self.addSubview(iconImageView)
        
        _ = iconImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 30, heightConstant: 30)
        
        _ = nameLabel.anchor(self.topAnchor, left: self.iconImageView.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
}
