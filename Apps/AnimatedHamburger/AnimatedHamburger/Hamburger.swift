//
//  Hamburger.swift
//  AnimatedHamburger
//
//  Created by Ben Gavan on 11/06/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit

class Hamburger: UIView {

    var width: CGFloat = 50 //100
    private lazy var height: CGFloat = width * 0.8
    
    private lazy var lineWidth: CGFloat = width
    private lazy var lineHeight: CGFloat = height / 8
    
    private lazy var lineSpacing: CGFloat = height / 3.5

    private let line1 = UIView()
    private let line2 = UIView()
    private let line3 = UIView()
    
    private var line2HeightAnchor: NSLayoutConstraint?
    private var line2WidthAnchor: NSLayoutConstraint?
    
    private var line1CenterYAnchor: NSLayoutConstraint?
    private var line3CenterYAnchor: NSLayoutConstraint?
    
    private var isCross = false

    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTouch))
        self.addGestureRecognizer(tapRecognizer)

        backgroundColor = .yellow

        setupViews()
    }

    private func setupViews() {
        [line1, line2, line3].forEach { (v) in
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .black
            v.layer.cornerRadius = lineHeight / 2
            
            self.addSubview(v)
            
            v.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        
        line1.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
        line1.widthAnchor.constraint(equalToConstant: lineWidth).isActive = true
        
        line2HeightAnchor = line2.heightAnchor.constraint(equalToConstant: lineHeight)
        line2HeightAnchor?.isActive = true

        line2WidthAnchor = line2.widthAnchor.constraint(equalToConstant: lineWidth)
        line2WidthAnchor?.isActive = true
        
        line3.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
        line3.widthAnchor.constraint(equalToConstant: lineWidth).isActive = true

        line1CenterYAnchor = line1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -lineSpacing)
        line1CenterYAnchor?.isActive = true
        
        line2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        line3CenterYAnchor = line3.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: lineSpacing)
        line3CenterYAnchor?.isActive = true
    }

    // MARK:- Handler
    @objc private func handleTouch() {
        print("Touch")
        // Scale line 2 out
        if isCross {
            animateToHam()
        } else {
            animateToCross()
        }
        isCross = !isCross
    }

    // MARK:- Animations
    private func animateToCross() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.line2HeightAnchor?.constant = 0
            self.line2WidthAnchor?.constant = 0
            
            self.line1CenterYAnchor?.constant = 0
            self.line3CenterYAnchor?.constant = 0
            
            self.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.35, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.line1.transform = CGAffineTransform(rotationAngle: degToRad(45))
            self.line3.transform = CGAffineTransform(rotationAngle: degToRad(135))
            
            self.layoutIfNeeded()
        })
    }

    private func animateToHam() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.line1.transform = CGAffineTransform(rotationAngle: degToRad(0))
            self.line3.transform = CGAffineTransform(rotationAngle: degToRad(0))

            self.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.35, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.line2HeightAnchor?.constant = self.lineHeight
            self.line2WidthAnchor?.constant = self.lineWidth
            
            self.line1CenterYAnchor?.constant = -self.lineSpacing
            self.line3CenterYAnchor?.constant = self.lineSpacing
            
            self.layoutIfNeeded()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func degToRad(_ deg: CGFloat) -> CGFloat {
    return (deg / 180) * CGFloat.pi
}
