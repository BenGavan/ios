//
//  PannelView.swift
//  MapTesting
//
//  Created by Ben Gavan on 26/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit


public class PannelView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init overriveded")
        
        self.backgroundColor = .white
        
        addSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let recordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Record", for: .normal)
        button.titleLabel?.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(recordButtonTouchBegan), for: .touchDown)
        
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Pause", for: .normal)
        button.titleLabel?.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(pauseButtonTouchBegan), for: .touchDown)

        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Save", for: .normal)
        button.titleLabel?.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(saveButtonTouchBegan), for: .touchDown)

        
        return button
    }()
    
    private let distanceLabel: UILabel = {
        //        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        let label = UILabel()
        label.text = "0m"
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func addSubViews() {
        
        self.addSubview(distanceLabel)
        self.addSubview(recordButton)
        self.addSubview(pauseButton)
        self.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            distanceLabel.topAnchor.constraint(equalTo: self.topAnchor),
            distanceLabel.widthAnchor.constraint(equalToConstant: 40),
            
            recordButton.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor),
            recordButton.topAnchor.constraint(equalTo: self.topAnchor),
            recordButton.heightAnchor.constraint(equalToConstant: 40),
            recordButton.widthAnchor.constraint(equalToConstant: 80),
            
            pauseButton.leadingAnchor.constraint(equalTo: recordButton.trailingAnchor),
            pauseButton.topAnchor.constraint(equalTo: self.topAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 40),
            pauseButton.widthAnchor.constraint(equalToConstant: 80),
            
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            saveButton.topAnchor.constraint(equalTo: self.topAnchor),
//            saveButton.widthAnchor.constraint(equalToConstant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            //
            ])
        
//        Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(updateDistanceLabelText), userInfo: nil, repeats: true)
        
        print("Pannel View: finished Loading Pannel View")
    }
    
    var distance = 0
    
    @objc func updateDistanceLabelText() {
        distanceLabel.text = "\(distance)"
        distance += 1
    
    }

    @objc func recordButtonTouchBegan() {
        print("PannelView: recordButtonTouchBegan()")
    }
    
    @objc func pauseButtonTouchBegan() {
        print("PannelView: pauseButtonTouchBegan()")
        
    }
    
    @objc func saveButtonTouchBegan() {
        print("PannelView: saveButtonTouchBegan()")
    }
    
    
    public func setDistanceLabel(with text: String) {
        DispatchQueue.main.async {
            self.distanceLabel.text = "100 meters"
        }
        
        print("Updated Distance label with: \(text)")
            
    }
    
}

