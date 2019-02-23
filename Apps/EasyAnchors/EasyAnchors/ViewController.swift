//
//  ViewController.swift
//  EasyAnchors
//
//  Created by Ben Gavan on 01/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let redView = UIView()
        redView.backgroundColor = .red

        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        [redView, blueView, greenView].forEach { self.view.addSubview($0) }
        
        let smallSquareWidth = 75
        
        redView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 12), size: .init(width: smallSquareWidth, height: 0))
        redView.heightAnchor.constraint(equalTo: redView.widthAnchor).isActive = true
        
        blueView.anchor(top: redView.bottomAnchor, leading: nil, bottom: nil, trailing: redView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        blueView.anchorSize(to: redView)
        
        
        greenView.anchor(top: redView.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: blueView.bottomAnchor, trailing: redView.leadingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
        let purpleView = UIView()
        purpleView.backgroundColor = .purple
        greenView.addSubview(purpleView)
        purpleView.fillSuperView()
    }
}


extension UIView {
    
    func fillSuperView() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

