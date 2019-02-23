//
//  ViewController.swift
//  Table View Example
//
//  Created by Ben Gavan on 27/05/2017.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let people = [("Ben Gavan", "UK"),
                  ("Someone", "Monaco")]
    
    let videos = [("Salomondrin", "123 videos"),
                  ("Dedication Blog", "52 videos"),
                  ("The New Boston", "1000s Videos")]

    //how many sections in table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //return int, how many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return people.count
        }else{
            return videos.count
        }
        
    }
    
    //what is hte contents of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if indexPath.section == 0{
            let (personName, personLocation) = people[indexPath.row]
            cell.textLabel?.text = personName
        }else{
            cell.textLabel?.text = videos[indexPath.row].0
        }
    
        return cell
    }
    
    //Give each table section a title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "People"
        }else{
            return "Videos"
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

}

