//
//  ViewController.swift
//  Dynamics Testing
//
//  Created by Ben Gavan on 31/05/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //create 2 shapes
    var greenSquare: UIView?
    var redSquare: UIView?
    var animator: UIDynamicAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()

        //create the shapes
        var dimentions = CGRect(x: 25, y: 25, width: 60, height: 60)
        greenSquare = UIView(frame: dimentions)
        greenSquare?.backgroundColor = UIColor.green
        
        dimentions = CGRect(x: 130, y: 25, width: 90, height: 90)
        redSquare = UIView(frame: dimentions)
        redSquare?.backgroundColor = UIColor.red
        
        //Add objects to screen
        self.view.addSubview(greenSquare!)
        self.view.addSubview(redSquare!)
        
        //Initialize the animator
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //Add gravity
        let gravity = UIGravityBehavior(items: [greenSquare!, redSquare!])
        let dirrection = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = dirrection
        
        //collision 
        let boundaries = UICollisionBehavior(items: [greenSquare!, redSquare!])
        boundaries.translatesReferenceBoundsIntoBoundary = true
        
        //Elasticity
        let bounce = UIDynamicItemBehavior(items: [greenSquare!, redSquare!])
        bounce.elasticity = 0.5
        
        animator?.addBehavior(bounce)
        animator?.addBehavior(boundaries)
        animator?.addBehavior(gravity)
    }
}

