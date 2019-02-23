//
//  ViewController.swift
//  ContraintTesting
//
//  Created by Ben Gavan on 13/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.frame.height))
        v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
        let v2 = UIView()
        v2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
        let v3 = UIView()
        v3.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(v1)
        v1.addSubview(v2)
        v1.addSubview(v3)
        v2.translatesAutoresizingMaskIntoConstraints = false
        v3.translatesAutoresizingMaskIntoConstraints = false
        
        // Contraints
//        v1.addConstraint(NSLayoutConstraint(item: v2,
//                                            attribute: .leading,
//                                            relatedBy: .equal,
//                                            toItem: v1,
//                                            attribute: .leading,
//                                            multiplier: 1, constant: 0))
//        
//        v1.addConstraint(NSLayoutConstraint(item: v2,
//                                            attribute: .trailing,
//                                            relatedBy: .equal,
//                                            toItem: v1,
//                                            attribute: .trailing,
//                                            multiplier: 1, constant: 0))
//        
//        v1.addConstraint(NSLayoutConstraint(item: v2,
//                                            attribute: .top,
//                                            relatedBy: .equal,
//                                            toItem: v1,
//                                            attribute: .top,
//                                            multiplier: 1, constant: 0))
//        
//        v2.addConstraint(NSLayoutConstraint(item: v2,
//                                            attribute: .height,
//                                            relatedBy: .equal,
//                                            toItem: nil,
//                                            attribute: .notAnAttribute,
//                                            multiplier: 1, constant: 10))
//        
//        v3.addConstraint(NSLayoutConstraint(item: v3,
//                                           attribute: .width,
//                                           relatedBy: .equal,
//                                           toItem: nil,
//                                           attribute: .notAnAttribute,
//                                           multiplier: 1, constant: 20))
//        
//        v3.addConstraint(NSLayoutConstraint(item: v3,
//                                           attribute: .height,
//                                           relatedBy: .equal,
//                                           toItem: nil,
//                                           attribute: .notAnAttribute,
//                                           multiplier: 1, constant: 20))
//        
//        v1.addConstraint(NSLayoutConstraint(item: v3,
//                                            attribute: .trailing,
//                                            relatedBy: .equal,
//                                            toItem: v1,
//                                            attribute: .trailing,
//                                            multiplier: 1, constant: 0))
//        
//        v1.addConstraint(NSLayoutConstraint(item: v3,
//                                            attribute: .bottom,
//                                            relatedBy: .equal,
//                                            toItem: v1,
//                                            attribute: .bottom,
//                                            multiplier: 1, constant: 0))
        
        NSLayoutConstraint.activate([
            v2.leadingAnchor.constraint(equalTo: v1.leadingAnchor),
            v2.trailingAnchor.constraint(equalTo: v1.trailingAnchor),
            v2.topAnchor.constraint(equalTo: v1.topAnchor),
            v2.heightAnchor.constraint(equalToConstant: 10),
            v3.widthAnchor.constraint(equalToConstant: 20),
            v3.heightAnchor.constraint(equalToConstant: 20),
            v3.trailingAnchor.constraint(equalTo: v1.trailingAnchor),
            v3.bottomAnchor.constraint(equalTo: v1.bottomAnchor)
            ])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

