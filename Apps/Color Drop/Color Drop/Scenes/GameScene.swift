//
//  GameScene.swift
//  Color Drop
//
//  Created by Ben Gavan on 24/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
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
    
    var score = 0
    var highScore = 0
    
    
    var ball: SKShapeNode?
    
    var clickCounter = 0
    var previousBallColor = -1
    var rotorState : ColorState?
    var ballState: ColorState?

    var isGameOver = false
    var isPlaying = false

    lazy var rotor: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "SquareRotor")
        node.position = CGPoint.init(x: (self.size.width / 2) , y: (node.size.height) )
        node.size = CGSize.init(width: self.size.width / 3, height: self.size.width / 3)
        return node
    }()
    
    lazy var tapToBeginLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.text = "Tap to Begin"
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        label.fontColor = .black
        label.zPosition = 2.0
        return label
    }()

    lazy var scoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 25)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "Score: \(score)"
        label.name = "Score Label"
        label.zPosition = 2.0
        return label
    }()
    
    lazy var pbScoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: 30, y: self.frame.height - 25)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "PB: \(highScore)"
        label.name = "PB Label"
        label.zPosition = 2.0
        return label
    }()

    lazy var highScoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.text = "Highscore: \(self.highScore)"
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.3)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.zPosition = 2.0
        return label
    }()
    
    override func didMove(to view: SKView) {
        print("test")
        self.backgroundColor = .white
        
        setupViews()
    }
    
    private func setupViews() {
        self.addChild(tapToBeginLabel)
        self.addChild(highScoreLabel)
        self.addChild(scoreLabel)
        self.addChild(pbScoreLabel)
        self.addChild(rotor)
    }
    
    
    func touchUp(atPoint pos : CGPoint) {
        if isPlaying == false {
            tapToBeginLabel.fadeOutWith(durration: 0.2)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPlaying == false {
            tapToBeginLabel.fadeOutWith(durration: 0.2)
            highScoreLabel.fadeOutWith(durration: 0.2)
            
//            self.addChild(scoreLabel)
            scoreLabel.fadeInWith(durration: 0.2)
            pbScoreLabel.fadeInWith(durration: 0.2)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
        
//        ball.position = CGPoint.init(x: self.size.width / 2, y: self.size.height)
//        ball.physicsBody?.isDynamic = false
//        ball.physicsBody = SKPhysicsBody.init(circleOfRadius: 25)
//        ball.physicsBody?.velocity = CGVector.init(dx: 0, dy: -200)
//        ball.physicsBody?.affectedByGravity = false
//        ball.physicsBody?.linearDamping = 0
        
        return ball
    }
}


class Ball: SKSpriteNode {
    
    init() {
        super.init()
        
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SKNode {
    
    func fadeOutWith(durration: TimeInterval) {
        self.run(SKAction.fadeOut(withDuration: durration))
    }
    
    func fadeInWith(durration: TimeInterval) {
        self.run(SKAction.fadeIn(withDuration: durration))
    }
    
}
