//
//  ExtraInfoView.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 02/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ExtraInfoPannel: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var topContraint: NSLayoutConstraint?
    
    var height: CGFloat?
    
    var startY: CGFloat = UIScreen.main.bounds.height - 100
    var prevTranslation: CGFloat = 0.0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .clear
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        cv.addGestureRecognizer(gesture)
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        collectionView.anchorToTop(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self).y
        print(translation)
        prevTranslation += translation
        print("prevtranslation", prevTranslation)
        if true {
            prevTranslation = 0
            if recognizer.state == .began {
                startY = UIScreen.main.bounds.height - self.collectionView.frame.height
            } else {
                let currentY = UIScreen.main.bounds.height - self.collectionView.frame.height
                if (currentY > -(CGFloat(numberOfCells * (100 + 10)) - UIScreen.main.bounds.height))  || ( (translation > 0)) {
                    let newConstant = startY + translation
                    if newConstant > 690 {
                        topContraint?.constant = 1000
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.layoutIfNeeded()
                        })
                    } else {
                        topContraint?.constant = newConstant
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.layoutIfNeeded()
                        })
                    }
                }
            }
        }
    }
}

let numberOfCells = 10

extension ExtraInfoPannel {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        cell.backgroundColor = .red
        cell.id = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
}




class CustomCell: UICollectionViewCell {
    
    var id = 0 {
        didSet {
            label.text = String(id)
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        label.anchor(top: self.topAnchor, leading: self.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

