//
//  SettingsTopBar.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 24/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

protocol SettingsTopBarDelegate {
    func back()
}

class SettingsTopBar: UIView {
    
    var delegate: SettingsTopBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        
        let bottomBorder = BorderView()
        
        let backButton = BackButton(type: .custom)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let centerLabel = UILabel()
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.text = "Settings"
        centerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.addSubview(bottomBorder)
        self.addSubview(backButton)
        self.addSubview(centerLabel)
        
        bottomBorder.anchor(top: nil,
                            leading: self.leadingAnchor,
                            bottom: self.bottomAnchor,
                            trailing: self.trailingAnchor,
                            height: 1)
        
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        centerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    @objc private func handleBack() {
        delegate?.back()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
