//
//  Adobe.swift
//  DSA
//
//  Created by Nishit on 04/02/21.
//  Copyright © 2021 Mine. All rights reserved.
//

import Foundation

extension Problems {
    
    func containsNearbyAlmostDuplicateV3(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k < 1 {
            return false
        }
        
        let n = nums.count
        var minStatus = true
        var maxStatus = true

        let minDistance = 1
        let maxDistance = k
        for i in 0..<n - 1 {
            if abs(nums[i] - nums[i + minDistance]) > t {
                minStatus = false
            }
        }
        
        for i in 0..<n - k {
            if abs(nums[i] - nums[i + maxDistance]) > t {
                maxStatus = false
            }
        }
        
        return minStatus || maxStatus
    }
    
    static func checkPossibilityForNonDecreasingArray(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        var counter = 0
        var list = nums
        var j = 0
        while j < list.count - 1 {
            if list[j] > list[j + 1] {
                counter += 1
                if counter > 1 {
                    return false
                }
                if j > 0 &&  list[j - 1] > list[j + 1] {
                    list[j + 1] = list[j]
                }
                else {
                    list[j] = list[j + 1]
                }
            }
            j += 1
        }
        return true
    }
}
