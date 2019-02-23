//
//  ViewController.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 06/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let homeCellId = "homeCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let settingLauncher = SettingsLauncher()
        settingLauncher.homeViewController = self
        return settingLauncher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "  Home"
        titleLabel.font = .systemFont(ofSize: 18)
        navigationItem.titleView = titleLabel

        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    private func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        //        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.setRightBarButtonItems([moreButton, searchBarButtonItem], animated: false)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 32)
        
        view.addSubview(redView)
        view.addSubview(menuBar)
        
        _ = redView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        _ = menuBar.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    @objc func handleSearch() {
        scrollTo(menuIndex: 2)
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func scrollTo(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleFor(index: menuIndex)
    }

    func showControllerFor(setting: Setting) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.navigationItem.title = setting.name.rawValue
        dummySettingViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: false)
    }
    
    private func setTitleFor(index: Int) {
        (navigationItem.titleView as? UILabel)?.text = "  \(titles[index])"
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorContraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        setTitleFor(index: index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionCellId
        } else {
            identifier = homeCellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}

















