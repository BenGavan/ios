//
//  ViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import MapKit

protocol NotificationPageDelegate {
    func logout()
    func moveNotificationViewBack()
    func moveToProfile()
    func moveToAddFriends()
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NotificationPageDelegate {
    
    private let TAG = "HomeViewController"
    
    weak var mainNavigationController: MainNavigationController?
    
    let cellId = "cellId"
    
    let messagePageId = "messagePageId"
    let mapPageId = "mapPageId"
    let notificationPageId = "notificationPageId"
    let profilePageId = "profilePageId"
    let cameraPageId = "cameraPageId"
    
    var previousPage = 0
    
    var notificationViewBottomAnchor: NSLayoutConstraint?
    
    lazy var menuBar: TopMenuBar = {
        let mb = TopMenuBar()
        mb.homeViewController = self
        return mb
    }()
//
//    let menuBar: UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MessagePageCell.self, forCellWithReuseIdentifier: messagePageId)
        cv.register(MapPageCell.self, forCellWithReuseIdentifier: mapPageId)
        cv.register(ProfilePageCell.self, forCellWithReuseIdentifier: profilePageId)
        cv.register(NotificationPageCell.self, forCellWithReuseIdentifier: notificationPageId)
        cv.register(CameraPageCell.self, forCellWithReuseIdentifier: cameraPageId)
        cv.alwaysBounceHorizontal = false
        cv.alwaysBounceVertical = false
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var notificationView: NotificationView = {
//        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let view = NotificationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.delegate = self
       
//        view.frame = CGRect(x: 0, y: -self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height) /// just off screen at the top with the same width and height of the current main view
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.shared.fetchCurrentUserData { (user) in
            print(user)
        }
        
        self.view.backgroundColor = .white

        setupViews()
    }

    private func setupViews() {
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = .orange

        self.view.addSubview(statusBarBackgroundView)
        self.view.addSubview(collectionView)
        self.view.addSubview(menuBar)
        self.view.addSubview(notificationView)

        self.view.bringSubviewToFront(statusBarBackgroundView)
        
        statusBarBackgroundView.anchor(top: self.view.topAnchor,
                                       leading: self.view.leadingAnchor,
                                       bottom: nil,
                                       trailing: self.view.trailingAnchor,
                                       height: 20)
        
        menuBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: nil,
                       trailing: self.view.trailingAnchor,
                       height: 50)
        
        collectionView.anchor(top: menuBar.bottomAnchor,
                              leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor,
                              trailing: self.view.trailingAnchor)
        
        notificationView.setHeight(UIScreen.main.bounds.height)
        notificationView.setWidth(UIScreen.main.bounds.width)
        notificationViewBottomAnchor =  notificationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: UIScreen.main.bounds.height)
        notificationViewBottomAnchor?.isActive = true
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        menuBar.addGestureRecognizer(tapGestureRecognizer)
    
    }
    
    func scrollTo(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        print(indexPath)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    ///// MARK: Notification Page Delegate /////
    func logout() {
        print(TAG, "logging out")
        Auth.shared.logout(onSuccess: {
            DispatchQueue.main.async {
                self.mainNavigationController?.popToRootViewController(animated: true)
                self.mainNavigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }) {
            print("Failed")
        }
        
    }
    
    func moveNotificationViewBack() {
        print("back")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //            self.notificationView.frame.applying(transformation)
            self.notificationViewBottomAnchor?.constant = UIScreen.main.bounds.height
            self.notificationView.alpha = 0
            
        }, completion: nil)
    }
    
    func moveToProfile() {
        let profileViewController = ProfileViewController()
        profileViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(profileViewController, animated: true)
        ApiService.shared.fetchCurrentUserData { (user) in
            print("Move to profile with user:", user)
            DispatchQueue.main.async {
                profileViewController.user = user
            }
        }
    }
    
    func moveToAddFriends() {
        print("Moving to Add Friends")
        let addFriendsViewController = AddFriendViewController()
        addFriendsViewController.mainNavigationController = self.mainNavigationController
        self.mainNavigationController?.pushViewController(addFriendsViewController, animated: true)
    }
    
    ////// swipe down notification view  //////
    
    var startY: CGFloat = UIScreen.main.bounds.height - 100
    var prevTranslation: CGFloat = 0.0
    
    var infoTopContraint: NSLayoutConstraint?
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        print("Panning")
        let translation = recognizer.translation(in: self.menuBar).y
        prevTranslation += translation
        if true {
            prevTranslation = 0
            if recognizer.state == .began {
                startY = -UIScreen.main.bounds.height
            } else {
                let currentY = UIScreen.main.bounds.height - self.collectionView.frame.height
                if (currentY > -(CGFloat(numberOfCells * (100 + 10)) - UIScreen.main.bounds.height))  || ( (translation > 0)) {
                    let newConstant = startY + translation
                    print("Constant: ", newConstant)
                    if newConstant > 690 {
                        infoTopContraint?.constant = 1000
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        })
                    } else {
                        infoTopContraint?.constant = newConstant
                        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }
        }
    }
    
    
    @objc private func handleTap() {
        print("Tap")
        self.notificationView.alpha = 1

//        let transformation = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.notificationView.frame.applying(transformation)
            self.notificationViewBottomAnchor?.constant = 0
            self.notificationView.alpha = 1
            
        }, completion: nil)
//        notificationView.frame = notificationView.frame.applying(transformation)
    }
}



extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messagePageId, for: indexPath) as? MessagePageCell else { return UICollectionViewCell() }
            cell.mainNavigationController = mainNavigationController
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapPageId, for: indexPath) as? MapPageCell else { return UICollectionViewCell() }
            cell.mainNavigationController = mainNavigationController
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraPageId, for: indexPath) as? CameraPageCell else { return UICollectionViewCell() }
            cell.mainNavigationController = mainNavigationController
            return cell
        default:
            return UICollectionViewCell()
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profilePageId, for: indexPath) as? ProfilePageCell else { return UICollectionViewCell() }
//            cell.mainNavigationController = mainNavigationController
//            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
//        if index == 2 {
//            if previousPage == 1 {
//                index += 1
//            } else if previousPage == 3 {
//                index -= 1
//            }
//        }
//        previousPage = index
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}


