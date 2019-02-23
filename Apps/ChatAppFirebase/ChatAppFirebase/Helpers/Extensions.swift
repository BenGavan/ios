//
//  Extensions.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 05/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    // caching

    func loadImagaesUsingCache(with urlString: String) {
        
        self.image = nil
        
        // check cache for image first
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        // otherwise fecth from server via network
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}
