//
//  ViewController.swift
//  AutoTextViewSizing
//
//  Created by Ben Gavan on 25/01/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        textView.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        textView.text = "Here is some default text that we want ro show and it might be a couple of lines that are word wrappded"
        view.addSubview(textView)

        // use autolayout to set my textview frame ..kinda
        textView.translatesAutoresizingMaskIntoConstraints = false
        [
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{ $0.isActive = true }
        
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.delegate = self
        
        textViewDidChange(textView)
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: self.view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
