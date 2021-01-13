//
//  Extensions.swift
//  DSA
//
//  Created by Nishit on 22/11/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Int {
    func toString() -> String {
        var result = ""
        var n = self
        while n > 0 {
            let x = String(n % 10)
            n = n / 10
            result = x + result
        }
        return result
    }
}
