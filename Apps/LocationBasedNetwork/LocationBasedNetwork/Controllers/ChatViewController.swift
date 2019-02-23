//
//  ChatViewController.swift
//  LocationBasedNetwork
//
//  Created by Ben Gavan on 31/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var mainNavigationController: MainNavigationController?
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            
            messages = friend?.messages
            
        }
    }
    
    var messages: [Message]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        mainNavigationController?.isNavigationBarHidden = false
        mainNavigationController?.navigationBar.backgroundColor = .white
        mainNavigationController?.navigationBar.alpha = 1
        mainNavigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(collectionView)
        _ = collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        
        let message = messages?[indexPath.row]
        
        cell.message = message
        cell.friend = friend
        
        if let messageText = message?.text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if (message?.isSentFromThisAccount)! {
                cell.messageTextView.frame = CGRect(x: self.view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBoubleView.frame = CGRect(x: self.view.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                
                //                cell.textBoubleView.backgroundColor = UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
                cell.bubbleImageView.image = ChatLogMessageCell.blueBoubleImage
                cell.messageTextView.textColor = .white
                cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
                
                cell.profileImageView.isHidden = true
            } else {
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBoubleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 4)
                
                //                cell.textBoubleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                cell.bubbleImageView.image = ChatLogMessageCell.grayBoubleImage
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = .black
                
                cell.profileImageView.isHidden = false
            }
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    
    
}












class ChatLogMessageCell: UICollectionViewCell {
    
    var message: Message? {
        didSet {
            if let text = message?.text {
                messageTextView.text = text
            }
            
            
        }
    }
    
    
    var friend: Friend? {
        didSet {
            if let profileImageName = friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
        }
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample Message Text"
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    let textBoubleView: UIView = {
        let view = UIView()
        //        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBoubleImage = UIImage(named: "bubble_gray")?.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    static let blueBoubleImage = UIImage(named: "bubble_blue")?.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.grayBoubleImage
        imageView.tintColor = UIColor(white: 0.95, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        self.addSubview(textBoubleView)
        self.addSubview(messageTextView)
        self.addSubview(profileImageView)
        
        _ = profileImageView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        textBoubleView.addSubview(bubbleImageView)
        _ = bubbleImageView.anchor(textBoubleView.topAnchor, left: textBoubleView.leftAnchor, bottom: textBoubleView.bottomAnchor, right: textBoubleView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

