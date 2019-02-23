//: Playground - noun: a place where people can play

import UIKit

class Node<T> {
    let value: T
    var next: Node?
    init(value: T) {
        self.value = value
    }
}

class Stack<T> {
    
    var top: Node<T>?
    
    func push(_ value: T) {
        let oldTop = top
        top = Node(value: value)
        top?.next = oldTop
    }
    
    func pop() -> T? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() -> T? {
        return top?.value
    }
    
}

struct User {
    let name: String
    let username: String
}

let me = User(name: "Ben", username: "@ben_gavan")
let you = User(name: "You", username: "@you")

let userStack = Stack<User>()
userStack.push(me)
userStack.push(you)

let firstUserPop = userStack.pop()
print(firstUserPop?.name as Any)

let stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)

stack.peek()

let firstPop = stack.pop()
let secondPop = stack.pop()
let thirdPop = stack.pop()
let finalPop = stack.pop()

