//
//  GameplayScene.swift
//  Fruit Eater
//
//  Created by Ben Gavan on 05/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player?
    private var centre = CGFloat()
    private var canMove = false, moveLeft = false
    private var itemController = ItemController()
    private var scoreLabel: SKLabelNode?
    private var score = 0
    
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > centre {
              moveLeft = false
            } else {
                moveLeft = true
            }
        }
        canMove = true
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Fruit" {
            score += 1
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Bomb" {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.restartGame), userInfo: nil, repeats: false)
            
        }
        
    }
    
     private func initializeGame() {
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode
        scoreLabel?.text = "0"
        
        centre = self.frame.size.width / self.frame.size.height
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomNumbers(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameplayScene.spawnItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(GameplayScene.removeItems), userInfo: nil, repeats: true)
        
    }
    
    private func managePlayer() {
        if canMove {
            player?.move(left: moveLeft)
        }
    }
    
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems())
    }
    
    func restartGame() {
        if let scene = GameplayScene(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: 2))
        }
    }
    
    func removeItems() {
        for child in children {
            if child.name == "Fruit" || child.name == "Bomb" {
                if child.position.y < -self.scene!.frame.height - 100 {
                    child.removeFromParent()
                }
            }
        }
    }
    
}
