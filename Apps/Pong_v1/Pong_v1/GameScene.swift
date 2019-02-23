//
//  GameScene.swift
//  Pong_v1
//
//  Created by Ben Gavan on 16/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit
import GameplayKit

var currentGame = gameType.medium

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottonLabel = SKLabelNode()

    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottonLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGame == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x , duration: 0.1))
            }
        }
        
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottonLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        } else {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        topLabel.text = "\(score[1])"
        bottonLabel.text = "\(score[0])"
        
        print(score)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGame == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x , duration: 0.1))
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGame {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))

        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))

        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))

        case .player2:
            
            break
        }
        
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}
