//
//  ShooterScene.swift
//  BuckyBlaster
//
//  Created by Ben Gavan on 03/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import SpriteKit

class ShooterScene: SKScene {
    
    var score = 0
    var enemyCount = 10
    var shooterAnimation = [SKTexture]()

    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector.init(dx: 0, dy: -1.2))
        self.initShooterScene()
    }
    
    
    func initShooterScene(){
        let shooterAtlas = SKTextureAtlas(named: "shooter")
        
        for index in 1...shooterAtlas.textureNames.count{
            let imgName = String(format: "shooter%01d", index)
            shooterAnimation += [shooterAtlas.textureNamed(imgName)]
        }
        
        //Drop the balls from the top
        let dropBallsAnimation = SKAction.sequence([SKAction.run({ 
            self.createBallNode()}),
            SKAction.wait(forDuration: 2.0)])
        
        self.run(SKAction.repeat(dropBallsAnimation, count: enemyCount), completion: nil)
    }
    
    //Animate shooter
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let shooterNode = self.childNode(withName: "shooterNode")
        
        if(shooterNode != nil){
            let animation = SKAction.animate(withNormalTextures: shooterAnimation, timePerFrame: 0.1)
            
            //shotting the bullet
            let shootBullet = SKAction.run({ 
                let bulletNode = self.createBulletNode()
                self.addChild(bulletNode)
                bulletNode.physicsBody?.applyImpulse(CGVector.init(dx: 160.0, dy: 0))
            })
            
            let sequenceAnimation = SKAction.sequence([animation, shootBullet])
            shooterNode?.run(sequenceAnimation)
        }
    }
    
    //Create Bullet node
    func createBulletNode() -> SKSpriteNode{
        let shooterNode = self.childNode(withName: "shooterNode")
        let shooterPosition = shooterNode?.position
        let shooterWidth = shooterNode?.frame.size.width
        
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        bullet.position = CGPoint(x: shooterPosition!.x + shooterWidth!/2, y: shooterPosition!.y)
        bullet.name = "bulletNode"
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        return bullet
    }
    
    //create new ball
    func createBallNode(){
        let ball = SKSpriteNode(imageNamed: "starball.png")
        ball.position = CGPoint.init(x: randomNumber(maximum: self.size.width), y: self.size.height)
        ball.name = "ballNode"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(ball)
    }
    
    //Random Number (between 0 and width)
    func randomNumber(maximum: CGFloat) -> CGFloat{
        let maxInt = UInt32(maximum)
        let result = arc4random_uniform(maxInt)
        return CGFloat(result)
    }
}
