//
//  ViewController.swift
//  Log in
//
//  Created by Ben Gavan on 24/05/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //removes first responder status on all elements so will hide keyboard
        
    }

}

