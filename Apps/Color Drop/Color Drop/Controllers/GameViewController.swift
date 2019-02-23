//
//  GameViewController.swift
//  Color Drop
//
//  Created by Ben Gavan on 24/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Set the scale mode to scale to fit the window
            
            let size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
            let scene = GameScene(size: size)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
           
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

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
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
