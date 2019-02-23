//
//  LoginPageCell.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 14/10/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

//
//  PageCell.swift
//  audibleLogin
//
//  Created by Ben Gavan on 27/09/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: IntroPage? {
        didSet {
            
            guard let page = page else { return }
            
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape {
                imageName += "_landscape"
            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedString.Key.foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            //            textView.text = page.title + "\n\n" + page.message
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.isEditable = false
        tv.backgroundColor = .white
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        imageView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.safeAreaLayoutGuide.bottomAnchor,
                         trailing: self.trailingAnchor)
//        imageView.anchorToTop(self.topAnchor, left: self.leftAnchor, bottom: textView.topAnchor, right: self.rightAnchor)
        
        textView.anchor(top: nil,
                        leading: self.leadingAnchor,
                        bottom: self.bottomAnchor,
                        trailing: self.trailingAnchor,
                        padding: .init(top: 0, left: 16, bottom: 0, right: 16),
                        height: self.frame.size.height * 0.3)
        
        
//        textView.anchorWithConstantsToTop(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        
//        textView.heightAnchor.constraint(equalToConstant: self.frame.size.height * 0.3).isActive = true
        
        lineSeparatorView.anchor(top: nil,
                                 leading: self.leadingAnchor,
                                 bottom: textView.topAnchor,
                                 trailing: self.trailingAnchor,
                                 height: 1)
        
//        lineSeparatorView.anchorToTop(nil, left: self.leftAnchor, bottom: textView.topAnchor, right: self.rightAnchor)
//        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

