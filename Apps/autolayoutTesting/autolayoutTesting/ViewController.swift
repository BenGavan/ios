//
//  ViewController.swift
//  autolayoutTesting
//
//  Created by Ben Gavan on 30/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let discriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Joint us Today"
        textView.font = .boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .yellow
        
        view.addSubview(bearImageView)
        view.addSubview(discriptionTextView)
        
        setupLayout()
        
       
        
    }
    
    private func setupLayout() {
        bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        discriptionTextView.topAnchor.constraint(equalTo: bearImageView.bottomAnchor, constant: 120).isActive = true
        discriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        discriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        discriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

