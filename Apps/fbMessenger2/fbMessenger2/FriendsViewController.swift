//
//  ViewController.swift
//  fbMessenger
//
//  Created by Ben Gavan on 25/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

extension UIColor {
    
    /// - Parameter alpha: default = 1
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: Double = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: CGFloat(alpha))
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}

import UIKit
import CoreData

class FriendsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
//    var messages = [Message]()
    
    lazy var fetchResultsController: NSFetchedResultsController<Friend> = {
        
        let fetchRequest = NSFetchRequest<Friend>(entityName: "Friend")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false )] //sorts by date
        fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")

        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        collectionView?.backgroundColor = .white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        setupdata()
        
        do {
            try fetchResultsController.performFetch()
            
        } catch let error {
            print(error)
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Mark", style: .plain, target: self, action: #selector(addMark))
    }
    
    @objc private func addMark() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchResultsController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        let friend = fetchResultsController.object(at: indexPath) 
        
        cell.message = friend.lastMessage

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        let friend = fetchResultsController.object(at: indexPath)

        controller.friend = friend
        navigationController?.pushViewController(controller, animated: true)
    }
}

class MessageCell: BaseCell {
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = Date().timeIntervalSince(date)
                let dayInSeconds: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * dayInSeconds {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elapsedTimeInSeconds > dayInSeconds {
                    dateFormatter.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "A Friends Message and something else to make this text a little bit longer"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor(red: 0, green: 134 / 255, blue: 249 / 255, alpha: 1)
 : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            timeLabel.textColor = isHighlighted ? .white : .black
            messageLabel.textColor = isHighlighted ? .white : .black

            print(isHighlighted)
        }
    }
    
    override func setupViews() {
        self.backgroundColor = .white

        self.addSubview(profileImageView)
        self.addSubview(dividerLineView)
        
        setupContainerView()
        
        _ = profileImageView.anchor(nil, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 68, heightConstant: 68)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        _ = dividerLineView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 82, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        self.addSubview(containerView)
        
        _ = containerView.anchor(self.topAnchor, left: profileImageView.rightAnchor, bottom: dividerLineView.topAnchor, right: self.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 20, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        _ = nameLabel.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: timeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 30)
        
        _ = timeLabel.anchor(nameLabel.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 80, heightConstant: 30)
        
        _ = messageLabel.anchor(nameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: hasReadImageView.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        _ = hasReadImageView.anchor(timeLabel.bottomAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 20, heightConstant: 20)
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .blue
    }
}

