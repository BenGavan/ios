//
//  MainViewController.swift
//  MapTesting
//
//  Created by Ben Gavan on 09/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//
import MapKit

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var pannelView = UIView()
    
    var route = [CLLocation]()
    
    var distanceMeters: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = locationManager.location
        
        print(location?.coordinate)
        
        view.addSubview(UIView())
        pannelView = createControllerView()
        mapView.addSubview(pannelView)
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height - 200
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.satellite
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        // Or, if needed, we can position map in the center of the view
        //mapView.center = view.center
        
        //mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(34.9777777, -120.217321), MKCoordinateSpanMake(0.015, 0.015))
        
        view.addSubview(mapView)
        view.addSubview(createControllerView())
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var points = [CLLocationCoordinate2D]()

        let location = locations[0]
        route.append(location)
        
        mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.015, 0.015))
        
        if (route.count >= 2) {
            distanceMeters += (route.last?.distance(from: route[route.count - 2]))!
        }
        
        for point in route {
            points.append(point.coordinate)
        }
        
//        let geodesic = MKPolyline(coordinates: points, count: points.count)
//        mapView.add(geodesic)
        if route.count >= 2 {
            let line = MKPolyline(coordinates: [(route.last?.coordinate)!, route[route.count - 2].coordinate], count: 2)
            mapView.add(line)
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    private func createControllerView() -> UIView {
        let pannelView = PannelView(frame: CGRect(x: 0, y: view.frame.size.height - 200, width: view.frame.size.width, height: 200))
        
        return pannelView
    }
    
}


