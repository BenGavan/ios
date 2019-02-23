//
//  GameViewController.swift
//  Circular Shooter
//
//  Created by Ben Gavan on 06/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class GameViewController: UIViewController {
    
   
    
    @IBOutlet public weak var vibrateSwitch: UISwitch!
    
    var scene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                let displaySize: CGRect = UIScreen.main.bounds
                let displayWidth = displaySize.width
                let displayHeight = displaySize.height
                
                scene.size = CGSize.init(width: displayWidth , height: displayHeight)
                // Present the scene
                view.presentScene(scene)
                
                scene.viewController = self

            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
//            
        }
        
    }

    
    override var shouldAutorotate: Bool {
        return false
    }
//
//    @IBAction func vibrateSwitchChanged(_ sender: UISwitch) {
//        let userDefaults = UserDefaults.standard
//        
//        if (sender.isOn) {
//            userDefaults.set(true, forKey: "vibration")
//            print("changed to true")
//        } else if (sender.isOn == false) {
//            userDefaults.set(false, forKey: "vibration")
//        }
//        
//        sender.alpha = 0
//    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        
        scene?.updateHighScore()
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
 }
    
    
    



private class VibrateSwitchController {
    
    static func fadeOut(vibrateSwitch: UISwitch) {
        vibrateSwitch.alpha = 0
    }
    
    static func fadeInVibrateSwitch(vibrateSwitch: UISwitch) {
        vibrateSwitch.alpha = 1
    }
}
