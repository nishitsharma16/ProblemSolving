//
//  Stack.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Stack<Item> {
    
    private var list = [Item]()
    
    func push(val : Item) {
        list.append(val)
    }
    
    @discardableResult
    func pop() -> Item {
       return list.removeLast()
    }
    
    func top() -> Item? {
       return list.last
    }
    
    var isEmpty : Bool {
       return list.isEmpty
    }
    
    var size : Int {
       return list.count
    }
    
    var items: [Item] {
        return list
    }
}

class MaxStack {
    private let stack1 = Stack<Int>()
    private let stack2 = Stack<Int>()

    func push(val : Int) {
        if stack1.isEmpty {
            stack1.push(val: val)
            stack2.push(val: val)
        }
        else {
            if let top = stack2.top() {
                if top < val {
                    stack2.push(val: val)
                    stack1.push(val: val)
                }
                else {
                    stack1.push(val: val)
                    stack2.push(val: peekMax())
                }
            }
        }
    }
    
    @discardableResult
    func pop() -> Int {
        stack2.pop()
        return stack1.pop()
    }
    
    func top() -> Int? {
        return stack1.top()
    }
    
    func peekMax() -> Int {
        return stack2.top() ?? -1
    }
    
    func popMax() -> Int {
        var result = -1
        if let top1 = stack1.top(), let top2 = stack2.top() {
            if top1 == top2 {
                stack1.pop()
                return stack2.pop()
            }
            else {
                
                let temp = Stack<Int>()
                while let x = stack1.top(), let y = stack2.top(), x != y {
                    temp.push(val: x)
                    stack1.pop()
                    stack2.pop()
                }
                
                stack1.pop()
                result = stack2.pop()
                
                while !temp.isEmpty {
                    push(val: temp.pop())
                }
            }
        }
        return result
    }
}

class MinStack {
    private let stack1 = Stack<Int>()
    private let stack2 = Stack<Int>()

    init() {}
    
    func push(_ x : Int) {
        if stack1.isEmpty {
            stack1.push(val: x)
            stack2.push(val: x)
        }
        else {
            if let top = stack2.top() {
                if top > x {
                    stack2.push(val: x)
                    stack1.push(val: x)
                }
                else {
                    stack1.push(val: x)
                    stack2.push(val: getMin())
                }
            }
        }
    }
    
    @discardableResult
    func pop() -> Int {
        stack2.pop()
        return stack1.pop()
    }
    
    func top() -> Int? {
        return stack1.top()
    }
    
    func getMin() -> Int {
        return stack2.top() ?? -1
    }
}


