//
//  ViewController.swift
//  GoogleMapsTesting
//
//  Created by Ben Gavan on 28/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var mapView: GMSMapView?
    
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
    
    var markers = [GMSMarker]()
    
    var startY: CGFloat = UIScreen.main.bounds.height - 100
    var prevTranslation: CGFloat = 0.0
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
 
        let translation = recognizer.translation(in: self.view).y
//        print(translation)
        prevTranslation += translation
//        print("prevtranslation", prevTranslation)
//        if (prevTranslation >= 2) || (prevTranslation <= -2)
        if true {
            prevTranslation = 0
            if recognizer.state == .began {
                startY = UIScreen.main.bounds.height - self.collectionView.frame.height
//                print("start y is ...............................................", startY)
            } else {
//                let rect = CGRect(x: 0, y: startY - translation, width: self.view.frame.width, height: startY - translation)
                let currentY = UIScreen.main.bounds.height - self.collectionView.frame.height
                if (currentY > -(CGFloat(numberOfCells * (100 + 10)) - UIScreen.main.bounds.height))  || ( (translation > 0)) {
                    let newConstant = startY + translation
                    if newConstant > 690 {
                        topContraint?.constant = 1000
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        })
                    } else {
//                        print("new const y is ...............................................", newConstant)
                        topContraint?.constant = newConstant
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
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
        cell.backgroundColor = .red
        cell.id = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("pressed", indexPath.row)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupCollectionView()
    }
    
    var topContraint: NSLayoutConstraint?
    
    private func setupCollectionView() {
        print("setting up collection view")
        
//        self.collectionView.contentInset = UIEdgeInsetsMake(UIScreen.main.bounds.height - 100 - 5, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        topContraint = collectionView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: UIScreen.main.bounds.height - 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0).first

        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
//        print(topContraint)
//        print("top Constant is .......................", topContraint?.constant)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }
    
    private func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 53.813108, longitude: -2.534353, zoom: 5.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.mapType = .normal
        mapView?.delegate = self
        
        self.view = mapView
        
        // Creates a marker in the center of the map.
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 54.813108, longitude: -2.534353)
        marker2.title = "Ben"
        marker2.snippet = "How are you?"
        marker2.userData = Post(id: "Hi", text: "How Are You", user: "Ben")
        let markerImage2 = #imageLiteral(resourceName: "search")
        markerImage2.draw(in: CGRect(x: 0, y: 0, width: 1, height: 1))
        marker2.icon = markerImage2
        
        marker2.map = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 53.813108, longitude: -2.534353)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.userData = Post(id: "Hi", text: "How Are You", user: "Ben")
        
        let backgroundImage = UIImage(named: "bubble_blue")!
        let backgroundImageView = UIImageView(image: backgroundImage)
        
        let label = UILabel()
        label.text = "Text"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 100)
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(label)
        
        _ = backgroundImageView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = label.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        let renderer = UIGraphicsImageRenderer(size: containerView.bounds.size)
        let image = renderer.image { ctx in
            containerView.drawHierarchy(in: containerView.bounds, afterScreenUpdates: true)
        }
        
        marker.icon = self.imageWithImage(image: image, scaledToSize: CGSize(width: 100.0, height: 30.0))
        marker.map = mapView
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let userdata = marker.userData as? Post {
            print(userdata.id, userdata.user, userdata.text)
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
    }
    
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        for marker in markers {
            marker.map = nil
            marker.map = mapView
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }

    func createMarkers() {
        for i in 1...10 {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 53.813108 + Double(i / 100), longitude: -2.534353 + Double(i / 5))
            marker.title = "Ben: \(i)"
            marker.snippet = "How are you?"
            marker.userData = Post(id: "Hi", text: "How Are You", user: "Ben")
            marker.map = mapView
            
            markers.append(marker)
        }
    }
}

struct Post {
    let id: String
    let text: String
    let user: String
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
        label.anchorToTop(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





extension UIView {
    
    func anchorToTop( top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsToTop(top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        _ = anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}


