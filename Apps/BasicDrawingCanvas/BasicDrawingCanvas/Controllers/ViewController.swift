//
//  ViewController.swift
//  BasicDrawingCanvas
//
//  Created by Ben Gavan on 11/07/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: TODO:
    // TODO: Have the color selection be gradual/gradient
    // TODO: Chage of alpha (like snapchat)
    // TODO: Change the stroke width select be a 2 finger pinch
    // TODO: Save canvas to an image
    // TODO: Add typed text to screen (like scnapchat)
    // TODO: Overlay/undlay with a photo (like snapchat)
    
    private let canvas = Canvas()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    private let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    private let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange(button:)), for: .touchUpInside)
        return button
    }()
    
    private let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange(button:)), for: .touchUpInside)
        return button
    }()
    
    private let widthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(handleWidthSliderValueChange), for: .valueChanged)
        return slider
    }()
    
    // MARK: overrides
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: private functions
    private func setupLayout() {
        let colorsStackView = UIStackView(arrangedSubviews: [
            yellowButton, redButton, blueButton
            ])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            colorsStackView,
            widthSlider,
            clearButton
            ])
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: Button handlers
    @objc private func handleUndo() {
        canvas.undo()
    }
    
    @objc private func handleClear() {
        canvas.clear()
    }
    
    @objc private func handleColorChange(button: UIButton) {
        canvas.setStroke(color: button.backgroundColor ?? .black)
    }
    
    @objc private func handleWidthSliderValueChange () {
        canvas.setStroke(width: widthSlider.value)
    }
}

