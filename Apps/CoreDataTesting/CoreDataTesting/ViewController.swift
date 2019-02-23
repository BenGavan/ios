//
//  ViewController.swift
//  CoreDataTesting
//
//  Created by Ben Gavan on 16/12/2017.
//  Copyright © 2017 Ben Gavan. All rights reserved.
//

import UIKit
import CoreData

enum UsersKeys: String {
    case username = "username"
    case password = "password"
}

class ViewController: UIViewController {
    
    var usernames: [String] = []
    var passwords: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Storing core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let username = result.value(forKey: UsersKeys.username.rawValue) as? String {
                        usernames.append(username)
                    }
                    
                    if let password = result.value(forKey: UsersKeys.password.rawValue) as? String {
                        passwords.append(password)
                    }
                }
                print(usernames)
                print(passwords)
            }
        } catch {
            // Process Error
        }
        
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
//        newUser.setValue("Jennifer", forKey: UsersKeys.username.rawValue)
//        newUser.setValue("Jenny123", forKey: UsersKeys.password.rawValue)
//
//        do {
//            try context.save()
//            print("Saved")
//        } catch {
//            // Process error
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

