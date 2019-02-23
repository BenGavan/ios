//
//  ChatLogController.swift
//  fbMessenger2
//
//  Created by Ben Gavan on 19/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import CoreData

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            
//            messages = friend?.message?.allObjects as? [Message]
//
//            messages?.sort(by: { (message1, message2) -> Bool in
//                if message1.date! < message2.date! {
//                    return true
//                } else {
//                    return false
//                }
//            })
        }
    }
    
//    var messages: [Message]?
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor.rgb(r: 0, g: 137, b: 149)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    private let topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    @objc private func simulate() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = delegate?.persistentContainer.viewContext else { return }
        
        _ = FriendsViewController.createMessageWith(text: "Heres a text message that was sent a few messages ago", friend: friend!, minutesAgo: 0.225, context: context, isSender: false)
        
        _ = FriendsViewController.createMessageWith(text: "Heres Another text message that was sent a few messages ago", friend: friend!, minutesAgo: 0.225, context: context, isSender: false)

        do {
            try context.save()
            
//            messages?.append(message)
//
//            messages?.sort(by: { (message1, message2) -> Bool in
//                if message1.date! < message2.date! {
//                    return true
//                } else {
//                    return false
//                }
//            })
//
//            if let item = messages?.index(of: message) {
//                let receivingIndexPath = IndexPath(item: item, section: 0)
//                collectionView?.insertItems(at: [receivingIndexPath])
//            }
            
        } catch let error {
            print(error)
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Message> = {
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true )] //sorts by date
        fetchRequest.predicate = NSPredicate(format: "friend.name = %@", self.friend!.name!)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    var blockOperations = [BlockOperation]()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        guard let indexPath = newIndexPath else { return }
        
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: [indexPath])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            
            for operation in self.blockOperations {
                operation.start()
            }
            
        }, completion: { (isCompleted) in
            let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
            let indexPath = IndexPath(item: lastItem, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
            
            print(fetchedResultsController.sections?[0].numberOfObjects)
        } catch let error {
            print(error)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .plain, target: self, action: #selector(simulate))
        
        tabBarController?.tabBar.isHidden = true
        
        self.collectionView?.backgroundColor = .white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(messageInputContainerView)
        
        bottomConstraint = messageInputContainerView.anchor(nil, left: self.view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 48)[1]
        
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
        
    private func setupInputComponents() {
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        _ = topBorderView.anchor(messageInputContainerView.topAnchor, left: messageInputContainerView.leftAnchor, bottom: nil, right: messageInputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
        _ = inputTextField.anchor(topBorderView.bottomAnchor, left: messageInputContainerView.leftAnchor, bottom: messageInputContainerView.bottomAnchor, right: sendButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = sendButton.anchor(topBorderView.bottomAnchor, left: inputTextField.rightAnchor, bottom: messageInputContainerView.bottomAnchor, right: messageInputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 50, heightConstant: 0)
    }
    
    @objc private func handleSend() {
        guard let inputText = inputTextField.text else { return }
        if inputText.count <= 0 { return }
        let delegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = delegate?.persistentContainer.viewContext else { return }

        guard let friend = friend else { return }
        _ = FriendsViewController.createMessageWith(text: inputText, friend: friend, minutesAgo: 0, context: context, isSender: true)
        do {
            try context.save()
            inputTextField.text = nil

            
//
//            messages?.append(message)
//
//            let item = (messages?.count)! - 1
//            let insertionIndexPath = IndexPath(item: item, section: 0)
//
//            collectionView?.insertItems(at: [insertionIndexPath])
//            collectionView?.scrollToItem(at: insertionIndexPath, at: .bottom, animated: true)
            
        } catch let error {
            print(error)
        }
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardFrame = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect)!
        
        let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
        
        bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame.height : 0
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            if isKeyboardShowing {
                let lastItem = self.fetchedResultsController.sections![0].numberOfObjects - 1
                let indexPath = IndexPath(item: lastItem, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = fetchedResultsController.sections?[0].numberOfObjects else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = fetchedResultsController.object(at: indexPath) as! Message
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        cell.message = message
        
        if let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if message.isSender {
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
        
        let message = fetchedResultsController.object(at: indexPath) as! Message
        
        if let messageText = message.text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: self.view.frame.width, height: estimatedFrame.height + 20)
        }
        
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
    }
}

class ChatLogMessageCell: UICollectionViewCell {
    
    var message: Message? {
        didSet {
            if let text = message?.text {
                messageTextView.text = text
            }
            
            if let profileImageName = message?.friend?.profileImageName {
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






