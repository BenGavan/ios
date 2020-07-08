//
//  ViewController.swift
//  AnimateFadeIn
//
//  Created by Ben Gavan on 16/05/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let testView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return v
    }()
    
    let animateButton: UIView = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("animate", for: .normal)
        b.backgroundColor = .red
        b.addTarget(self, action: #selector(handleAnimateButtonPress), for: .touchUpInside)
        return b
    }()
    
    var testViewCenterXAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        [testView, animateButton].forEach { (v) in
            self.view.addSubview(v)
        }
        
        setAnimationButtonConstraints()
        
        testView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.width).isActive = true
        testView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setAnimationButtonConstraints() {
        animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK:- Handlers
    @objc private func handleAnimateButtonPress() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.testView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true

//            self.testViewCenterXAnchor?.constant = 0
//            self.testViewCenterXAnchor?.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.width).isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    

        
    
}
