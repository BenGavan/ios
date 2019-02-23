//
//  ViewController.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 02/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UITableViewController {
    
    private let cellId = "cellId"
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        observeMessages()
    }
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let message = Message()
            message.fromId = dictionary["fromId"] as? String
            message.text = dictionary["text"] as? String
            if let stamp = dictionary["timestamp"] as? String, let timeStamp = Int(stamp){
                message.timeStamp = timeStamp
            }
            message.toId = dictionary["toId"] as? String
            
            self.messages.append(message)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let message = messages[indexPath.row]
        
        if let toId = message.toId {
            let ref = Database.database().reference().child("users").child(toId)
            ref.observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    cell.textLabel?.text = dictionary["name"] as? String
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                        cell.profileImageView.loadImagaesUsingCache(with: profileImageUrl)
                    }
                }
            })
        }

        cell.detailTextLabel?.text = message.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
//                self.navigationItem.title = dictionary["name"]as? String
                
                let user = UserData()
                user.name = dictionary["name"]as? String
                user.email = dictionary["email"]as? String
                user.profileImageUrl = dictionary["profileImageUrl"]as? String
                
                self.setupNavBar(with: user)
            }
        }, withCancel: nil)
    }
    
    func setupNavBar(with user: UserData) {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        if let profileImageURL = user.profileImageUrl {
            profileImageView.loadImagaesUsingCache(with: profileImageURL)
        }
        
        containerView.addSubview(profileImageView)
        profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        nameLabel.isUserInteractionEnabled = true

        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true

        self.navigationItem.titleView = titleView
        titleView.isUserInteractionEnabled = true
        
//        self.navigationController?.navigationBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))

    }
    
    func showChatControllerFor(_ user: UserData) {
        let layout = UICollectionViewFlowLayout()
        let chatLogController = ChatLogController(collectionViewLayout: layout)
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    @objc private func handleNewMessage() {
        let newMessageController = NewMessageViewController()
        newMessageController.messagesController = self
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }

    @objc private func handleLogout() {
        do {
           try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        let loginViewController = LoginViewController()
        loginViewController.messagesController = self
        present(loginViewController, animated: true, completion: nil)
    }
}

