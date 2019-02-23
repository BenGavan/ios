//
//  ViewController.swift
//  appstore1
//
//  Created by Ben Gavan on 31/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class FeaturedAppsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var appCategories: [AppCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        appCategories = AppCategory.sampleApplCategories()
        
        AppCategory.fetchFeaturedApps()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
}

