//
//  ViewController.swift
//  Switch Testing
//
//  Created by Ben Gavan on 14/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        if (sender.isOn) {
            output.text = "Yes! I want Pizza"
        } else if (sender.isOn == false) {
            output.text = "No! I am weired"
        }
    }
    

}

