//
//  RecordViewController.swift
//  Fitness Tracker
//
//  Created by Ben Gavan on 25/08/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import Foundation
import MapKit


class RecordViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    var route = [CLLocation]()
    
    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = locationManager.location
        
        print(location?.coordinate)
        
        view.addSubview(UIView())
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        route.append(location)
        
        print(location.coordinate)
        
        mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.015, 0.015))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(34.9777777, -120.217321), MKCoordinateSpanMake(0.015, 0.015))
        
        view.addSubview(mapView)
        createControllerView()
    }
    
    private func createControllerView() {
        let pannelView = UIView()
        pannelView.center = view.center
        pannelView.backgroundColor = .white
        view.addSubview(pannelView)
    }
    
}
