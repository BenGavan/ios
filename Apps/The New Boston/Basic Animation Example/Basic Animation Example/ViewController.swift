//
//  ViewController.swift
//  Basic Animation Example
//
//  Created by Ben Gavan on 31/05/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var exampleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create animation block to fade out
        UIView.animate(withDuration: 3.0, animations: {
//            self.exampleButton.alpha = 0 //button fades out
            
            let angle = CGFloat(180)
            let rotate = CGAffineTransform(rotationAngle: angle)
            self.exampleButton.transform = rotate.scaledBy(x: 4.0, y: 4.0)
            
            
        })
        
    }

    


}

