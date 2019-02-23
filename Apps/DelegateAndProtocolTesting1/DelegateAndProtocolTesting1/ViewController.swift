//
//  ViewController.swift
//  DelegateAndProtocolTesting1
//
//  Created by Ben Gavan on 08/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

protocol View1ButtonHandlerDelegate: class {
    func finishLoggingIn()
}

class ViewController: UIViewController, View1ButtonHandlerDelegate {

    var view1 = View1()
    var view2 = View2()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        
        view1.delegate = self
    
        view.addSubview(view1)
        view.addSubview(view2)
        
        
        _ = view1.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
        
        _ = view2.anchor(view1.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testFinction (){
        
    }

    
    func finishLoggingIn() {
        view2.change(text: "Success")
        view1.changeButton(text: "I've beed pressed")
        
        
        print("Success")
        
        
    }

}

