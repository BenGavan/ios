//
//  ViewController.swift
//  bottomPannelSlideTest
//
//  Created by Ben Gavan on 22/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

protocol GestureDelegate: class {
    func upDateViewPossition(with constant: CGFloat)
    func getBottomViewHeightAnchor() -> CGFloat
    func getHeightOfWindow() -> CGFloat
}

class ViewController: UIViewController, GestureDelegate {
    
    let bottomView: BottomView = {
        let v = BottomView()
        return v
    }()
    
    func getHeightOfWindow() -> CGFloat {
        return view.frame.height
    }

    func upDateViewPossition(with constant: CGFloat) {
        bottomViewHeightAnchor?.constant = constant
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    func getBottomViewHeightAnchor() -> CGFloat {
        return (bottomViewHeightAnchor?.constant)!
    }
    
    var bottomViewHeightAnchor: NSLayoutConstraint? {
        didSet {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(bottomView)
        bottomView.delegate = self
        
        bottomViewHeightAnchor = bottomView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40).last
    }
}

class BottomView: UIView {
    
    var delegate: GestureDelegate?
    
    lazy var dragBar: UIView = {
        let view = UIView()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .yellow
        
        self.addSubview(dragBar)
        _ = dragBar.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)

    }
    
    var startY: CGFloat = 0
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self).y

        if recognizer.state == .began {
            startY = (delegate?.getBottomViewHeightAnchor())!
        } else {
            if ((delegate?.getBottomViewHeightAnchor())! >= CGFloat(20)) {
                var newY = startY - translation
                if (newY > (delegate?.getHeightOfWindow())!) {
                    newY = (delegate?.getHeightOfWindow())!
                } else if (newY < 40) {
                    newY = 40
                }
                delegate?.upDateViewPossition(with: newY)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame: ) not implemented")
    }
}

