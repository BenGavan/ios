//
//  MainMenuScene.swift
//  Fruit Eater
//
//  Created by Ben Gavan on 05/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Start" {
                
                if let scene = GameplayScene(fileNamed: "GameplayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                }
            }
        }
    }
}
