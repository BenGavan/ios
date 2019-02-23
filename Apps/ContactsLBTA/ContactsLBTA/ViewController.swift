//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by Ben Gavan on 14/11/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {
    
    let cellId = "cellId"

    var showIndexPath = false
    
    var twoDimensionalArray = [ExpandableNames]()
    
//    var twoDimensionalArray = [
//        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Sam"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
//        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Callum"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
//        ExpandableNames(isExpanded: true, names: ["David", "Dan", "Dave"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
//        ExpandableNames(isExpanded: true, names: ["patrick", "Patty"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
//    ]
    
    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (isGranted, err) in
            if let err = err {
                print("Failed to request access to contacts", err)
                return
            }
            if isGranted {
                print("Access Granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    var favoritableContacts = [FavoritableContact]()
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first)
                        
                        favoritableContacts.append(FavoritableContact(contact: contact, hasFavorited: false))
                    })
                    
                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDimensionalArray = [names]
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                print("Access Denied")
            }
            
            
        }
    }
    
    func someMethodIWantToCall(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        print(indexPathTapped as Any)
        
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        
        let hasFavorited = contact.hasFavorited
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
//        tableView.reloadRows(at: [indexPathTapped], with: .fade)
        
        cell.accessoryView?.tintColor = hasFavorited ? .lightGray : .red
    }
    
    @objc func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
        showIndexPath = !showIndexPath
        
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContacts()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        return button
        
//        let label = UILabel()
//        label.text = "Header"
//        label.backgroundColor = .lightGray
//        return label
    }
    
    @objc func handleExpandClose(button: UIButton) {        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        
        let cell = ContactCell(style: .subtitle, reuseIdentifier: cellId)
        cell.link = self
        
        let favoritableContact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = favoritableContact.contact.givenName + " " + favoritableContact.contact.familyName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detailTextLabel?.text = favoritableContact.contact.phoneNumbers.first?.value.stringValue
        cell.accessoryView?.tintColor = favoritableContact.hasFavorited ? .red : .lightGray
        
        if showIndexPath {
//            cell.textLabel?.text = "\(favoritableContact.name) Section: \(indexPath.section) Row:\(indexPath.row)"
        }
        
        return cell
        
    }


}

