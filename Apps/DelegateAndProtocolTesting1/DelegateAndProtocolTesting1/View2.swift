//
//  View1.swift
//  DelegateAndProtocolTesting1
//
//  Created by Ben Gavan on 08/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

//
//  LoginCell.swift
//  audibleLogin
//
//  Created by Ben Gavan on 28/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class View2: UIView {
    
    
    var loginButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Soon to be changed"
        return label
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(loginButton)
        
        _ = loginButton.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
    }
    
    func change(text: String) {
        loginButton.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





