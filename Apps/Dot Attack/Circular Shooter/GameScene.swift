//
//  GameScene.swift
//  Circular Shooter
//
//  Created by Ben Gavan on 06/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit

enum vibrateOptions: String {
    case on = "✔️"
    case off = "X"
    
    init(_ ix: Bool) {
        if (ix) {
            self =  vibrateOptions.on
        } else {
            self = vibrateOptions.off
        }
    }
}


struct PhysicsCategory {
    static let SmallBall: UInt32 = 0x1 << 0
    static let Enemy: UInt32 = 0x1 << 1
    static let MainBall: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate, GKGameCenterControllerDelegate {
    
    var viewController: GameViewController!
    
    var enemyTimer = Timer()
    var hits = 0
    var gameStarted = false
    var gameOver = false
    var gameCanStart = true
    var fadeoutVibrationSwitch = false
    var fadeinVibrationSwitch = false
    
    var isPhone = false
    
    var useVibration = Bool()
    
    var score = 0
    var highScore = 0
    
    let font = "STHeitiJ-Medium"
    
    // Nodes //
    // Main Ball Node
    var mainBall = SKSpriteNode(imageNamed: "WhiteBall")
    // Settings Label
    //    var settingsButton = SKSpriteNode(imageNamed: "settingsIcon")
    // Label Nodes
    lazy var tapToBeginLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.text = "Tap to Begin"
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        label.fontColor = UIColor.white
        label.zPosition = 2.0
        return label
    }()
    
