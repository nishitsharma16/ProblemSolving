//
//  Goldman.swift
//  DSA
//
//  Created by Nishit on 05/10/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    static func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 || coins.isEmpty {
            return 0
        }
        
        var amountList = Array(repeating: amount + 1, count: amount + 1)
        amountList[0] = 0
        
        for i in 1...amount {
            for j in 0..<coins.count {
                if coins[j] <= i {
                    amountList[i] = min(amountList[i], amountList[i - coins[j]] + 1)
                }
            }
        }
        
        return amountList[amount] > amount ? -1 : amountList[amount]
    }
    
    static func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        if nums.isEmpty || s == 0 {
            return 0
        }
        
        var result = Int.max
        var sum = 0
        var start = 0
        
        for index in 0..<nums.count {
            sum += nums[index]
            while sum >= s {
                result = min(result, index - start + 1)
                sum -= nums[start]
                start += 1
            }
        }
        return result
    }
    
    // Sort it and then merge
    static func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
        if intervals.isEmpty {
            return []
        }
        
        var list = intervals
        var i = 0
        while i < list.count - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if !(curr[1] < next[0]) {
                list[i] = [min(curr[0], next[0]), max(curr[1], next[1])]
                list.remove(at: i + 1)
            }
            else {
                i += 1
            }
        }
        return list
    }
    
    static func findItineraryHelper(tickets: [[String]], source: String, map: [String: [Int]], visited: inout [Bool], result: inout [String]) {
        if let val = map[source] {
            for item in val {
                if !visited[item] {
                    let x = tickets[item][0]
                    let y = tickets[item][1]
                    result.append(x)
                    visited[item] = true
                    findItineraryHelper(tickets: tickets, source: y, map: map, visited: &visited, result: &result)
                }
            }
        }
    }
    
    static func findItinerary(_ tickets: [[String]]) -> [String] {
        if tickets.isEmpty {
            return []
        }
        
        let length = tickets.count
        var result = [String]()
        var visited = Array(repeating: false, count: length)
        var map = [String: [Int]]()
        for index in 0..<length {
            let item = tickets[index]
            let x = item[0]
            if var y = map[x] {
                y.append(index)
                map[x] = y
            }
            else {
                map[x] = [index]
            }
        }
        
        let source = "JFK"
        findItineraryHelper(tickets: tickets, source: source, map: map, visited: &visited, result: &result)
        return result
    }
    
    
    
    static func compress(_ chars: inout [Character]) -> Int {
        if chars.isEmpty {
            return 0
        }
        
        var counter = 1
        var index = 0
        while index < chars.count - 1 {
            if chars[index] == chars[index + 1] {
                counter += 1
                chars.remove(at: index + 1)
            }
            else {
                let x = "\(counter)"
                if counter > 1 {
                    if x.count == 1 {
                        chars.insert(Character("\(counter)"), at: index + 1)
                        index += x.count + 1
                    }
                    else {
                        let y = x.map { $0 }
                        chars.insert(contentsOf: y, at: index + 1)
                        index += y.count + 1
                    }
                    counter = 1
                }
                else {
                    index += 1
                }
            }
        }
        
        if counter > 1 {
            let x = "\(counter)"
            if x.count == 1 {
                chars.insert(Character("\(counter)"), at: index + 1)
            }
            else {
                let y = x.map { $0 }
                chars.insert(contentsOf: y, at: index + 1)
            }
        }
        return chars.count
    }
    
    static func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.isEmpty {
            return false
        }
        var x = matrix.count - 1
        var y = 0
        
        while x >= 0 && y < matrix[0].count {
            if matrix[x][y] > target {
                x -= 1
            }
            else if matrix[x][y] < target {
                y += 1
            }
            else {
                return true
            }
        }
        return false
    }
    
    private static func checkAnagram(_ str: String, _ map: [Character: Int]) -> Bool {
        var inner = map
        for item in str {
            if let x = inner[item] {
                inner[item] = x - 1
            }
        }
        
        for item in inner {
            if item.value != 0 {
                return false
            }
        }
        return true
    }
    
    static func findAnagrams(_ s: String, _ p: String) -> [Int] {
        if s.isEmpty {
            return []
        }
        
        let slen = s.count
        let plen = p.count

        var map = [Character: Int]()
        for item in p {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        
        var result = [Int]()
        var start = s.startIndex
        for i in 0..<slen - plen + 1 {
            let end = s.index(start, offsetBy: plen - 1)
            let subStr = String(s[start...end])
            if checkAnagram(subStr, map) {
                result.append(i)
            }
            start = s.index(after: start)
        }
        
        return result
    }
    
    static func findAnagramsV2(_ s: String, _ p: String) -> [Int] {
        if s.isEmpty {
            return []
        }
        
        let slen = s.count
        let plen = p.count
        
        if plen > slen {
            return []
        }

        var pMap = [Character: Int]()
        var sMap = [Character: Int]()

        for item in p {
            if let x = pMap[item] {
                pMap[item] = x + 1
            }
            else {
                pMap[item] = 1
            }
        }
        
        var result = [Int]()
        for i in 0..<slen {
            let val = s[i]
            if let x = sMap[val] {
                sMap[val] = x + 1
            }
            else {
                sMap[val] = 1
            }
            
            if i >= plen {
                let index = s.index(s.startIndex, offsetBy: i - plen)
                let item = s[index]
                if let val = sMap[item] {
                    if val == 1 {
                        sMap[item] = nil
                    }
                    else {
                        sMap[item] = val - 1
                    }
                }
            }
            if sMap == pMap {
                result.append(i - plen + 1)
            }
        }
        
        return result
    }
    
    static func dfsNumIslands(_ grid: inout [[Character]], m: Int, n: Int, x: Int, y: Int) {
        if x < 0 || y < 0 || x >= m || y >= n || grid[x][y] == "0" {
            return
        }
        
        grid[x][y] = "0"
        dfsNumIslands(&grid, m: m, n: n, x: x - 1, y: y)
        dfsNumIslands(&grid, m: m, n: n, x: x + 1, y: y)
        dfsNumIslands(&grid, m: m, n: n, x: x, y: y + 1)
        dfsNumIslands(&grid, m: m, n: n, x: x + 1, y: y - 1)
    }
    
    static func numIslandsV2(_ grid: [[Character]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        
        var myGrid = grid
        var result = 0
        let m = myGrid.count
        let n = myGrid[0].count
        
        for i in 0..<m {
            for j in 0..<n {
                if myGrid[i][j] == "1" {
                    result += 1
                    dfsNumIslands(&myGrid, m: m, n: n, x: i, y: j)
                }
            }
        }
        
        return result
    }
    
    
    static func findSubSequence(_ main: String, sub: String) -> Bool {
        var j = 0
        for index in 0..<main.count {
            if main[index] == sub[j] {
                j += 1
            }
            if j == sub.count {
                return true
            }
        }
        return false
    }
    
    static func findLongestWord(_ s: String, _ d: [String]) -> String {
        if d.isEmpty || s.isEmpty {
            return ""
        }
        var result = ""
        for item in d {
            if findSubSequence(s, sub: item) {
                if item.count > result.count {
                    result = item
                }
            }
        }
        return result
    }
    
    static func maxArea(_ height: [Int]) -> Int {
        if height.isEmpty {
            return 0
        }
        var l = 0
        var r = height.count - 1
        var maxArea = 0
        
        while l < r {
            maxArea = max(maxArea, (min(height[l], height[r]) * (r - l)))
            if height[l] < height[r] {
                l += 1
            }
            else {
                r -= 1
            }
        }
        return maxArea
    }
    
    static func isRobotBounded(_ instructions: String) -> Bool {
        if instructions.isEmpty {
            return false
        }
        
        let dir = [[0,1], [1,0], [0,-1], [-1,0]]
        var pos = 0
        var x = 0, y = 0
        
        for item in instructions {
            switch item {
            case "L":
                pos = (pos + 3) % 4
            case "R":
                pos = (pos + 1) % 4
            default:
                x += dir[pos][0]
                y += dir[pos][1]
            }
        }
        
        return (x == 0 && y == 0) || pos != 0
    }
    
    //https://www.geeksforgeeks.org/min-cost-path-dp-6/ minCost
    // This is when user moves right, down and diagnoally
    static func minPathSum(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        
        let m = grid.count
        let n = grid[0].count
        let dstX = m - 1
        let dstY = n - 1

        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        dp[0][0] = grid[0][0]
        
        for i in 1...m {
            dp[i][0] =  dp[i - 1][0] + grid[i][0]
        }
        
        for j in 1...n {
            dp[0][j] =  dp[0][j - 1] + grid[0][j]
        }
        
        for i in 1...m {
            for j in 1...n {
                dp[i][j] = min(min(dp[i - 1][j - 1], dp[i - 1][j]), dp[i][j - 1]) + grid[i][j]
            }
        }
        
        return dp[dstX][dstY]
    }
    
    //https://www.geeksforgeeks.org/min-cost-path-dp-6/ minCost
    // This is when user moves right, down
    static func minPathSumV2(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        
        let m = grid.count
        let n = grid[0].count
        let dstX = m - 1
        let dstY = n - 1

        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        dp[0][0] = grid[0][0]

        for i in 1...m {
            dp[i][0] =  dp[i - 1][0] + grid[i][0]
        }
        
        for j in 1...n {
            dp[0][j] =  dp[0][j - 1] + grid[0][j]
        }
        
        for i in 1...m {
            for j in 1...n {
                dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j]
            }
        }
        
        return dp[dstX][dstY]
    }
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        let length = nums.count
        var result = Array(repeating: 1, count: length)
        for i in 1..<length {
            result[i] = result[i - 1] * nums[i - 1]
        }
        
        var x = 1
        for i in stride(from: length - 1, through: 0, by: -1) {
            result[i] = result[i] * x
            x *= nums[i]
        }
        
        return result
    }
}
