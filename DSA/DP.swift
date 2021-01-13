//
//  DP.swift
//  DSA
//
//  Created by Nishit on 10/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class DynamicProgramming {
    
    // Top-down manner or Memoization
    static func findFibNumberSet1(n : Int, list : inout [Int]) -> Int {
        if list[n] == -1 {
            if n <= 1 {
                list[n] = n
            }
            else {
                list[n] = findFibNumberSet1(n: n - 1, list: &list) + findFibNumberSet1(n: n - 2, list: &list)
            }
        }
        return list[n]
    }
    
    // Bottom-up manner or Tabulation
    static func findFibNumberSet2(n : Int) -> Int {
        var list = [Int]()
        list[0] = 0
        list[1] = 1
        for index in 2...n {
            list[index] = list[index - 1] + list[index - 2]
        }
        return list[n]
    }
    
    static func fibNumberSet1(nVal : Int) -> Int {
        var list = Array<Int>(repeating: -1, count: nVal + 1)
        let result = findFibNumberSet1(n: nVal, list: &list)
        return result
    }
    
    static func findnThUglyNumber(nval : Int) -> Int {
        return 0
    }
    
    static func goldMinehelper(mat: [[Int]], visited: inout [[Bool]], i: Int, j: Int, m: Int, n: Int) -> Int {
        let dir = [(0, 1), (-1, 1), (1, 1)]
        let queue = Queue<(Int, Int)>()
        queue.enqueue(val: (i, j))
        visited[i][j] = true
        var sum = mat[i][j]
        while !queue.isEmpty {
            let front = queue.dQueue()
            for item in dir {
                let next = (front.0 + item.0, front.1 + item.1)
                if next.0 >= 0 && next.1 >= 0 && next.0 < m && next.1 < n && !visited[next.0][next.1] {
                    visited[next.0][next.1] = true
                    queue.enqueue(val: next)
                    sum += mat[next.0][next.1]
                }
            }
        }
        return sum
    }
    
    static func goldMineProblem(mat: [[Int]]) -> Int {
        if mat.isEmpty {
            return 0
        }
        
        let m = mat.count
        let n = mat[0].count
        
        var result = Int.min
        
        var visisted = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0..<m {
            let x = goldMinehelper(mat: mat, visited: &visisted, i: i, j: 0, m: m, n: n)
            if result < x {
                result = x
            }
        }
        
        return result
    }
    
    static func longestCommonSubSequence(str1: String, str2: String) -> Int {
        if str1.isEmpty || str2.isEmpty {
            return 0
        }
        
        let m = str1.count
        let n = str2.count
        var mat = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        
        for i in 0...m {
            for j in 0...n {
                if i == 0 || j == 0 {
                    mat[i][j] = 0
                }
                else if str1[i - 1] == str2[j - 1] {
                    mat[i][j] = 1 + mat[i - 1][j - 1]
                }
                else {
                    mat[i][j] = max(mat[i - 1][j], mat[i][j - 1])
                }
            }
        }
        
        return mat[m][n]
    }
    
}
