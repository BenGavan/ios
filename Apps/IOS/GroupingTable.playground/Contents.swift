//: Playground - noun: a place where people can play

import UIKit

struct Person {
    let firstName: String
    let lastName: String
    let age: Int
}

let people = [
    Person(firstName: "Michael", lastName: "Jordan", age: 55),
    Person(firstName: "Kobe", lastName: "Bryant", age: 42),
    Person(firstName: "Magic", lastName: "Johnson", age: 61),
    Person(firstName: "Steph", lastName: "Curry", age: 28),
    Person(firstName: "Lebron", lastName: "James", age: 34),
    Person(firstName: "Kevin", lastName: "Durant", age: 28),
    Person(firstName: "Klay", lastName: "Thompson", age: 28),
    Person(firstName: "Charles", lastName: "Barkley", age: 55),
    Person(firstName: "Kenny", lastName: "Johnson", age: 56),
    Person(firstName: "Clyde", lastName: "Drexler", age: 61),
    Person(firstName: "Vince", lastName: "Carter", age: 41),
    Person(firstName: "James", lastName: "Harden", age: 28),
    Person(firstName: "Anthony", lastName: "Davis", age: 28),
    Person(firstName: "Vlade", lastName: "Divac", age: 55)
]

// how do we perform the grouping?

let groupedByAgeDictionary = Dictionary(grouping: people) { (person) -> Int in
    return person.age
}

let groupedDictionary = Dictionary(grouping: people) { (person) -> Character in
    return person.lastName.first!
}

var groupedPeople = [[Person]]()

let keys = groupedDictionary.keys.sorted()
keys.forEach { (key) in
    groupedPeople.append(groupedDictionary[key]!)
}

groupedPeople.forEach({
    $0.forEach({print($0)})
    print("---------")
})










