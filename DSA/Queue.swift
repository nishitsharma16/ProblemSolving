//
//  Queue.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Queue<Item> {
    
    private var list = [Item]()
    
    func enqueue(val : Item) {
        list.append(val)
    }
    
    @discardableResult
    func dQueue() -> Item {
       return list.removeFirst()
    }
    
    var isEmpty : Bool {
        return list.isEmpty
    }
    
    var size : Int {
        return list.count
    }
}
