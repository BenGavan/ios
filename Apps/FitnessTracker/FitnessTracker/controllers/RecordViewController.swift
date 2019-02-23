//
//  RecordViewController.swift
//  FitnessTracker
//
//  Created by Ben Gavan on 26/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//
import UIKit
import CoreLocation
import GoogleMaps

class RecordViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var timer = Timer()
    
    var route = [CLLocation]()
    var time: Double = 0 {
        didSet {
            timeAlapsedLabel.time = time
        }
    }
    var distance: Double = 0 {
        didSet {
            distanceTraveledLabel.distance = distance
        }
    }
    
    var isRecording = false
    
    var mapView: GMSMapView?
    
    lazy var startPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(handleStartPause), for: .touchUpInside)
        return button
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finish", for: .normal)
        button.addTarget(self, action: #selector(handleFinish), for: .touchUpInside)
        return button
    }()
    
    let controlStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 16.0
        return stackView
    }()
    
    let distanceTraveledLabel: DistanceLabel = {
        let label = DistanceLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let timeAlapsedLabel: TimeLabel = {
        let label = TimeLabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = locationManager.location
        print("Location", location as Any )
        
        setupViews()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isRecording {
            let location = locations[0]
            route.append(location)
            
            if route.count > 1 {
                if let dist = route.last?.distance(from: route[route.count - 2]) {
                    distance += dist
                    print(dist)
                }
            }
        }
    }
    
    private func setupViews() {
        setupMap()
        setupInfoView()
    }
    
    private func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 53.813108, longitude: -2.534353, zoom: 5.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        guard let mapView = mapView else { return }
        mapView.mapType = .normal
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mapView)
        
        mapView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
    }
    
    private func setupInfoView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        
        self.view.addSubview(containerView)
        
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let infoStackView = UIStackView()
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = UILayoutConstraintAxis.horizontal
        infoStackView.distribution = UIStackViewDistribution.equalSpacing
        infoStackView.alignment = UIStackViewAlignment.center
        infoStackView.spacing = 16.0
        
        let distanceLabel = UILabel()
        distanceLabel.text = "Distance:"
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.backgroundColor = .white
        
        let timeLabel = UILabel()
        timeLabel.text = "Time:"
        timeLabel.backgroundColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(distanceLabel)
        infoStackView.addArrangedSubview(distanceTraveledLabel)
        infoStackView.addArrangedSubview(timeLabel)
        infoStackView.addArrangedSubview(timeAlapsedLabel)
        
        containerView.addSubview(infoStackView)

        infoStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        infoStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    
        containerView.addSubview(controlStackView)
        
        controlStackView.addArrangedSubview(startPauseButton)

        controlStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20).isActive = true
        controlStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    private func startTimer() {
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func endTimer() {
        timer.invalidate()
    }
    
    @objc func updateTimer() {
        time += 1
    }

    private func saveRoute() {
        print("Saving route...")
        guard let startDate = route.first?.timestamp else { return }
        let dateString = String(describing: startDate)
        
        for point in route {
            
        }
        let routeStruct = Route(date: dateString, duration: time, distance: distance, averageSpeed: <#T##Double?#>, points: <#T##[Point]?#>)
    }
    
    @objc private func handleStartPause() {
        isRecording = isRecording ? false : true
        
        if isRecording {
            print("Starting....")
            startPauseButton.setTitle("Pause", for: .normal)
            finishButton.removeFromSuperview()
            startTimer()
        } else {
            print("Paused")
            endTimer()
            startPauseButton.setTitle("Resume", for: .normal)
            controlStackView.addArrangedSubview(finishButton)
        }
    }
    
    @objc private func handleFinish() {
        print("Finshing....")
    }
}


