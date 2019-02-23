//
//  NodeBuilder.swift
//  Circular Shooter
//
//  Created by Ben Gavan on 12/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import SpriteKit


struct NodeBuilder {
    
    public static func createMainBall(for frameSize: CGSize) -> SKSpriteNode {
        let mainBall = SKSpriteNode(imageNamed: "WhiteBall")
        
        mainBall.size = CGSize.init(width: frameSize.width / 3, height: frameSize.width / 3)  //Used to be 240 by 240
        mainBall.position = CGPoint.init(x: frameSize.width / 2, y: frameSize.height / 2)
        mainBall.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        mainBall.colorBlendFactor = 1.0
        mainBall.zPosition = 1.0
        mainBall.alpha = 1.0
        //Physics
        mainBall.physicsBody = SKPhysicsBody(circleOfRadius: mainBall.size.width / 2)
        mainBall.physicsBody?.categoryBitMask = PhysicsCategory.MainBall
        mainBall.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
        mainBall.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        mainBall.physicsBody?.isDynamic = false
        mainBall.physicsBody?.affectedByGravity = false
        mainBall.name = "MainBall"
        
        return mainBall
    }
    
    public static func createEnemyBall(for frameSize: CGSize) -> SKSpriteNode {
        let enemy = SKSpriteNode(imageNamed: "WhiteBall")
        
        enemy.size = CGSize(width: frameSize.width / 36, height: frameSize.width / 36)
        enemy.color = UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1)
        enemy.colorBlendFactor = 1.0
        
        //Physics
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width / 3)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.SmallBall | PhysicsCategory.MainBall
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.SmallBall | PhysicsCategory.MainBall
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.affectedByGravity = false
        enemy.name = "Enemy"
        
        return enemy
    }
    
    public static func createLabel(with text: String, alpha: Double, font: Double, color: UIColor, zPosision: Double, name: String, x: CGFloat, y: CGFloat) -> SKLabelNode {
        let label = SKLabelNode()
        
        label.text = text
        
        return label
    }
    
    
    
}
