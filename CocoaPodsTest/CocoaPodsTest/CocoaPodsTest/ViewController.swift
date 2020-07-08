//
//  ViewController.swift
//  CocoaPodsTest
//
//  Created by Ben Gavan on 03/06/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

import UIKit
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0

    internal init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    required init() {
        print("used init()")
    }
}

class Person: Object {
    @objc dynamic var uuid = ""
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil // Optionals supported
    var dogs = List<Dog>()
    
    func update(with person: Person) {
        self.name = person.name
        self.picture = person.picture
        for dog in self.dogs {
            print("about to delete:", dog)
            realm?.delete(dog)
        }
        self.dogs = person.dogs
    }
}


func randomString(of length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var s = ""
    for _ in 0 ..< length {
        s.append(letters.randomElement()!)
    }
    return s
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray

        let uuid = randomString(of: 10)

        addOwner(with: uuid)
//        getOwner()
//        changeNameOfOwner(with: uuid)
        testOR()
    }

    private func test() {
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("Dog name: \(myDog.name), Dog age: \(myDog.age)")

        let realm = try! Realm() // Get the default for Realm

        let puppies = realm.objects(Dog.self).filter("age < 10")
        print("Puppies count: \(puppies.count) (as expected)")

        // Add new dog to be persisted
        try! realm.write {
            realm.add(myDog)
        }

        print("Puppies count: \(puppies.count) (expected 2)")

        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("age == 1").first
                try! realm.write {
                    theDog!.age = 3
                    print("changed dog age")
                }
            }
        }
    }

    private func addOwner(with uuid: String) {
        let dog1 = Dog()
        dog1.age = 1
        dog1.name = "dog one"

        let dog2 = Dog()
        dog2.age = 2
        dog2.name = "dog two"

        let dog3 = Dog()
        dog3.age = 3
        dog3.name = "dog three"

        let owner = Person()
        owner.uuid = uuid
        owner.name = "Owner name which should not be returned in or test"
        owner.dogs.append(objectsIn: [dog1, dog2])
        owner.dogs.append(dog3)


        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                realm.add(owner)
            }
        } catch let err {
            print(err)
        }
    }

    private func getOwner() {
        print("------------- Get Owners -----------")
        guard let realm = try? Realm() else { return }

        let owners = realm.objects(Person.self)
        print(owners)

//        for x in owners {
//            print(x)
//            for i in x.dogs {
//                print(i)
//            }
//        }
        print("------------")
    }

    private func changeNameOfOwner(with uuid: String) {
        print("-------------------- Changing name of owner with uuid = \(uuid) ----------")
        guard let realm = try? Realm() else { print("failed tp get realm"); return }

        let predicate = NSPredicate(format: "uuid == %@", uuid)
        let owner = realm.objects(Person.self).filter(predicate).first
        print(owner)

        do {
            try realm.write {
                owner?.name = "Changed!!!!"
            }
        } catch let err {
            print("ERROR: \(err)")
        }

        getOwner()

        print("--------------------")

//        let s = realm.schema
//        print("schema: ", s)
//        print("Description: ", s.description)
//        print("object schema:  ", s.objectSchema)

    }

    func testOR() {
        print("-------------------- testOR ----------")
        guard let realm = try? Realm() else { print("failed tp get realm"); return }

//        let predicate = NSPredicate(format: "uuid == 5HIVR43muv OR uuid == gipzesxUyo")
//        var owners = realm.objects(Person.self).filter("uuid == \"5HIVR43muv\" OR uuid == \"gipzesxUyo\"").first
        guard var owner = realm.objects(Person.self).last else { print("owner nil"); return }

        print(owner)
        
        let newPerson = Person()
        newPerson.uuid = owner.uuid ?? "failed to "
        newPerson.dogs.append(Dog(name: "new dog", age: 99))
        newPerson.name = "new person name bg"
    
        do {
            try realm.write {
                print("Here")
                realm.delete(owner)
                realm.add(newPerson)
//                owners?.update(with: newPerson)
//                owners?.dogs[0] = newPerson.dogs[0]
            }

        } catch let err {
            print("ERROR: \(err)")
        }
        
        
        print(owner)
        getOwner()
    }
}

