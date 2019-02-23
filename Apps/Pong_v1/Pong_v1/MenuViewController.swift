//
//  MenuViewController.swift
//  Pong_v1
//
//  Created by Ben Gavan on 24/06/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import UIKit

public enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuViewController: UIViewController {
    
    
    @IBAction func Player2(_ sender: Any) {
        launch(game: .player2)
    }
    
    
    @IBAction func Easy(_ sender: Any) {
        launch(game: .easy)
    }
    
    @IBAction func Medium(_ sender: Any) {
        launch(game: .medium)
    }
    
    @IBAction func Hard(_ sender: Any) {
        launch(game: .hard)
    }
    
    func launch(game: gameType){
        let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGame = game
        
        self.navigationController?.pushViewController(gameViewController, animated: true)
        
        
        
    }
    
    
}
