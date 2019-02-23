//
//  Service.swift
//  TwitterTesting
//
//  Created by Ben Gavan on 23/08/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?) -> ()) {
        
        let request: APIRequest<HomeDatasource, JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource, nil)
        }) { (err) in
            
            completion(nil, err)
        }
        
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
    
}
