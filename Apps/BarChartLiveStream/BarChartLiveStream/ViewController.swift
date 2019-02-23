//
//  ViewController.swift
//  BarChartLiveStream
//
//  Created by Ben Gavan on 01/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: view.frame.height)
    }


}

