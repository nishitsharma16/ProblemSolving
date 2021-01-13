//
//  Algorithms.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Algorithms {
    
    static func findWords(mat : [[Character]], visited : inout [[Bool]], x : Int, y : Int, str : inout String, list : [String], resultList : inout [String]) {
        
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        
        visited[x][y] = true
        str = str + String(mat[x][y])
        
        if list.contains(str) {
            resultList.append(str)
        }
        
        var row = x - 1
        while row <= x + 1 && row < m {
            var col = y - 1
            while col <= y + 1 && col < n {
                if row >= 0 && col >= 0 && !visited[row][col] {
                    findWords(mat: mat, visited: &visited, x: row, y: col, str: &str, list: list, resultList: &resultList)
                }
                col += 1
            }
            row += 1
        }
        
        str.remove(at: str.index(before: str.endIndex))
        visited[x][y] = false
    }
    
    static func boogle(mat : [[Character]], strList : [String]) {
        if mat.isEmpty {
            return
        }
        
        var result = [String]()
        var string = ""
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                findWords(mat: mat, visited: &visited, x: i, y: j, str: &string, list: strList, resultList: &result)
            }
        }
    }
    
    static func markNeighboursNodeVisited(mat : inout [[Int]], visited : inout [[Bool]], x : Int, y : Int, m : Int, n : Int) {
        
        visited[x][y] = true
        
        var row = x - 1
        while row <= x + 1 && row < m {
            var col = y - 1
            while col <= y + 1 && col < n {
                if row >= 0 && col >= 0 && !visited[row][col] {
                    if mat[row][col] == 1 {
                        markNeighboursNodeVisited(mat: &mat, visited: &visited, x: row, y: col, m: m, n: n)
                        mat[row][col] = -mat[row][col]
                    }
                }
                col += 1
            }
            row += 1
        }
    }
    
    static func findMinimumTowers(mat : inout [[Int]], result : inout Int) {
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count

        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if mat[i][j] == 1 {
                    result += 1
                    markNeighboursNodeVisited(mat: &mat, visited: &visited, x: i, y: j, m: m, n: n)
                }
            }
        }
    }
    
    
    static func convertIntoZombie(mat : inout [[Int]] , visited : inout [[Bool]], m : Int, n : Int, result : inout Int) {
        
        var humanNodes = 0
        let queue = Queue<(first :Int,second: Int)>()

        for i in 0..<m {
            for j in 0..<n {
                if mat[i][j] == 0 {
                    humanNodes += 1
                }
                else {
                    queue.enqueue(val: (i, j))
                }
            }
        }
    
        let directionList = [(0,-1), (0,1), (1,0), (-1,0)]
        
        while !queue.isEmpty && humanNodes > 0 {
            for _ in 0..<queue.size {
                let item = queue.dQueue()
                for dir in directionList {
                    let xPos = item.first + dir.0
                    let yPos = item.second + dir.1
                    if xPos >= 0 && yPos >= 0 && xPos < m && yPos < n {
                        if mat[xPos][yPos] == 0 {
                            mat[xPos][yPos] = 1
                            humanNodes -= 1
                            queue.enqueue(val: (xPos,yPos))
                        }
                    }
                }
            }
            result += 1
        }
    }
    
    static func minHoursToConvertIntoZombies(mat : inout [[Int]] , result : inout Int) {
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)

        convertIntoZombie(mat: &mat, visited: &visited, m: m, n: n, result: &result)
    }
    
    static func findTopFrequentlyUsedKeywords(list : [String], keywords : [String], target : Int) -> [String] {
        var result = [String]()
        
        if list.isEmpty {
            return result
        }
                
        var keyWordList = [WordItem<String>]()
        for val in keywords {
            let item = WordItem<String>(val: val)
            keyWordList.append(item)
        }
        
        for val in keyWordList {
            for str in list {
                let wordList = str.caseInSensitiveWordsFromSentence()
                if wordList.contains(val.value) {
                    val.frequency = val.frequency + 1
                }
            }
        }
        
        let heap = Heap<WordItem<String>>(type: .maxHeap, list: keyWordList)
        
        if target < list.count {
            for _ in 0..<target {
                if let val = heap.extract() {
                    result.append(val.value)
                }
            }
        }
        
        return result
    }
    
    static func getValuesWithSumLessThanOrCloserToTarget(list1 : [(first : Int, second : Int)], list2 : [(first : Int, second : Int)], target : Int) -> [(Int, Int)] {
        var result = [(Int, Int)]()
        
        let sort1 = list1.sorted { (x, y) -> Bool in
            return x.second < y.second
        }
        
        let sort2 = list2.sorted { (x, y) -> Bool in
            return x.second < y.second
        }
        
        var count1 = 0
        var count2 = sort2.count - 1
        
        var temp = [(Int, Int)]()
        
        while count1 < sort1.count && count2 >= 0 {
            let item1 = sort1[count1]
            let item2 = sort2[count2]
            
            if item1.second + item2.second < target {
                temp.append((item1.first, item2.first))
                count1 += 1
            }
            else {
                count2 -= 1
            }
        }
        result.append(contentsOf: temp)
        return result
    }
    
    static func minimumCostToConnectRopes(list : [Int]) -> Int {
        var result = 0

        if list.isEmpty {
            return result
        }
        
        let sortedList = list.sorted()
        
        result = sortedList[0]
        
        for index in 1..<sortedList.count {
            result += sortedList[index]
        }
        
        return result
    }
    
    /*
     [["O", "O", "O", "O"],
     ["D", "O", "D", "O"],
     ["O", "O", "O", "O"],
     ["X", "D", "D", "O"]]
     */
    static func shortestPathToFindTreasureIsland(mat: [[String]]) -> Int {
        var result = 0
                
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        let island = "X"
        let danger = "D"
        let safe = "O"
        
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        let directionList = [(0,-1), (0,1), (1,0), (-1,0)]
        
        let queue = Queue<(first :Int,second: Int)>()
        visited[0][0] = true
        queue.enqueue(val: (0, 0))
        
        while !queue.isEmpty {
            let val = queue.dQueue()
            for dir in directionList {
                let xPos = val.first + dir.0
                let yPos = val.second + dir.1
                if xPos >= 0 && yPos >= 0 && xPos < m && yPos < n && String(mat[xPos][yPos]) != danger {
                    if mat[xPos][yPos] == safe && !visited[xPos][yPos] {
                        visited[xPos][yPos] = true
                        queue.enqueue(val: (xPos,yPos))
                        result += 1
                    }
                    else if mat[xPos][yPos] == island {
                        return (result + 1)/2
                    }
                }
            }
        }
        return result
    }
    
    static func traverseMatrixInSpiralWay(mat : [[Int]], row : Int, col : Int, visited : inout [[Bool]]) {
        print(mat[row][col])
        
    }
    
    static func printMatrixInSpiralWay(mat : [[Int]]) {
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        traverseMatrixInSpiralWay(mat: mat, row: 0, col: 0, visited: &visited)
    }
    
    // With Dikstra Algo without all directions
    static func minCostPath(mat : [[Int]], result : inout Int) {
        if !mat.isEmpty {
            
            let innerList = mat[0]
            let m = mat.count
            let n = innerList.count
            var visited = Array(repeating: Array(repeating: false, count: n), count: m)
            var dpMat = Array(repeating: Array(repeating: Int(INT_MAX), count: n), count: m)

            var x = 0
            var y = 0
            
            visited[x][y] = true
            dpMat[x][y] = mat[x][y]
            let heap = Heap<HeapItem>(type: .minHeap)
            heap.insert(element: HeapItem(val: dpMat[x][y], x: x, y: y))
            let dir = [(0, 1), (1, 0), (1, 1)]
            while !heap.isEmpty {
                if let val = heap.getRoot() {
                    for item in dir {
                        x = val.row + item.0
                        y = val.col + item.1
                        if x >= 0 && y >= 0 && x < m && y < n && !visited[x][y] {
                            visited[x][y] = true
                            dpMat[x][y] = min(dpMat[x][y], dpMat[val.row][val.col] + mat[x][y])
                            heap.insert(element: HeapItem(val: dpMat[x][y], x: x, y: y))
                        }
                    }
                }
            }
            result = dpMat[m][n]
        }
    }
    
    static func findNumberOfIslands(mat : inout [[Int]], result : inout Int) {
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count

        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if mat[i][j] == 1 {
                    result += 1
                    markNeighboursNodeVisited(mat: &mat, visited: &visited, x: i, y: j, m: m, n: n)
                }
            }
        }
    }
    
    static func rotate(mat : inout [[Int]], visited : inout [[Bool]], clockWise : Bool, x : Int, y : Int, m : Int, n : Int) {
        
    }
    
    static func rotateMatrices(mat : inout [[Int]], clockWise : Bool) {
        
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        rotate(mat: &mat, visited: &visited, clockWise: clockWise, x: 0, y: 0, m: m, n: n)
    }
}

class WordItem<Item> {
    var frequency = 0
    let value : Item
    init(val : Item) {
        value = val
    }
}
