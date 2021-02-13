//
//  Citrix.swift
//  DSA
//
//  Created by Nishit on 27/11/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    static func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count <= 2 {
            return []
        }
        
        let target = 0
        let list = nums.sorted()
        let length = list.count
        var result = [[Int]]()
        var set = Set<String>()
        
        for i in 0..<length - 2 {
            var l = i + 1
            var r = length - 1
            while l < r {
                let sum = list[i] + list[l] + list[r]
                if target > sum {
                    l += 1
                }
                else if sum > target {
                    r -= 1
                }
                else {
                    let s = "\(list[i]),\(list[l]),\(list[r])"
                    if !set.contains(s) {
                        set.insert(s)
                        let val = [list[i], list[l], list[r]]
                        result.append(val)
                    }
                    l += 1
                    r -= 1
                }
            }
        }
        return result
    }
    
    static func maxEvents(_ events: [[Int]]) -> Int {
        if events.isEmpty {
            return 0
        }
        
        var maxDay = Int.min
        var map = [Int: [Int]]()
        for item in events {
            let statTime = item[0]
            let endTime = item[1]
            if var val = map[statTime] {
                val.append(endTime)
                map[statTime] = val
            }
            else {
                map[statTime] = [endTime]
            }
            maxDay = max(maxDay, endTime)
        }
        
        let queue = Heap<Int>(type: .minHeap)
        var counter = 0
        
        var currDay = 1
        while currDay <= maxDay {
            
            var isAttended = false
            
            if let val = map[currDay] {
                for item in val {
                    queue.insert(element: item)
                }
            }
            
            while !queue.isEmpty {
                if let endDay = queue.extract(), endDay >= currDay {
                    isAttended = true
                    break
                }
            }
            
            if isAttended {
                counter += 1
            }
            
            currDay += 1
        }
        
        return counter
    }
    
    func canCompleteGasStationCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var start = 0
        var totalTank = 0
        var currTank = 0
        let length = gas.count
        for i in 0..<length {
            totalTank += gas[i] - cost[i]
            currTank += gas[i] - cost[i]
            if currTank < 0 {
                start = (i + 1) % length
                currTank = 0
            }
        }
        return totalTank >= 0 ? start : -1
    }
    
    static func findShortestSubArrayWithMaxDegree(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var map = [Int: [Int]]()
        for (idx, num) in nums.enumerated() {
            map[num, default: []].append(idx)
        }
        
        let degree = map.values.map({ $0.count }).max() ?? 0
        
        return map.filter({ (key, value) -> Bool in
            value.count == degree
        }).map({ (key, value) -> Int in
            return value.max()! - value.min()! + 1
        }).min()!
    }
    
    static func findMinDistanceWithDijkstra(_ graph: [[Int]], _ source: Int, _ n: Int, _ threshold: Int) -> [Int] {
        var distance = Array(repeating: Int.max, count: n)
        distance[source] = 0
        let queue = Heap<Int>(type: .maxHeap)
        queue.insert(element: source)
        while !queue.isEmpty {
            if let node = queue.extract() {
                let list = graph[node]
                for i in 0..<list.count {
                    if graph[node][i] != 0 {
                        let x = distance[node] + graph[node][i]
                        if x <= threshold && distance[i] > x {
                            distance[i] = x
                            queue.insert(element: i)
                        }
                    }
                }
            }
        }
        return distance
    }
    
    static func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
        if n <= 1 || edges.isEmpty {
            return 0
        }
        
        var map = Array(repeating: Array(repeating: 0, count: n), count: n)
        for item in edges {
            let x = item[0]
            let y = item[1]
            let w = item[2]
            map[x][y] = w
            map[y][x] = w
        }
        
        var distMap = [GrapthItem]()
        for i in 0..<n {
            let dist = findMinDistanceWithDijkstra(map, i, n, distanceThreshold)
            let distanceList = dist.filter { (item) -> Bool in
                item != Int.max
            }
            let x = GrapthItem(item: i, count: distanceList.count, list: dist)
            distMap.append(x)
        }
        
        let min = distMap.map { $0.count }.min()!
        let values = distMap.filter { $0.count == min }
    
        var greaterVal = Int.min
        for item in values {
            if item.item > greaterVal {
                greaterVal = item.item
            }
        }
        return greaterVal
    }
    
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        if intervals.isEmpty {
            return 0
        }
        let list = intervals.sorted { (first, second) -> Bool in
            first[0] < second[0]
        }
        
        let queue = Heap<Int>(type: .minHeap)
        queue.insert(element: list[0][1])
        var counter = 1
        for i in 1..<list.count {
            let item = list[i]
            if let top = queue.getRoot() {
                if item[0] >= top {
                    let _ = queue.extract()
                }
                else {
                    counter += 1
                }
            }
            queue.insert(element: item[1])
        }
        return counter
    }
    
    func dfsNumIslands(_ grid: inout [[Character]], m: Int, n: Int, x: Int, y: Int) {
        if x < 0 || y < 0 || x >= m || y >= n || grid[x][y] == "0" {
            return
        }
        
        grid[x][y] = "0"
        let dir = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for item in dir {
            let xPos = x + item.0
            let yPos = x + item.1
            dfsNumIslands(&grid, m: m, n: n, x: xPos, y: yPos)
        }
    }
    
    func numIslands(_ grid: [[Character]]) -> Int {
        
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
    
    static func countPalindromeDP(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        let length = s.count
        
        var statusList = Array(repeating: Array(repeating: false, count: length), count: length)
        var count = 0
        
        for index in 0..<length {
            statusList[index][index] = true
            count += 1
        }
        
        for index in 0..<length-1 {
            if s[index] == s[index+1] {
                statusList[index][index+1] = true
                count += 1
            }
        }
        
        if length <= 2 {
            return count
        }
        
        var j = 0
        
        for l in 3...length {
            for i in 0..<length - l + 1 {
                j = i + l - 1
                if statusList[i+1][j-1] && s[i] == s[j] {
                    statusList[i][j] = true
                    count += 1
                }
            }
        }
        
        return count
    }
    
    func minFlipsToConvertSwitchOffBulbStateToTarget(_ target: String) -> Int {
        if target.isEmpty {
            return 0
        }
        var result = 0
        var char: Character = "0"
        for item in target {
            if char != item {
                char = item
                result += 1
            }
        }
        return result
    }
    
    func minSteps(_ s: String, _ t: String) -> Int {
        
        if t.isEmpty {
            return s.count
        }
        else if s.isEmpty {
            return t.count
        }
        
        
        var sMap = [Character: Int]()
        for item in s {
            if let val = sMap[item] {
                sMap[item] = val + 1
            }
            else {
                sMap[item] = 1
            }
        }
        
        var counter = 0
        
        for item in t {
            if let x = sMap[item] {
                if x > 0 {
                    sMap[item] = x - 1
                }
                else {
                    counter += 1
                }
            }
            else {
                counter += 1
            }
        }
        
        return counter
    }
    
    static func numPairsDivisibleBy60(_ time: [Int]) -> Int {
        let len = time.count
        if len <= 1 {
            return 0
        }
        
        
        var counter = 0
        var remainder = Array(repeating: 0, count: 60)
        
        for item in time {
            let x = item % 60
            if x == 0 {
                counter += remainder[x]
            }
            else {
                counter += remainder[60 - x]
            }
            remainder[x] += 1
        }
    
        return counter
    }
    
    func maxProfitV1(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
        var minPrice = Int.max
        var maxProfit = 0
        
        for item in prices {
            if item < minPrice {
                minPrice = item
            }
            else if item - minPrice > maxProfit {
                maxProfit = item - minPrice
            }
        }
        
        return maxProfit
    }
    
    func maxProfitV2(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
        
        var profit = 0

        for i in 0..<prices.count - 1 {
            if prices[i] < prices[i + 1] {
                profit += prices[i + 1] - prices[i]
            }
        }
        
        return profit
    }
    
    func maxProfitV3CoolDown(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
        
        var profit = 0
        var count = 0
        var coolDown = false
        while count < prices.count - 1 {
            if prices[count] < prices[count + 1] {
                profit += prices[count + 1] - prices[count]
                coolDown = true
                count += 1
            }
            if coolDown {
                count += 2
                coolDown = false
            }
        }
        
        return profit
    }
    
    func reverseList(_ head: SortedNode?) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        var curr = head
        var temp: SortedNode?
        var prev: SortedNode?
        
        while curr != nil {
            temp = curr
            curr = curr?.next
            temp?.next = prev
            prev = temp
        }
        
        return prev
    }
    
    func getMapForValues(_ s: String, _ count: String) -> [String: String] {
        
        if let firstIndex = s.firstIndex(of: ".") {
            let x = String(s[s.index(after: firstIndex)..<s.endIndex])
            var val = getMapForValues(x, count)
            val[x] = count
            return val
        }
        
        return [:]
    }
    
    func merge(_ first: [String: String], _ second: [String: String]) -> [String: String] {
        var result = [String: String]()
        for item in first {
            if let val = second[item.key] {
                
            }
        }
        return [:]
    }
    
    func subdomainVisits(_ cpdomains: [String]) -> [String] {
        if cpdomains.isEmpty {
            return []
        }
        
        var prev = [String: String]()
        var result = [String]()
        
        for item in cpdomains {
            let val = item.split(separator: " ")
            let y = getMapForValues(String(val[1]), String(val[0]))
            if !prev.isEmpty {
//                <#code#>
            }
        }
        
        return []
    }
}

struct GrapthItem {
    let item: Int
    let count: Int
    let list: [Int]
}
