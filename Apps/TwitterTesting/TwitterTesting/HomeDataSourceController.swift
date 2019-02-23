//
//  HomeDataSourceController.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 21/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSouceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong. Please try again later"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        setupNavigationBarItems()
        
        Service.sharedInstance.fetchHomeFeed { (homeDatasource, err) in
            if let err = err {
                self.errorMessageLabel.isHidden = false
                
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status code was not 200"
                        return
                    }
                }
            
                return
            }
            
            self.datasource = homeDatasource
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            if let user = self.datasource?.item(indexPath) as? User {
                // Get estimation of height of cell based on user.bioText
                
                let estimatedHeight = estimatedHeightForText(user.bioText)
                
                return CGSize(width: view.frame.width, height: estimatedHeight + 66)
            }
        } else if indexPath.section == 1 {
            // tweet size estimation
            guard let tweet = datasource?.item(indexPath) as? Tweet else { return .zero }
            
            let estimatedHeight = estimatedHeightForText(tweet.message)
            
            return CGSize(width: view.frame.width, height: estimatedHeight + 74)
        }
        
        
        return CGSize(width: view.frame.width, height: 150)
    }
    
    private func estimatedHeightForText(_ text: String) -> CGFloat {
        let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
        let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 { // for second section of UICollectionViewController
            return .zero // Does not show/include this (header)
        }
        return CGSize.init(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 { // for second section of UICollectionViewController
            return .zero // Does not show/include this (header)
        }
        return CGSize.init(width: view.frame.width, height: 64)
    }  
    
}
