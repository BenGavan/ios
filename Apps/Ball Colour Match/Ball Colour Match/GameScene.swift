//
//  GameScene.swift
//  Ball Colour Match
//
//  Created by Ben Gavan on 26/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit
import GameplayKit

enum ColorState {
    case red
    case orange
    case green
    case blue
    static var cases : [ColorState] = [.red, .orange, .green, .blue]
    init (_ ix: Int) {
        self = ColorState.cases[ix]
    }
}


class GameScene: SKScene {
    
    var ball: SKShapeNode?
    var squareRotor: SKSpriteNode?
    var scoreLabel = SKLabelNode()
    
    var rotorState = 0
    var previousBallColor = -1
    var theRotorState : ColorState?
    var ballState: ColorState?
    var score: Int = 0
    
    var isGameOver = false
    
    
    override func didMove(to view: SKView) {

        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        squareRotor = SKSpriteNode.init(imageNamed: "SquareRotor")
        squareRotor?.position = CGPoint.init(x: (self.size.width / 2) , y: (squareRotor?.size.height)! )
        squareRotor?.size = CGSize.init(width: 200, height: 200)
//        squareRotor?.anchorPoint = CGPoint.init(x: (squareRotor?.size.width)! / 2, y: (squareRotor?.size.height)! / 2 )
        ball = randomBall()
        
        theRotorState = ColorState(rotorState % 4)
        
        
        self.addChild(squareRotor!)
        self.addChild(ball!)
    
    }
    
    func randomBall() -> SKShapeNode {
        let ball = SKShapeNode(circleOfRadius: 25)
        var randomNumber: Int
        repeat {
            randomNumber = Int(arc4random_uniform(3))
            
        } while randomNumber == previousBallColor
        
        previousBallColor = randomNumber
        
        switch randomNumber{
        case 0:
            ball.fillColor = SKColor.blue
            ballState = .blue
        case 1:
            ball.fillColor = SKColor.red
            ballState = .red
        case 2:
            ball.fillColor = SKColor.green
            ballState = .green
        case 3:
            ball.fillColor = SKColor.orange
            ballState = .orange
        default:
            break
        }
        
        ball.position = CGPoint.init(x: self.size.width / 2, y: self.size.height)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody = SKPhysicsBody.init(circleOfRadius: 25)
        ball.physicsBody?.velocity = CGVector.init(dx: 0, dy: -200)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.linearDamping = 0
        
        return ball
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isGameOver {
            squareRotor?.run(SKAction.rotate(byAngle: -CGFloat.init(Double.pi) / 2, duration: 1))
            rotorState += 1
            theRotorState = ColorState(rotorState % 4)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if !isGameOver {
            if (ball?.position.y)! < CGFloat.init((squareRotor?.size.height)!) {
                if ballState == theRotorState {
                    score += 1
                    scoreLabel.text = "\(score)"
                    print(score)
                    ball?.removeFromParent()
                    ball = randomBall()
                    self.addChild(ball!)
                } else {
                    endGame()
                }
            }
        }
    }
    
    func endGame() {
        print("GameOver")
        isGameOver = true
        ball?.removeFromParent()
        let gameOver = UIView(frame: CGRect.init(x: 100, y: 100, width: 0, height: 0))
        gameOver.backgroundColor = UIColor.red
        
        
        self.view?.addSubview(gameOver)
        
        //Call whenever you want to show it and change the size to whatever size you want
        UIView.animate(withDuration: 2, animations: {
            gameOver.frame.size = CGSize.init(width: 100, height: 100)
        })
    }
}



















