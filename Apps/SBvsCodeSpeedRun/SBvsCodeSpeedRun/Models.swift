//
//  Models.swift
//  SBvsCodeSpeedRun
//
//  Created by Ben Gavan on 01/02/2018.
//  Copyright © 2018 Ben Gavan. All rights reserved.
//

import Foundation

struct Company {
    let name: String
    let ceo: String
    let employees: [Employee]
    
    static let companies = [
            Company(name: "Apple", ceo: "Tim Cook", employees: [
                Employee(name: "Jon Ive"),
                Employee(name: "Craig F.")
                ]),
            Company(name: "Tesla", ceo: "Elon Musk", employees: [
                Employee(name: "Elon Musk"),
                Employee(name: "Tesla Fanboi")
                ])
    ]
}

struct Employee {
    let name: String
}
