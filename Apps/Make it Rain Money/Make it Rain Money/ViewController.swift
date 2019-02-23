//
//  ViewController.swift
//  Make it Rain Money
//
//  Created by Ben Gavan on 03/07/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var score: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func manualMoneyClicked(_ sender: UIButton) {
        score += 1
        updateScoreLabel(with: score)
    }

    func updateScoreLabel(with score: Int) {
        scoreLabel.text = "$\(score)"
    }
    
    @IBAction func contantIncomePressed(_ sender: UIButton) {
        
        
        
        
    }
    @IBAction func moveToBuyView(_ sender: Any) {
        
        
    }
}

