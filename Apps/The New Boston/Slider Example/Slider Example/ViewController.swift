//
//  ViewController.swift
//  Slider Example
//
//  Created by Ben Gavan on 27/05/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        var sliderValue = lroundf(sender.value)
        label.text = "\(sliderValue)"
        
    }

    @IBAction func toggle(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            label.text = "Private"
        }else{
            label.text = "Public"
        }
    }
    

}

