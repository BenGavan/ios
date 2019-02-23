

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let introLabel = childNode(withName: "introLabel")
        
        if(introLabel != nil){
            let fadeOutTrasition = SKAction.fadeOut(withDuration: 1.0)
            introLabel?.run(fadeOutTrasition, completion: { 
                let doors = SKTransition.doorway(withDuration: 1.5)
                let shooterScene = ShooterScene()
                self.view?.presentScene(shooterScene, transition: doors)
                
            })
        }
        
    }
    //Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {

    }
}
