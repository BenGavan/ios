//
//  MenuScene.swift
//  Ball Colour Match
//
//  Created by Ben Gavan on 06/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Start" {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.fade(withDuration: TimeInterval(0.1)))
                }
                
                
            }
            
        }
        
    }
    
}

