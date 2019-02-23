//
//  CameraPageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 01/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class CameraPageCell: UICollectionViewCell {
    
    var mainNavigationController: MainNavigationController?
    
    let noCameraLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Camera"
        label.textAlignment = .center
        //        label.font = label.font.withSize(12)
        label.textColor = .black
        label.alpha = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(noCameraLabel)
        noCameraLabel.anchor(top: self.topAnchor,
                             leading: self.leadingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             topConstant: 50,
                             height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
