//
//  Intuit.swift
//  DSA
//
//  Created by Nishit on 17/09/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    static func intersectionOfIntervals(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
        if A.isEmpty || B.isEmpty {
            return []
        }
                
        var result = [[Int]]()
        
        var i = 0
        var j = 0
        
        while i < A.count {
            let x = A[i]
            j = 0
            while j < B.count {
                var list = [Int]()
                let y = B[j]
                if x[1] < y [0] || x[0] > y [1] {
                }
                else {
                    let max1 = max(x[0], y[0])
                    let min2 = min(x[1], y[1])
                    list.append(max1)
                    list.append(min2)
                    result.append(list)
                }
                j += 1
            }
            i += 1
        }
        
        return result
    }
    
    static func findDuplicateNumber(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var list = nums
        for item in list {
            let index = abs(item)
            if list[index] < 0 {
                return index
            }
            list[index] = -item
        }
        
        return 0
    }
    
    
    static func findWord(mat : [[Character]], visited : inout [[Bool]], x : Int, y : Int, str : inout String, target: String, status: inout Bool) {
        
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        
        visited[x][y] = true
        str = str + String(mat[x][y])
        
        if target == str {
            status = true
        }
        
        let dir = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        for item in dir {
            let row = x + item.0
            let col = y + item.1
            if row >= 0 && col >= 0 && row < m && col < n && !visited[row][col] {
                findWord(mat: mat, visited: &visited, x: row, y: col, str: &str, target: target, status: &status)
            }
        }
        str.remove(at: str.index(before: str.endIndex))
        visited[x][y] = false
    }
    
    static func searchWord(mat : [[Character]], str : String) -> Bool {
        if mat.isEmpty || str.isEmpty {
            return false
        }
        
        var string = ""
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        var status = false
        
        for i in 0..<m {
            for j in 0..<n {
                findWord(mat: mat, visited: &visited, x: i, y: j, str: &string, target: str, status: &status)
                if status {
                    return status
                }
                status = false
            }
        }
        return status
    }
    
    static func longestPalindromeCanMake(str: String) -> Int {
        if str.isEmpty {
            return 0
        }
        
        var map = [Character: Int]()
        var result = 0
        
        for item in str {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        
        for item in map {
            let x = item.value
            result += (x / 2) * 2
            if result / 2 == 0 && x % 2 == 1  {
                result += 1
            }
        }
        
        return result
    }
    
    func maxLengthSubArrayInBothList(_ A: [Int], _ B: [Int]) -> Int {
        if A.isEmpty || B.isEmpty {
            return 0
        }
        
        var result = 0

        var map = Array(repeating: Array(repeating: 0, count: A.count + 1), count: B.count + 1)
        
        
        for i in stride(from: A.count - 1, through: 0, by: -1) {
            for j in stride(from: B.count - 1, through: 0, by: -1) {
                if A[i] == B[j] {
                    map[i][j] = map[i + 1][j + 1] + 1
                    if result < map[i][j] {
                        result = map[i][j]
                    }
                }
            }
        }
        
        return result
    }
    
    static func maximumProduct(_ nums: [Int]) -> Int {
        let x = nums.sorted()
        let length = x.count
        let product = max((x[length - 1] * x[0] * x[1]), (x[length - 1] * x[length - 2] * x[length - 3]))
        return product
    }
}
