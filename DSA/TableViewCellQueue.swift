//
//  TableViewCellQueue.swift
//  DSA
//
//  Created by Nishit on 03/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation


class TableViewCellQueue<Item> {
    
    private var list = [Item]()
    
    func enqueueFromFront(val : Item) {
        list.insert(val, at: 0)
    }
    
    func dQueueFromFront() -> Item {
       return list.removeFirst()
    }
    
    func enqueueFromEnd(val : Item) {
        list.append(val)
    }
    
    func dQueueFromLast() -> Item {
       return list.removeLast()
    }
    
    var isEmpty : Bool {
        return list.isEmpty
    }
    
    var size : Int {
        return list.count
    }
}
