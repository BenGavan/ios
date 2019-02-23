//
//  MapAnnotation.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 07/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    

    init(location coord: CLLocationCoordinate2D) {
        
        self.coordinate = coord

        super.init()
        
    }
    
}
