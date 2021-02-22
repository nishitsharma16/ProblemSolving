//
//  Sequence+Addition.swift
//  DSA
//
//  Created by Nishit on 21/02/21.
//  Copyright © 2021 Mine. All rights reserved.
//

import Foundation

extension Sequence {
    
    func customReduce<Result>(_ initial: Result, _ completion: (_ prev: Result, Element) -> Result) -> Result? where Result == Self.Element {
        
        var i = makeIterator()
        guard var val = i.next() else {
            return nil
        }
        
        while let x = i.next() {
            val = completion(val, x)
        }
        
        return val
    }
    
    func customMap<T>(_ completion: (Element) -> T) -> [T] {
        var i = makeIterator()
        var list = [T]()
        while let x = i.next() {
            let val = completion(x)
            list.append(val)
        }
        return list
    }
}
