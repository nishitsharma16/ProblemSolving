//
//  MultiSet.swift
//  DSA
//
//  Created by Nishit on 04/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

struct MultiSet<Element: Hashable> {
    private var store = [Element: UInt]()
    private var totalCount = 0
    mutating func add(_ element: Element) {
        store[element, default: 0] += 1
        totalCount += 1
    }
    
    mutating func remove(_ element: Element) {
        if let val = store[element], val > 1 {
            store[element] = val - 1
        }
        else {
            store.removeValue(forKey: element)
        }
        totalCount -= 1
    }
    
    func countFor(_ element: Element) -> UInt {
        if let val = store[element] {
            return val
        }
        return 0
    }
    
    func count() -> Int {
        return totalCount
    }
    
    func isSubSet(of set: MultiSet<Element>) -> Bool {
        for (key, count) in self.store {
            let superCount = set.store[key] ?? 0
            if count > superCount {
                return false
            }
        }
        return true
    }
}
