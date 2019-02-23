//
//  UserCell.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 11/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nedstark")
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImageView)
        
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: (textLabel?.frame.origin.y)! - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64, y: (detailTextLabel?.frame.origin.y)! + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
