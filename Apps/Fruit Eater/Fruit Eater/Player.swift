//
//  Player.swift
//  Fruit Eater
//
//  Created by Ben Gavan on 05/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var minX = CGFloat(-200), maxX = CGFloat(200)
    
    func initializePlayer() {
        name = "Player"
        physicsBody = SKPhysicsBody.init(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.contactTestBitMask = ColliderType.FRUIT_AND_BOMB
        zPosition = 5.0
    }
    
    func move(left: Bool) {
        if left {
            position.x -= 15
            
            if position.x < minX {
                position.x = minX
            }
            
        } else {
            position.x += 15
            
            if position.x > maxX {
                position.x = maxX
            }
        }
        
    }
    
}