    lazy var scoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.3)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "\(score)"
        label.name = "Score Label"
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
    
    lazy var gameOverLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 3)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "Game Over"
        label.zPosition = 2.0
        return label
    }()
    
    lazy var endScoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.15)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "\(self.score)"
        label.zPosition = 2.0
        return label
    }()
    
    lazy var newHighScoreLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.4)
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "New Highscore!"
        label.name = "newHighScoreLabel"
        label.zPosition = 2.0
        return label
    }()
    
    lazy var pauseButton: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.alpha = 0
        label.fontSize = self.frame.width / 15
        label.position = CGPoint(x: self.frame.width - (self.frame.width / 12), y: self.frame.height - (self.frame.width / 12))
        label.fontColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.text = "||"
        label.name = "pauseButton"
        label.zPosition = 2.0
        return label
    }()
    
    lazy var resumeLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        label.text = "Tap to Resume"
        label.alpha = 0
        label.fontSize = self.frame.width / 20
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 3)
        label.fontColor = UIColor.black
        label.zPosition = 2.0
        label.name = "resumeLabel"
        return label
    }()
    
    lazy var vibrateLabel: SKLabelNode = {
        let label = SKLabelNode.init(fontNamed: "STHeitiJ-Medium")
        return label
    }()
    
    lazy var leaderBoardNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "leaderboardImage")
        node.alpha = 1
        node.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        node.size = CGSize.init(width: self.frame.width / 9, height: self.frame.width / 9)
        node.position = CGPoint(x: (self.frame.width / 12), y: self.frame.height - (self.frame.width / 13))
        node.name = "leaderBoardButton"
        node.zPosition = 2.0
        return node
    }()
    
    lazy var vibrateSwitch: UISwitch = {
        let vs = UISwitch()
        return vs
    }()
    
    // Animations
    let fadingAnimation = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0), SKAction.fadeOut(withDuration: 1.0)])
    let redflashAnimationMain = SKAction.sequence([SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: TimeInterval(0.1)), SKAction.colorize(with: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0), colorBlendFactor: 1.0, duration: 0.1)])
    let fadeOutAnimation02 = SKAction.fadeOut(withDuration: 0.2)
    
    var enemies = [SKSpriteNode]()
    var smallBalls = [SKSpriteNode]()
    
    var timeLapsedSinceEnemyClean: Double = 0
    var prevousTime: Double = 0
    var fadeoutVibrationSwitchIterationCounter: Int = 0
    var fadeinVibrationSwitchIterationCounter: Int = 0
    
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        let setupUserDefaults = UserDefaults.standard
        
        if setupUserDefaults.value(forKey: "hasPlayedBefore") == nil {
            setupUserDefaults.set(true, forKey: "hasPlayedBefore")
        }
        
        highScore = UserDefaults.standard.getHighScore()
        saveHighscore(highScore)
        highScoreLabel.text = "HighScore: \(highScore)"

        
        // Get if user wants to use vibration
        if userDefaults.value(forKey: "vibration") != nil {
            useVibration = userDefaults.value(forKey: "vibration") as? Bool ?? true
        } else {
            userDefaults.set(true, forKey: "vibration")
        }
    
        print(userDefaults.value(forKey: "vibration") as! Bool)
        
        setupUserDefaults.synchronize()

        
        //////////////////////
        //        view.showsPhysics = true
        //////////////////////
        initGame()
    }
    
    
    func initGame() {
        gameOver = false
        hits = 0
        
        //Physics Contact Delegate
        self.physicsWorld.contactDelegate = self
        
        //Background color
        backgroundColor = UIColor.white
        
        // Nodes //
        self.addChild(highScoreLabel)
        self.addChild(scoreLabel)

        
        self.addChild(tapToBeginLabel)
        tapToBeginLabel.run(SKAction.repeatForever(fadingAnimation))
        
        
        //ScoreLabel
        
        
        //End of game ScoreLabel
        
        self.addChild(endScoreLabel)
        
        //New High Score Label
        
        self.addChild(newHighScoreLabel)
        
        //Gameover Label
        
        self.addChild(gameOverLabel)
        
        // Pause Label
        
        self.addChild(pauseButton)
        
        
        // Resume Label
        
        self.addChild(resumeLabel)
        
        // Leader Board Label
        
        self.addChild(leaderBoardNode)
        
        
        //        // Settings Button
        //        settingsButton.position = CGPoint.init(x: self.frame.width - (self.frame.width / 12), y: self.frame.width / 12)
        //        settingsButton.name = "settingsButton"
        //        settingsButton.alpha = 1.0
        //        settingsButton.size = CGSize.init(width: self.frame.width / 12, height: self.frame.width / 12)
        //        self.addChild(settingsButton)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            isPhone = true
            
            // Vibrate Label
            vibrateLabel.position = CGPoint.init(x: self.frame.width - 100, y: 15)
            vibrateLabel.fontColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
            vibrateLabel.fontSize = self.frame.width / 22
            vibrateLabel.name = "vibrateLabel"
            vibrateLabel.text = "Vibrate"
            vibrateLabel.alpha = 1.0
            self.addChild(vibrateLabel)
            
            // Vibrate Switch
            vibrateSwitch = UISwitch(frame: CGRect.init(x: self.frame.width - 60, y: self.frame.height - 40, width: 0, height: 0))
            vibrateSwitch.isOn = useVibration
            vibrateSwitch.setOn(useVibration, animated: true)
            vibrateSwitch.addTarget(self, action: #selector(GameScene.vibrateSwitchChanged), for: .valueChanged)
            vibrateSwitch.onTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
            self.view?.addSubview(vibrateSwitch)
            
        }
        
        
        // Main Ball
        mainBall = NodeBuilder.createMainBall(for: self.frame.size)
        self.addChild(mainBall)
        
        authenticateLocalPlayer()
        
        if UserDefaults.standard.value(forKey: "hasUpdatedTo1.2.0") == nil {
            saveHighscore(highScore)
            print("worked")
            UserDefaults.standard.set(true, forKey: "hasUpdatedTo1.2.0")
        }
    }
    
    // Game Over = false
    @objc func setGameCanStartTrue() {
        gameCanStart = true
        print("gamecanStart = true")
    }
    
    func initEnemyTimer() {
        enemyTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(GameScene.createEnemy), userInfo: nil, repeats: true)
    }
    
    @objc func vibrateSwitchChanged() {
        let userDefaults = UserDefaults.standard
        
        if (vibrateSwitch.isOn) {
            userDefaults.set(true, forKey: "vibration")
            useVibration = true
            print("vibration = true")
        } else if (vibrateSwitch.isOn == false) {
            userDefaults.set(false, forKey: "vibration")
            useVibration = false
            print("vibration = false")
        }
    }
    
    // Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchedAtLeaderBoardLabel = false
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "leaderBoardButton" {
                touchedAtLeaderBoardLabel = true
                showLeader()
            }
        }
        
        if !touchedAtLeaderBoardLabel {
            if !gameStarted {
                if gameCanStart {
                    if gameOver {
                        // Game Has started
                        gameStarted = true
                        gameOver = false
                        
                        gameOverLabel.removeAllActions()
                        gameOverLabel.run(SKAction.fadeOut(withDuration: 0.2))
                        
                        endScoreLabel.removeAllActions()
                        endScoreLabel.run(SKAction.fadeOut(withDuration: 0.2))
                        
                        newHighScoreLabel.removeAllActions()
                        newHighScoreLabel.run(SKAction.fadeOut(withDuration: 0.2))
                    }
                    
                    // init enemy Timer
                    initEnemyTimer()
                    
                    // Add Main Ball collision detection back
                    self.mainBall.physicsBody?.categoryBitMask = PhysicsCategory.MainBall
                    self.mainBall.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
                    self.mainBall.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
                    
                    gameStarted = true
                    hits = 0
                    
                    // Fade out Tap to Begin Label w/ durration 0.2
                    tapToBeginLabel.removeAllActions()
                    tapToBeginLabel.run(SKAction.fadeOut(withDuration: 0.2))
                    
                    // Fade out Leader board button (sprite) w/ durration 0.2
                    leaderBoardNode.removeAllActions()
                    leaderBoardNode.run(SKAction.fadeOut(withDuration: 0.2))
                    
                    // Fade out High score Label w/ durration 0.2
                    highScoreLabel.removeAllActions()
                    highScoreLabel.run(SKAction.fadeOut(withDuration: 0.2))
                    
                    if isPhone {
                        // Fade out Vibrate Label w/ durration 0.2
                        vibrateLabel.removeAllActions()
                        vibrateLabel.run(SKAction.fadeOut(withDuration: 0.2))
                        
                        // Fade out Vibrate Switch /w durration 0.2
                        fadeoutVibrationSwitch = true
                        print("fadeout Request")
                    }
                    
                    // fade in Pause Button/Label w/ durration 0.2
                    pauseButton.removeAllActions()
                    pauseButton.run(SKAction.fadeIn(withDuration: 0.2))
                    
                    // Wait 1 second and then fade in Score Label w/ durration 1
                    scoreLabel.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeIn(withDuration: 1.0)]))
                    
                    score = 0
                    scoreLabel.text = "\(score)"
                    //                scoreLabel.text = "6"
                    
                }
            } else {
                if (self.isPaused){  // User resuming Game
                    //Remove Resume Label
                    resumeLabel.removeAllActions()
                    resumeLabel.run(SKAction.fadeOut(withDuration: 0.2))
                    
                    if (isPhone) {
                        // Remove Vibrate Label w/ duration 0.2
                        vibrateLabel.removeAllActions()
                        vibrateLabel.run(SKAction.fadeOut(withDuration: 0.2))
                        
                        // Remove Vibrate Switch w/ duration 0.2
                        fadeoutVibrationSwitch = true
                        print("fadeout request")
                    }
                    
                    // Re-Initialise enemy timer
                    initEnemyTimer()
                    // Game is no longer in pause state
                    self.isPaused = false
                    // Spawn enemy
                    createEnemy()
                    //Make Pause Button Visible
                    pauseButton.run(SKAction.fadeIn(withDuration: 0.2))
                    
                    
                    
                } else {
                    for touch in touches {
                        let location = touch.location(in: self)
                        
                        if atPoint(location).name == "pauseButton" {
                            if (self.isPaused) {
                                self.isPaused = false
                            } else {
                                self.isPaused = true
                                // Stop enemy timer/ stop spawning Enemies
                                enemyTimer.invalidate()
                                
                                //make Resume Label Visible
                                resumeLabel.alpha = 1.0
                                
                                if isPhone {
                                    //Show Vibrate Label and Switch
                                    vibrateLabel.alpha = 1.0
                                    vibrateSwitch.alpha = 1.0
                                }
                                
                                // Set Pause button not Visible (alpha = 0) whilst Game is Paused
                                pauseButton.alpha = 0
                                
                            }
                            
                        } else {
                            
                            let smallBall = SKSpriteNode(imageNamed: "WhiteBall")
                            smallBall.position = mainBall.position
                            smallBall.size = CGSize(width: self.frame.width / CGFloat(24), height: self.frame.width / CGFloat(24))
                            smallBall.physicsBody = SKPhysicsBody(circleOfRadius: smallBall.size.width / CGFloat(2))
                            smallBall.physicsBody?.affectedByGravity = true
                            smallBall.color = UIColor(red: 0.1, green: 0.65, blue: 0.9, alpha: 1)
                            smallBall.colorBlendFactor = CGFloat(1)
                            //physics
                            smallBall.physicsBody?.categoryBitMask = PhysicsCategory.SmallBall
                            smallBall.physicsBody?.collisionBitMask = PhysicsCategory.Enemy
                            smallBall.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
                            smallBall.name = "SmallBall"
                            smallBall.physicsBody?.mass = CGFloat(100000)
                            smallBall.physicsBody?.isDynamic = true
                            smallBall.physicsBody?.affectedByGravity = false
                            
                            self.addChild(smallBall)
                            
                            var dx = CGFloat(CGFloat(location.x) - CGFloat(mainBall.position.x))
                            var dy = CGFloat(CGFloat(location.y) - CGFloat(mainBall.position.y))
                            
                            let magnitude = CGFloat(sqrt(dx * dx + dy * dy))
                            
                            dx /= magnitude
                            dy /= magnitude
                            
                            let vector = CGVector(dx: CGFloat(CGFloat(500) * dx), dy: CGFloat(CGFloat(500) * dy))
                            
//                            smallBall.physicsBody?.applyImpulse(vector)
                            smallBall.physicsBody?.velocity = vector
                            
                            smallBalls.append(smallBall)
                        }
                    }
                }
            }
        }
    }
    
    
    // Contact Listener
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node != nil && contact.bodyB.node != nil {
            let firstBody = contact.bodyA.node as! SKSpriteNode
            let secondBody = contact.bodyB.node as! SKSpriteNode
            
            if ((firstBody.name == "Enemy") && (secondBody.name == "SmallBall")) {
                collisionBullet(enemy: firstBody, smallBall: secondBody)
            } else if ((firstBody.name == "SmallBall") && (secondBody.name == "Enemy")) {
                collisionBullet(enemy: secondBody, smallBall: firstBody)
            } else if ((firstBody.name == "MainBall") && (secondBody.name == "Enemy")) {
                collisionMain(enemy: secondBody)
                print("collision")
                
            } else if ((firstBody.name == "Enemy") && (secondBody.name == "MainBall")) {
                collisionMain(enemy: firstBody)
                print("collision")
                
            }
        }
    }
    
    //Main Ball Hit Reaction
    func collisionMain(enemy: SKSpriteNode) {
        print("collisionMain")
        if hits < 2 {
            
            hits += 1   // Increase Hit counter by 1 (max 3)
            
            // Shrink and add red flask animation to the main  ball
            mainBall.run(SKAction.scale(by: 0.5, duration: 0.4))
            mainBall.run(redflashAnimationMain)
            
            //Vibrate
            if useVibration {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
            // Remove enemy which has collided
            enemy.physicsBody?.affectedByGravity = true
            enemy.removeAllActions()
            enemy.removeFromParent()
            
            
        } else {
            // Remove enemy which has collided
            enemy.physicsBody?.affectedByGravity = true
            enemy.removeAllActions()
            enemy.removeFromParent()
            ///// GAME OVER /////
            gameOverReset()
        }
    }
    
    func gameOverReset() {
        
        gameStarted = false
        gameOver = true
        gameCanStart = false
        print("Game Over")
        
        //Vibrate
        if isPhone && useVibration {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        //Start timer till player can restart again
        Timer.scheduledTimer(timeInterval: TimeInterval(0.8), target: self, selector: #selector(GameScene.setGameCanStartTrue), userInfo: nil, repeats: false)
        
        for enemyHolder in enemies {
            enemyHolder.removeAllActions()
            enemyHolder.physicsBody?.affectedByGravity = true
            enemyHolder.run(SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.run {
                enemyHolder.removeAllActions()
                enemyHolder.removeFromParent()
                }]))
        }
        
        for smallBallHolder in smallBalls {
            smallBallHolder.removeAllActions()
            smallBallHolder.physicsBody?.affectedByGravity = true
            smallBallHolder.physicsBody?.mass = CGFloat(5)
            smallBallHolder.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run {
                smallBallHolder.removeAllActions()
                smallBallHolder.removeFromParent()
                }]))
        }
        
        enemies.removeAll()
        smallBalls.removeAll()
        
        enemyTimer.invalidate()
        
        mainBall.removeAllActions()
        
        mainBall.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.run {
            print("running")
            self.mainBall.removeAllActions()
            self.mainBall.removeFromParent()
            self.mainBall = NodeBuilder.createMainBall(for: self.frame.size)
            self.mainBall.alpha = 0
            self.addChild(self.mainBall)
            self.mainBall.run(SKAction.fadeIn(withDuration: 0.5))
            self.mainBall.physicsBody?.collisionBitMask = 0
            self.mainBall.physicsBody?.categoryBitMask = 0
            self.mainBall.physicsBody?.contactTestBitMask = 0
            } ]))
        
        scoreLabel.run(SKAction.fadeOut(withDuration: 0.3))
        
        highScoreLabel.run(SKAction.fadeIn(withDuration: 0.3))
        
        
        if score > highScore {
            highScore = score
            
            UserDefaults.standard.setHighScore(value: highScore)
            
            print(UserDefaults.standard.getHighScore())
            
            highScoreLabel.text = "Highscore: \(highScore)"
            
            // Show/Fade in New High Score Label w/ duration 0.2
            newHighScoreLabel.run(SKAction.fadeIn(withDuration: 0.2))
            newHighScoreLabel.run(SKAction.repeatForever(fadingAnimation))
            
            saveHighscore(highScore)
        }
        
        print("Reset Game")
        
        // Remove/Fade out Puase button w/ duration 0.2
        pauseButton.removeAllActions()
        pauseButton.run(SKAction.fadeOut(withDuration: 0.2))
        
        // Show/Fade in Game Over Label w/ duration 0.2
        gameOverLabel.run(SKAction.fadeIn(withDuration: 0.2))
        gameOverLabel.run(SKAction.sequence([SKAction.repeat(fadingAnimation, count: 10), SKAction.fadeOut(withDuration: 0.4)]))
        
        // Show/Fade in Tap to begin Label w/ durration 0.2
        tapToBeginLabel.run(SKAction.fadeIn(withDuration: 0.2))
        tapToBeginLabel.run(SKAction.repeatForever(fadingAnimation))
        
        // Show/Fade in Leader Board Label w/ durration 0.2
        leaderBoardNode.removeAllActions()
        leaderBoardNode.run(SKAction.fadeIn(withDuration: 0.2))
        
        // Show/Fade in End Score Label w/ durration 0.2
        endScoreLabel.run(SKAction.fadeIn(withDuration: 0.2))
        endScoreLabel.text = "Score: \(score)"
        
        if isPhone {
            // Show/Fade in Vibrate Label w/ durration 0.2
            vibrateLabel.removeAllActions()
            vibrateLabel.run(SKAction.fadeIn(withDuration: 0.2))
            
            // Show/Fade in Vibrate Switch
            fadeinVibrationSwitch = true
            print("fade In Request")
        }
    }
    
    
    func collisionBullet(enemy: SKSpriteNode, smallBall: SKSpriteNode) {
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.mass = CGFloat(5)
        enemy.removeAllActions()
        
//        smallBall.physicsBody?.mass = CGFloat(5)
//        smallBall.removeAllActions()
        
        enemy.physicsBody?.contactTestBitMask = UInt32(0)
        enemy.physicsBody?.collisionBitMask = UInt32(0)
        enemy.name = nil
        
        score += 1
        scoreLabel.text = "\(score)"
        //        scoreLabel.text = "6"
        
    }
    
    @objc func createEnemy() {
        
        let enemy = NodeBuilder.createEnemyBall(for: self.frame.size)
        
        let randomPositionNumber = UInt32(UInt32(arc4random()) % UInt32(4))
        
        switch randomPositionNumber {
        case 0:
            enemy.position.x = 0
            let positionY = UInt32(arc4random_uniform(UInt32(self.frame.size.height)))
            enemy.position.y = CGFloat(positionY)
            self.addChild(enemy)
        case 1:
            enemy.position.y = 0
            let positionX = UInt32(arc4random_uniform(UInt32(self.frame.size.width)))
            enemy.position.x = CGFloat(positionX)
            self.addChild(enemy)
        case 2:
            enemy.position.x = self.frame.size.width
            let positionY = UInt32(arc4random_uniform(UInt32(self.frame.size.height)))
            enemy.position.y = CGFloat(positionY)
            self.addChild(enemy)
        case 3:
            enemy.position.y = self.frame.size.height
            let positionX = UInt32(arc4random_uniform(UInt32(self.frame.size.width)))
            enemy.position.x = CGFloat(positionX)
            self.addChild(enemy)
        default:
            break
            
        }
        
        enemy.run(SKAction.move(to: CGPoint.init(x: self.frame.width / CGFloat(2), y: self.frame.height / CGFloat(2)), duration: TimeInterval(3)))
        
        enemies.append(enemy)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //        if prevousTime != 0 {
        //            timeLapsedSinceEnemyClean += (currentTime - prevousTime)
        ////            print(timeLapsedSinceEnemyClean)
        //            if timeLapsedSinceEnemyClean > 3 {
        //                if enemies.count > 12 {
        //                }
        //            }
        //        } else {
        //            prevousTime = currentTime
        //            print(currentTime)
        //        }
        
        
        if (enemies.count > 5) {
            var counter = -1
            for enemy in enemies {
                counter += 1
                if ((enemy.position == CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2)) || enemy.position.x < -20 || enemy.position.x > self.frame.width + 20 || enemy.position.y < -20 || enemy.position.y > self.frame.height + 20) {
                    enemy.removeAllActions()
                    enemy.removeFromParent()
                    if (counter < enemies.count) {
                        enemies.remove(at: counter)
                    }
                }
            }
        }
        
        var smallBallsIndexsDelete = [Int]()
        
        if (smallBalls.count > 5){
            var counter = -1
            for ball in smallBalls {
                counter += 1
                if (ball.position.x < -20 || ball.position.x > self.frame.width + 20 || ball.position.y < -20 || ball.position.y > self.frame.height + 20) {
                    ball.removeAllActions()
                    ball.removeFromParent()
                    if (counter < smallBalls.count) {
                        print(counter)
                        print(smallBalls.count - 1)
                        smallBalls.remove(at: counter)
                        smallBallsIndexsDelete.append(counter)
                    }
                }
            }
        }
        
        if isPhone {
            
            if (fadeoutVibrationSwitch && fadeoutVibrationSwitchIterationCounter <= 12 ) {
                vibrateSwitch.alpha -= 1 / 12
                fadeoutVibrationSwitchIterationCounter += 1
                print(vibrateSwitch.alpha)
                
                if (fadeoutVibrationSwitchIterationCounter >= 12) {
                    fadeoutVibrationSwitch = false
                    fadeoutVibrationSwitchIterationCounter = 0
                    vibrateSwitch.alpha = 0
                }
            }
            
            
            if (fadeinVibrationSwitch && fadeinVibrationSwitchIterationCounter <= 12 && vibrateSwitch.alpha <= 1.1) {
                vibrateSwitch.alpha += 1 / 12
                fadeinVibrationSwitchIterationCounter += 1
                print(vibrateSwitch.alpha)
                if (fadeinVibrationSwitchIterationCounter >= 12) {
                    fadeinVibrationSwitch = false
                    fadeinVibrationSwitchIterationCounter = 0
                    vibrateSwitch.alpha = 1
                }
            }
        }
        
        
        
    }
    
    
    /// Leader Board ////
    
    func updateHighScore() {
        if UserDefaults.standard.value(forKey: "HighScore") != nil {
            highScore = UserDefaults.standard.value(forKey: "HighScore") as! Int
            highScoreLabel.text = "HighScore: \(highScore)"
            saveHighscore(highScore)
        }
    }
    
    //send high score to leaderboard
    func saveHighscore(_ score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "com.bgsoftwarestudios.dotattackgame.mainleaderboard") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            let scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: { (error) in
                if error != nil {
                    print("error")
                } else {
                    print("Success: Score reported")
                }
            })
            
            //            GKScore.reportScores(scoreArray, {(error : NSError!) -> Void in
            //                if error != nil {
            //                    println("error")
            //                }
            //            })
            
        } else {
            print("Player is not authenticated")
        }
        
    }
    
    //shows leaderboard screen
    func showLeader() {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let vc = self.view?.window?.rootViewController
            let gc = GKGameCenterViewController()
            gc.gameCenterDelegate = self
            vc?.present(gc, animated: true, completion: nil)
        } else {
            authenticateLocalPlayer()
        }
        
    }
    
    //hides leaderboard screen
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }
    
    //initiate gamecenter
    func authenticateLocalPlayer(){
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                let vc = self.view?.window?.rootViewController
                vc?.present(viewController!, animated: true, completion: nil)
            } else {
                print((GKLocalPlayer.localPlayer().isAuthenticated))
            }
        }
    }
    
    
}















