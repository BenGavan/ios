//
//  SubscriptionCell.swift
//  youtubeTesting
//
//  Created by Ben Gavan on 01/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
