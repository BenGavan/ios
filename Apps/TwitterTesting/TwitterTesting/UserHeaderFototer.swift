//
//  Cells.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 21/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import LBTAComponents

let twitterBlue = UIColor(r: 61, g: 167, b: 244)

class UserFooter: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Show Me More"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = twitterBlue
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        // To get background of UICollectionview to show between sections, have footer bgcolour as clear then add white view to the footer view behind the textlabel
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        
        addSubview(whiteBackgroundView)
        whiteBackgroundView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(textLabel)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 14, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class UserHeader: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "WHO TO FOLLOW"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(textLabel)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}



