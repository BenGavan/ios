//
//  ViewController.swift
//  TextFieldGrow
//
//  Created by Ben Gavan on 18/01/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        textView.font = UIFont.systemFont(ofSize: 40)
//        textView.isScrollEnabled = false
        return textView
    }()
    
    var textViewHeightConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.delegate = self
        
        self.view.addSubview(textView)
        
        textView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        textView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([textViewHeightConstraint])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == self.textView {
            let contentSize = textView.contentSize.height
            if contentSize > 40 {
                NSLayoutConstraint.deactivate([textViewHeightConstraint])
                textViewHeightConstraint.constant = contentSize
                NSLayoutConstraint.activate([textViewHeightConstraint])
            } else {
                if textViewHeightConstraint.constant == 40 {
                    
                } else {
                    NSLayoutConstraint.deactivate([textViewHeightConstraint])
                    textViewHeightConstraint.constant = 40
                    NSLayoutConstraint.activate([textViewHeightConstraint])
                }
            }
        }
        return true
    }

}

