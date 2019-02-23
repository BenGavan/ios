//
//  BarCell.swift
//  BarChartLiveStream
//
//  Created by Ben Gavan on 03/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class BarCell: UICollectionViewCell {
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }()
    
    var barHeightContraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(barView)
        
        barHeightContraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightContraint?.isActive = true
        barHeightContraint?.constant = 100
        
//        barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        barView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(Codeer) has not been implemented")
    }
}
