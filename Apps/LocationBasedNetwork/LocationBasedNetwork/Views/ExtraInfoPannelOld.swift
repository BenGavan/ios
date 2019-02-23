////
////  ExtraInfoPannel.swift
////  LocationBasedNetwork
////
////  Created by Ben Gavan on 14/10/2017.
////  Copyright © 2017 Ben Gavan. All rights reserved.
////
//
//
//
//import UIKit
//
//class ExtraInfoPannelOld: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    var delegate: GestureDelegate?
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.register(MomentInfoCell.self, forCellWithReuseIdentifier: momentCellId)
//        cv.register(InAreaMomentCell.self, forCellWithReuseIdentifier: inAreaMomentCellId)
//        cv.dataSource = self
//        cv.delegate = self
//        cv.isPagingEnabled = true
//        cv.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        cv.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
//        return cv
//    }()
//    
//    lazy var topOptionPannel: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
//        view.addGestureRecognizer(gesture)
//     
//        let topBorder = UIView()
//        topBorder.backgroundColor = .borderColor
//        
//        let bottomBorder = UIView()
//        bottomBorder.backgroundColor = .borderColor
//
//        view.addSubview(topBorder)
//        view.addSubview(bottomBorder)
//        
//        _ = topBorder.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
//        
//        _ = bottomBorder.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
//        
//        return view
//    }()
//    
//    let cellId = "cellId"
//    let momentCellId = "momentCellId"
//    let inAreaMomentCellId = "inAreaMomentCellId"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        
//        setupViews()
//    }
//    
//    private func setupViews() {
//        
//        self.addSubview(topOptionPannel)
//        self.addSubview(collectionView)
//        
//        _ = topOptionPannel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
//        
//        collectionView.anchorWithConstantsToTop(topOptionPannel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
//        
//        
//    }
//    
//    var startY: CGFloat = 0
//    
//    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self).y
//        
//        if recognizer.state == .began {
////            print("now", delegate?.getBottomViewHeightAnchor())
//            startY = (delegate?.getBottomViewHeightAnchor()) ?? 0
//        } else {
//            if ((delegate?.getBottomViewHeightAnchor())! >= CGFloat(20)) {
//                var newY = startY - translation
//                if (newY > (delegate?.getHeightOfWindow())!) {
//                    newY = (delegate?.getHeightOfWindow())!
//                } else if (newY < 40) {
//                    newY = 40
//                }
//                delegate?.upDateViewPossition(with: newY)
//                collectionView.reloadData()
//            }
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        if indexPath.item == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: momentCellId, for: indexPath) as! MomentInfoCell
//            
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: inAreaMomentCellId, for: indexPath) as! InAreaMomentCell
//            
//            return cell
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: frame.height)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init() was not implemented")
//    }
//}
//
//
//class MomentInfoCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.register(MomentCell.self, forCellWithReuseIdentifier: cellId)
//        cv.dataSource = self
//        cv.delegate = self
//        cv.backgroundColor = .orange
//        return cv
//    }()
//    
//    let cellId = "cellId"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .yellow
//        
//        setupViews()
//    }
//    
//    private func setupViews() {
//        self.addSubview(collectionView)
//        _ = collectionView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: 100)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(frame: ) not implemented")
//    }
//}
//
//class InAreaMomentCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.register(MomentCell.self, forCellWithReuseIdentifier: cellId)
//        cv.dataSource = self
//        cv.delegate = self
//        cv.backgroundColor = .orange
//        return cv
//    }()
//    
//    let cellId = "cellId"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    private func setupViews() {
//        self.addSubview(collectionView)
//        _ = collectionView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: 100)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(frame: ) not implemented")
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
