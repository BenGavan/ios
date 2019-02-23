//
//  ProfileTopBar.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 24/08/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

protocol ProfileTopBarDelegate {
    func back()
    func moveToSettings()
}

class ProfileTopBar: UIView {
    
    var delegate: ProfileTopBarDelegate?
    
    var username: String? {
        didSet {
            displayNameLabel.text = username
        }
    }
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username Here"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let bottomBorder = BorderView()
        
        let backButton = BackButton(type: .custom)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let settingsButton = SettingsButton(type: .custom)
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        self.addSubview(bottomBorder)
        self.addSubview(backButton)
        self.addSubview(displayNameLabel)
        self.addSubview(settingsButton)
        
        bottomBorder.anchor(top: nil,
                            leading: self.leadingAnchor,
                            bottom: self.bottomAnchor,
                            trailing: self.trailingAnchor,
                            height: 1)
        
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        displayNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        displayNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        settingsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    override func didMoveToSuperview() {
        self.anchor(top: self.superview?.safeAreaLayoutGuide.topAnchor,
                    leading: self.superview?.leadingAnchor,
                    bottom: nil,
                    trailing: self.superview?.trailingAnchor)
    }
    
    @objc private func handleBack() {
        delegate?.back()
    }
    
    @objc private func handleSettings() {
        delegate?.moveToSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
