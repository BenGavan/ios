//
//  SettingsPage.swift
//  Circular Shooter
//
//  Created by Ben Gavan on 14/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class SettingsPageController: UITableViewController {
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func vibrationChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            print("vibration on")
            userDefaults.set(true, forKey: "vibration")
            print(userDefaults.value(forKey: "vibration") as! Bool)
        } else if (sender.isOn == false) {
            print("Vibtration off")
            userDefaults.set(false, forKey: "vibration")
            print(userDefaults.value(forKey: "vibration") as! Bool)
        }
    }
    
    private func backToGame() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
