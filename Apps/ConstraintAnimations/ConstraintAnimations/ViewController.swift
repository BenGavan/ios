//
//  ViewController.swift
//  ConstraintAnimations
//
//  Created by Ben Gavan on 01/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var steveJobsImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "mit-logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimation)))
        return imageView
    }()
    
    @objc private func handleAnimation() {
        print("it worked")
        
        topAnchor?.isActive = false
        leftAnchor?.isActive = false
        rightAnchor?.isActive = true
        bottomAnchor?.isActive = true
        
        rightAnchor?.constant = -16
        
        widthAnchor?.constant = 200
        widthAnchor?.constant = 200
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    var leftAnchor: NSLayoutConstraint?
    var rightAnchor: NSLayoutConstraint?
    var topAnchor: NSLayoutConstraint?
    var bottomAnchor: NSLayoutConstraint?
    
    var widthAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(steveJobsImageView)
        
        topAnchor = steveJobsImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        topAnchor?.isActive = true
        
        leftAnchor = steveJobsImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
        leftAnchor?.isActive = true
        
        rightAnchor = steveJobsImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        
        bottomAnchor = steveJobsImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        widthAnchor = steveJobsImageView.widthAnchor.constraint(equalToConstant: 100)
        widthAnchor?.isActive = true
        
        heightAnchor = steveJobsImageView.heightAnchor.constraint(equalToConstant: 100)
        heightAnchor?.isActive = true
    }
}

