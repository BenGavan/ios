//
//  StretchyHeaderFlowLayout.swift
//  StretchyBlurHeaderCollectionView
//
//  Created by Ben Gavan on 14/07/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class StretchyHeaderFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if (attributes.representedElementKind == UICollectionView.elementKindSectionHeader) && (attributes.indexPath.section == 0) {
                guard let collectionView = collectionView else { return }
                
                let contentOffSetY = collectionView.contentOffset.y
                
                if contentOffSetY > 0 {
                    return
                }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffSetY
                attributes.frame = CGRect(x: 0, y: contentOffSetY, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
