//
//  GameElements.swift
//  PushMe
//
//  Created by Ben Gavan on 24/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit

struct CollisionBitmask {
    static let Player: UInt32 = 0x00
    static let Obstacle: UInt32 = 0x01
}

enum ObstacleType: Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType: Int {
    case oneSmall = 0
    case oneMedium = 1
    case oneLarge = 2
    case twoSmall = 3
    case twoMedium = 4
    case threeSmall = 5
}

extension GameScene {
    
    func addPlayer() {
        player = SKSpriteNode(color: UIColor.red, size: CGSize.init(width: 25, height: 25))
        player.position = CGPoint.init(x: self.size.width / 2, y: 350)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody.init(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitmask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitmask.Obstacle
        
        player2 = SKSpriteNode(color: UIColor.red, size: CGSize.init(width: 25, height: 25))
        player2.position = CGPoint.init(x: self.size.width / 2, y: 350)
        player2.name = "PLAYER"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody.init(rectangleOf: player.size)
        player2.physicsBody?.categoryBitMask = CollisionBitmask.Player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitmask.Obstacle
        
        addChild(player)
        addChild(player2)
        
        initialPlayerPosition = player.position
    }
    
    func addObstacle(type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize.init(width: 0, height: 10))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        }
        
        obstacle.position = CGPoint.init(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitmask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addMovement(obstacle: SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint.init(x: obstacle.position.x, y: -obstacle.size.height), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
        
    }
    
    func addRow(type: RowType){
        switch type {
        case .oneSmall:
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneMedium:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneLarge:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .twoSmall:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst1.size.width - 50, y: obst2.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case .twoMedium:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width - obst1.size.width / 2 - 50 , y: obst2.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .threeSmall:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y) //Left
            obst2.position = CGPoint(x: self.size.width - obst1.size.width / 2 - 50, y: obst1.position.y) //Right
            obst3.position = CGPoint(x: self.size.width / 2, y: obst1.position.y) //Centre
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
