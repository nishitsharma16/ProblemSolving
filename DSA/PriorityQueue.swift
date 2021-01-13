//
//  PriorityQueue.swift
//  DSA
//
//  Created by Nishit on 07/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Item<ItemValue> {
    
    let value : ItemValue
    let priority : Int
    
    init(priority : Int, value : ItemValue) {
        self.value = value
        self.priority = priority
    }
}

extension Item : Comparable {
    
    static func < (lhs: Item<ItemValue>, rhs: Item<ItemValue>) -> Bool {
        return lhs.priority < rhs.priority
    }
    
    static func == (lhs: Item<ItemValue>, rhs: Item<ItemValue>) -> Bool {
        return lhs.priority == rhs.priority
    }
}

class PriorityQueue {
    
    var queue = Heap<Item<Int>>(type: .maxHeap)
    let list = [Item<Int>(priority: 10, value: 5), Item<Int>(priority: 9, value: 5), Item<Int>(priority: 1, value: 5), Item<Int>(priority: 20, value: 5), Item<Int>(priority: 21, value: 5), Item<Int>(priority: 3, value: 5), Item<Int>(priority: 2, value: 5), Item<Int>(priority: 18, value: 5), Item<Int>(priority: 16, value: 5)]
    
    func createQueue() {
        for item in list {
            queue.insert(element: item)
        }
    }
    
    func getTopItem() -> Item<Int>? {
        return queue.extract()
    }
}
