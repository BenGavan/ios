//
//  GameScene.swift
//  PickerLock
//
//  Created by Ben Gavan on 09/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var circle = SKSpriteNode()
    private var person = SKSpriteNode()
    private var dot = SKSpriteNode()
    
    var levelLabel = SKLabelNode()
    
    var path = UIBezierPath()
    
    var gameStarted = Bool()
    var movingClockwise = Bool()
    var intersected = false
    
    var currentLevel = Int()
    var currentScore = Int()
    var highLevel = Int()
    
    override func didMove(to view: SKView) {
        let defaults = UserDefaults.standard
        if defaults.integer(forKey: "HighLevel") != 0 {
            highLevel = defaults.integer(forKey: "HighLevel") as Int!
            currentLevel = highLevel
            currentScore = currentLevel
        } else {
            defaults.set(1, forKey: "HighLevel")
        }
        
      loadView()
        
    }
    
    func loadView() {
        movingClockwise = true
        
        //Main Circle
        circle = SKSpriteNode.init(imageNamed: "Circle")
        circle.size = CGSize(width: 300, height: 300)
        circle.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        circle.zRotation = 1.0
        self.addChild(circle)
        
        //Person
        person = SKSpriteNode(imageNamed: "Person")
        person.size = CGSize(width: 40, height: 7)
        person.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 122)
        person.zRotation = CGFloat.pi / 2
        person.zPosition = 2.0
        self.addChild(person)
        addDot()
        
        //Level Label
        levelLabel = SKLabelNode.init()
        levelLabel.position = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        levelLabel.text = "0"
        levelLabel.fontColor = SKColor.darkGray
        self.addChild(levelLabel)
    }
    
    //Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !gameStarted {
            moveClockWise()
            movingClockwise = true
            gameStarted = true
        } else if gameStarted {
            if movingClockwise {
                moveAntiClockWise()
                movingClockwise = false
            } else if !movingClockwise {
                moveClockWise()
                movingClockwise = true
            }
            dotTouched()

        }
        
    }
    
    func addDot() {
        
        dot = SKSpriteNode(imageNamed: "Dot")
        dot.size = CGSize.init(width: 30, height: 30)
        dot.zPosition = 2.0
        
        let dx = person.position.x - self.frame.width / 2
        let dy = person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        if movingClockwise {
            let tempAngel = CGFloat.random(min: rad - 1, max: rad - 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: 120, startAngle: tempAngel, endAngle: tempAngel + CGFloat(CGFloat.pi * 4), clockwise: true)
            dot.position = path2.currentPoint
        } else if !movingClockwise {
            let tempAngel = CGFloat.random(min: rad + 1, max: rad + 2.5)
            let path2 = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2), radius: 120, startAngle: tempAngel, endAngle: tempAngel + CGFloat(CGFloat.pi * 4), clockwise: true)
            dot.position = path2.currentPoint
        }
        
        self.addChild(dot)
    }
    
    func moveClockWise() {
        
        let dx = person.position.x - self.frame.width / 2
        let dy = person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(CGFloat.pi * 4), clockwise: true)
        
        let follow = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        person.run(SKAction.repeatForever(follow).reversed())
    }
    
    func moveAntiClockWise() {
        let dx = person.position.x - self.frame.width / 2
        let dy = person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(CGFloat.pi * 4), clockwise: true)
        
        let follow = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        person.run(SKAction.repeatForever(follow))
    }
    
    func dotTouched() {
        if intersected {
            dot.removeFromParent()
            addDot()
            intersected = false
            
            currentScore -= 1
            levelLabel.text = "\(currentScore)"
            if currentScore <= 0 {
                nextLevel()
            }
        } else if !intersected {
            died()
        }
    }
    
    func nextLevel() {
        currentLevel += 1
        currentScore = currentLevel
        levelLabel.text = "\(currentScore)"
    }
    
    func died() {
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1, action2]))
        
        movingClockwise = false
        intersected = false
        gameStarted = false
        
        self.loadView()
    }
    
    
    //Update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if person.intersects(dot) {
            intersected = true
        } else {
            if intersected {
                if person.intersects(dot) == false {
                    died()
                }
            }
        }
    }
    
}
