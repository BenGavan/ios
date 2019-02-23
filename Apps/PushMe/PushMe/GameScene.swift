//
//  GameScene.swift
//  PushMe
//
//  Created by Ben Gavan on 24/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    
    var initialPlayerPosition: CGPoint!
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maximumPossiibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalizedForce = force / maximumPossiibleForce
            
            player.position.x = (self.size.width / 2) - normalizedForce * (self.size.width / 2 - 25)
            player2.position.x = (self.size.width / 2) + normalizedForce * (self.size.width / 2 - 25)

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
    }
    

    func resetPlayerPosition() {
        player.position = initialPlayerPosition
        player2.position = initialPlayerPosition
    }
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()        
    }
    
    func addRandomRow() {
        let randomNumber = Int(arc4random_uniform(6))
        
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
    }
    
    func updateWith(timeSinceLastUpdate: TimeInterval) {
        lastYieldTimeInterval += timeSinceLastUpdate
        
        if lastYieldTimeInterval > 0.6 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1 / 60
            lastUpdateTimeInterval = currentTime
        }
        
        updateWith(timeSinceLastUpdate: timeSinceLastUpdate)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER" {
            print("Game Over")
            //show Game Over Scene
            showGameOver()
        }
    }
    
    func showGameOver() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
        
    }
}















