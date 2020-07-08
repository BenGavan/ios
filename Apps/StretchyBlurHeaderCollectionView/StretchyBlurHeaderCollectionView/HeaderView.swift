//
//  HeaderView.swift
//  StretchyBlurHeaderCollectionView
//
//  Created by Ben Gavan on 13/07/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    var animator: UIViewPropertyAnimator?
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "stretchy_header"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        self.addSubview(imageView)
        imageView.fillSuperview()
        
        setupVisualEffectBlur()
        setupGradientLayer()
        setupLabels()
    }
    
    private func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: { [weak self] in
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectBlurView = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffectBlurView)
            visualEffectBlurView.fillSuperview()
        })
        animator?.fractionComplete = 0
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        let gradientContainerView = UIView()
        self.addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil,
                                     leading: self.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: self.trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= self.bounds.height
    }
    
    private func setupLabels() {
        let heavyLabel = UILabel()
        heavyLabel.text = "This is the heavy label"
        heavyLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        heavyLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "This is the description label"
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [
            heavyLabel,
            descriptionLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        stackView.anchor(top: nil,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
