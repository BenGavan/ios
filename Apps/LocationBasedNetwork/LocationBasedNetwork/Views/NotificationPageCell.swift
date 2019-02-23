//
//  NotificationPageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 18/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class NotificationPageCell: UICollectionViewCell {
    
    var mainNavigationController: MainNavigationController?
    
    let noNotificationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Notifications"
        label.textAlignment = .center
//        label.font = label.font.withSize(12)
        label.textColor = .black
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(noNotificationsLabel)
        noNotificationsLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
