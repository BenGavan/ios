//
//  NewMessagesTableViewController.swift
//  ChatAppFirebase
//
//  Created by Ben Gavan on 03/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UITableViewController {
    
    private let cellId = "cellId"
    
    private var users = [UserData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    private func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserData()
                user.id = snapshot.key
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImageUrl = dictionary["profileImageUrl"] as? String
                self.users.append(user)
                print(user.name as Any, user.email as Any)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }

    @objc private func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
//        cell.imageView?.image = UIImage(named: "nedstark")
//        cell.imageView?.contentMode = .scaleAspectFill
        
        if let profileImageUrl = user.profileImageUrl {
            
            cell.profileImageView.loadImagaesUsingCache(with: profileImageUrl)
//            let url = URL(string: profileImageUrl)
//            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//                if error != nil {
//                    print(error)
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    cell.profileImageView.image = UIImage(data: data!)
//                }
//
//            }).resume()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("dismiss completed")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerFor(user)
        }
    }
}



