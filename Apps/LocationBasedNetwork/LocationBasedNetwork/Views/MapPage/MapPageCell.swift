//
//  MapPageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 25/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import MapKit
import CoreLocation

class MapPageCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var mainNavigationController: MainNavigationController?
    
    var bottomViewHeightAnchor: NSLayoutConstraint?
    var newMomentTextBodyBottomPadding: NSLayoutConstraint?
    var postButtonBottomPadding: NSLayoutConstraint?
    
    var infoTopContraint: NSLayoutConstraint?
    
    var infoTopAnchor: NSLayoutConstraint? {
        didSet {
            extraInfoPannelView.topContraint = self.infoTopAnchor
        }
    } ///it is where it is anchored to

    let mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    lazy var extraInfoPannelView: ExtraInfoPannel = {
        let view = ExtraInfoPannel()
        view.topContraint = infoTopAnchor
        return view
    }()
    
    lazy var newMomentView: NewMomentView = {
        let view = NewMomentView()
        return view
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Camera", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var newButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("New", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(newMoment), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    let newMomentTextBody: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Text"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(postMoment), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    /////////////////////////////// Swipe up pannel TODO - Move into own class //////////////////////////////
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
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
    
    var startY: CGFloat = UIScreen.main.bounds.height - 100
    var prevTranslation: CGFloat = 0.0
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self).y
        prevTranslation += translation
        if true {
            prevTranslation = 0
            if recognizer.state == .began {
                startY = UIScreen.main.bounds.height - self.collectionView.frame.height
            } else {
                let currentY = UIScreen.main.bounds.height - self.collectionView.frame.height
                if (currentY > -(CGFloat(numberOfCells * (100 + 10)) - UIScreen.main.bounds.height))  || ( (translation > 0)) {
                    let newConstant = startY + translation
                    print("Constant: ", newConstant)
                    if newConstant > 690 {
                        infoTopContraint?.constant = 1000
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.layoutIfNeeded()
                        })
                    } else {
                        infoTopContraint?.constant = newConstant
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.layoutIfNeeded()
                        })
                    }
                }
            }
        }
    }
    
    let numberOfCells = 15
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        cell.backgroundColor = .blue
        cell.id = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed", indexPath.row)
    }
    
    private func setupCollectionView() {
        print("setting up collection view")
        
        self.addSubview(self.collectionView)
        infoTopContraint = collectionView.anchor(self.topAnchor,
                                                 left: self.leftAnchor,
                                                 bottom: self.bottomAnchor,
                                                 right: self.rightAnchor,
                                                 topConstant: UIScreen.main.bounds.height - 100,
                                                 leftConstant: 0,
                                                 bottomConstant: 0,
                                                 rightConstant: 0,
                                                 widthConstant: 0,
                                                 heightConstant: 0).first
    }
    
    private func setupViews() {
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        [mapView, cameraButton, newButton, extraInfoPannelView].forEach { self.addSubview($0) }
        
        _ = mapView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = cameraButton.anchor(nil, left: nil, bottom: newButton.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 70, heightConstant: 0)
        
        _ = newButton.anchor(cameraButton.bottomAnchor, left: nil, bottom: extraInfoPannelView.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 70, heightConstant: 0)
        
        infoTopAnchor = extraInfoPannelView.topAnchor.constraint(equalTo: self.topAnchor)
        infoTopAnchor?.isActive = true
        extraInfoPannelView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        extraInfoPannelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        extraInfoPannelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        setupCollectionView()
    }
    
    fileprivate func observeKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapPageCell { // Keyboard logic
    @objc func keyboardShow() {
        self.newMomentTextBodyBottomPadding?.constant = -270
        self.newMomentTextBody.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.postButtonBottomPadding?.constant = -270
        //self.newMomentTextBody.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        })
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.addSubview(blurEffectView)
    }
    
    @objc func keyboardHide() {
        self.newMomentTextBodyBottomPadding?.constant = -10
        self.newMomentTextBody.backgroundColor = .clear
        
        self.postButtonBottomPadding?.constant = -10
        
        for subview in mapView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        })
    }
}

extension MapPageCell {
    @objc func openCamera() {
        print("opening camera")
    }
    
    @objc func newMoment() {
        self.addSubview(newMomentView)
        _ = newMomentView.anchor(self.topAnchor, left: self.leftAnchor, bottom: extraInfoPannelView.topAnchor, right: self.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.frame.height - 100)
        print("Testing")
    }
    
    @objc func postMoment() {
        let momentText = newMomentTextBody.text
        let location = CLLocationCoordinate2DMake(0, 0)
        let moment = Moment(user: User(), text: momentText, id: "0", type: .text, time: Date(), location: location)
        
        ApiService.shared.postMomentFor(user: User(), moment: moment)
    }
}




