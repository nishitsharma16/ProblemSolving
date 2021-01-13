//
//  GenericDataStructures.swift
//  DSA
//
//  Created by Nishit on 04/09/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class RandomizedSet {

    /** Initialize your data structure here. */
    private var list = Array<Int>()
    private var info = Dictionary<Int,Int>()

    init() {
        
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if !list.contains(val) {
            list.append(val)
            info[val] = list.count - 1
            return true
        }
        return false
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        if list.contains(val) {
            if let index = info[val] {
                list.remove(at: index)
                info.removeValue(forKey: val)
                return true
            }
        }
        return false
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        let x = Int.random(in: 0..<list.count)
        let randomElement = list[x]
        return randomElement
    }
}
