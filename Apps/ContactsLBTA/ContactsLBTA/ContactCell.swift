//
//  ContactCell.swift
//  ContactsLBTA
//
//  Created by Ben Gavan on 01/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    weak var link: ViewController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc private func handleMarkAsFavorite() {
        link?.someMethodIWantToCall(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
