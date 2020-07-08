//
//  ViewController.swift
//  HorizontalLabelAutoScroll
//
//  Created by Ben Gavan on 12/10/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let label = UILabel()
        label.text = "This is a label!!!"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }


}

