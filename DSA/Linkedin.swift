//
//  Linkedin.swift
//  DSA
//
//  Created by Nishit on 15/09/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    
    static func hasOneLetterDifference(source: String, dest: String) -> Bool {
        let sourceVal = Array(source)[0...]
        let destVal = Array(dest)[0...]
        if sourceVal.isEmpty || destVal.isEmpty {
            return false
        }
        else if sourceVal.count != destVal.count {
            return false
        }
        
        var counter = 0
        for i in 0..<sourceVal.count {
            let x = sourceVal[i]
            let y = destVal[i]
            if x != y {
                counter += 1
            }
        }
        return counter == 1
    }
    
    static func wordLadder(list: [String], source: String, dest: String) -> Int {
        if list.isEmpty {
            return 0
        }
        
        if !list.contains(dest) {
            return 0
        }
        
        var items = list
        if items[0] != source {
            items.insert(source, at: 0)
        }
        let length = items.count
        var sourceVal = source
        var visited = Array(repeating: false, count: length)
        let queue = Queue<String>()
        var map = [String: [String]]()
        for i in 1..<length {
            let item = items[i]
            var x = ""
            if hasOneLetterDifference(source: sourceVal, dest: dest) {
                x = dest
            }
            else if hasOneLetterDifference(source: sourceVal, dest: item) {
                x = item
            }
            
            if !x.isEmpty {
                if var listVal = map[sourceVal] {
                    listVal.append(x)
                    map[sourceVal] = listVal
                }
                else {
                    map[sourceVal] = [x]
                }
                sourceVal = x
                if x == dest {
                    break
                }
            }
        }
        
        queue.enqueue(val: items[0])
        visited[0] = true
        var counter = 1
        while !queue.isEmpty {
            let front = queue.dQueue()
            if let listVal = map[front] {
                for i in 0..<listVal.count {
                    let val = listVal[i]
                    if val == dest {
                        counter += 1
                        return counter
                    }
                    if let index = items.firstIndex(of: val), !visited[index] {
                        visited[index] = true
                        queue.enqueue(val: val)
                        counter += 1
                    }
                }
            }
        }
        
        return counter
    }
    
    static func canPlaceFlowers(list: [Int], n: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        var listVal = list
        let length = listVal.count
        if length < n {
            return false
        }
    
        if length == 1 {
            if listVal[0] == 1 && n == 0 {
                return false
            }
            return listVal[0] == 1 ? false : true
        }
        
        var counter = 0
        for index in 0..<length {
            if index == 0 && listVal[index] == 0 && listVal[index + 1] == 0 {
                counter += 1
                listVal[index] = 1
            }
            else if index == length - 1 && listVal[index] == 0 && listVal[index - 1] == 0 {
                counter += 1
                listVal[index] = 1
            }
            else {
                if (index - 1 >= 0 && index + 1 < length) && (listVal[index] == 0 && listVal[index - 1] == 0 && listVal[index + 1] == 0) {
                    counter += 1
                    listVal[index] = 1
                }
            }
        }
        return counter >= n
    }
    
    static func depthSumInverse(_ nestedList: [NestedInteger]) -> Int {
        let maxDepth = findMaxDepth(nestedList)
        let weightedSum = getWeightedSum(nestedList, maxDepth)
        return weightedSum
    }
    
    private static func findMaxDepth(_ nestedList: [NestedInteger]) -> Int {
        var currentMaxDepth = 0
        for nestedInt in nestedList {
            if nestedInt.isInteger() {
                currentMaxDepth = max(currentMaxDepth, 1)
            } else {
                let currentDepth = findMaxDepth(nestedInt.getList())
                currentMaxDepth = max(currentMaxDepth, currentDepth + 1)
            }
        }
        return currentMaxDepth
    }
    
    private static func getWeightedSum(_ nestedList: [NestedInteger], _ depth: Int) -> Int {
        var currentSum = 0
        for nestedInt in nestedList {
            if nestedInt.isInteger() {
                currentSum += nestedInt.getInteger() * depth
            } else {
                currentSum += getWeightedSum(nestedInt.getList(), depth - 1)
            }
        }
        return currentSum
    }
    
    static func depthSum(list: [Any]) -> Int {
        return nestedListWeight(list: list, depth: 1)
    }
    
    static func nestedListWeight(list: [Any], depth: Int) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var result = 0
        for item in list {
            if let val = item as? Int {
                result += val*depth
            }
            else if let val = item as? [Any] {
                result += nestedListWeight(list: val, depth: depth + 1)
            }
        }
        return result
    }
    
    static func evaluateReversePolish(list: [String]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let operators = ["+", "-", "*", "/"]
        
        let stack = Stack<Int>()
        for item in list {
            if let x = Int(item) {
                stack.push(val: x)
            }
            else {
                if operators.contains(item) {
                    let first = stack.pop()
                    let second = stack.pop()
                    switch item {
                    case "+":
                        stack.push(val: first + second)
                    case "-":
                        stack.push(val: second - first)
                    case "*":
                        stack.push(val: first * second)
                    case "/":
                        stack.push(val: second / first)
                    default:
                        print("None")
                    }
                }
            }
        }
        return !stack.isEmpty ? stack.pop() : -1
    }
    
    // Nice: DP
    static func maxProductSubArray(list: [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let length = list.count
        var maxSoFar = list[0]
        var minSoFar = list[0]
        var maxProd = maxSoFar

        for i in 1..<length {
            let curr = list[i]
            let temp = max(curr, max(maxSoFar * curr, minSoFar * curr))
            minSoFar = min(curr, min(maxSoFar * curr, minSoFar * curr))
            maxSoFar = temp
            maxProd = max(maxSoFar, maxProd)
        }
        
        return maxProd
    }
    
    static func shortestWordDistance(list: [String], source: String, dest: String) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let length = list.count
        if length == 1 {
            return 0
        }
        
        if length == 2 && list.contains(source) && list.contains(dest) {
            return 1
        }
        
        var start = -1
        var end = -1
        var dist = 0
        var ans = Int.max
        
        if list.contains(source) {
            for i in 0..<length {
                let val = list[i]
                if val == source {
                    if end != -1 {
                        dist = abs(i - end)
                        ans = min(dist, ans)
                    }
                    start = i
                }
                if val == dest {
                    if start != -1 {
                        dist = abs(i - start)
                        ans = min(dist, ans)
                    }
                    end = i
                }
            }
        }
        return ans
    }
    
    
    static func findSubSetsSet2(list: [Int], subset: inout [Int], index: Int, result: inout [[Int]]) {
        result.append(subset)
        for i in index..<list.count {
            subset.append(list[i])
            findSubSetsSet2(list: list, subset: &subset, index: index + 1, result: &result)
            subset.removeLast()
        }
    }
    
    static func findAllSubSetsSet2(list: [Int], numbreOfSets: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        var subset = [Int]()
        var result = [[Int]]()
        
        findSubSetsSet2(list: list, subset: &subset, index: 0, result: &result)
        
        var temp = [Int]()
        for item in result {
            var sum = 0
            for val in item {
                sum += val
            }
            temp.append(sum)
        }
        
        let count = getDuplicateCount(list: &temp)
        
        return numbreOfSets == count
    }
    
    static func checkDuplicateSumCount(_ list: [Int], _ setCount: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        var map = [Int: Int]()
        for item in list {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        
        for item in map {
            if item.value >= setCount {
                return true
            }
        }
        return false
    }
    
    static func findSubSets(list: [Int], subset: inout Set<Int>, index: Int, result: inout Set<Set<Int>>) {
        if index == list.count {
            return
        }
        result.insert(subset)
        for i in index..<list.count {
            subset.insert(list[i])
            findSubSets(list: list, subset: &subset, index: index + 1, result: &result)
            subset.remove(list[i])
        }
    }
    
    static func findAllSubSets(list: [Int], numberOfSets: Int) -> (Set<Set<Int>>, hasSetsOfEqualSum: Bool)? {
        if list.isEmpty {
            return nil
        }
        
        var subset = Set<Int>()
        var result = Set<Set<Int>>()
        
        findSubSets(list: list, subset: &subset, index: 0, result: &result)
        
        var temp = [Int]()
        for item in result {
            var sum = 0
            for val in item {
                sum += val
            }
            temp.append(sum)
        }
        
        let status = checkDuplicateSumCount(temp, numberOfSets)
        
        return (result, status)
    }
    
    static func detectCycleInUndirectedGraph(currentNode: Int, adjencyList: [Int: [Int]], visited: inout [Bool], parent: Int) -> Bool {
        visited[currentNode] = true
        
        if let list = adjencyList[currentNode] {
            for item in list {
                if !visited[item] {
                    if detectCycleInUndirectedGraph(currentNode: item, adjencyList: adjencyList, visited: &visited, parent: currentNode) {
                        return true
                    }
                }
                else if item != parent {
                    return true
                }
            }
        }
        return false
    }
    
    static func validGraphTree(edges: [[Int]], n: Int) -> Bool {
        
        var adjencyMat = [Int: [Int]]()
        for item in edges {
            if var list = adjencyMat[item[0]] {
                list.append(item[1])
                adjencyMat[item[0]] = list
            }
            else {
                adjencyMat[item[0]] = [item[1]]
            }
        }
        
        var visited = Array<Bool>(repeating: false, count: n)
        
        if detectCycleInUndirectedGraph(currentNode: 0, adjencyList: adjencyMat, visited: &visited, parent: -1) {
            return false
        }
        
        for item in visited {
            if !item {
                return false
            }
        }
        
        return true
    }
    
    static func accountMerge(accounts: [[String]]) -> [[String]] {
        if accounts.isEmpty {
            return []
        }
        
        var emailSet = Set<String>()
        let accList = accounts.map { Account(list: $0) }
        let length = accounts.count
        var result = [[String]]()
        
        for i in 0..<length - 1 {
            let x = accList[i]
            for j in i + 1..<length {
                let y = accList[j]
                var vals = [String]()
                var emails = [String]()
                let common = x.emails.intersection(y.emails)
                if !common.isEmpty && common.count == 1 {
                    vals.append(x.name)
                    let union = x.emails.union(y.emails)
                    vals.append(contentsOf: union)
                    emails.append(contentsOf: union)
                }
                else {
                    vals.append(y.name)
                    vals.append(contentsOf: y.emails)
                    emails.append(contentsOf: y.emails)
                }
                if !vals.isEmpty && emailSet.intersection(vals).isEmpty {
                    result.append(vals)
                    emails.forEach{ emailSet.insert($0) }
                }
            }
        }
        
        return result
    }
    
    private static func getLeavesOfBinaryTreeHelper(root: inout TreeNode?) -> [Int] {
        var set = [Int]()
        if root?.left == nil && root?.right == nil {
            if let val = root?.value {
                set.append(val)
            }
            root = nil
            return set
        }
        var left = root?.left
        let leftSet = getLeavesOfBinaryTreeHelper(root: &left)
        var right = root?.right
        let rightSet = getLeavesOfBinaryTreeHelper(root: &right)
        return leftSet + rightSet
    }
    
    static func getLeavesOfBinaryTree(nodes: [Int]) -> [[Int]] {
        if nodes.isEmpty {
            return []
        }
        
        var result = [[Int]]()
        var treeRoot: TreeNode? = BinaryTree.createBinaryTree(nodes: nodes)
        while treeRoot != nil {
            let x = getLeavesOfBinaryTreeHelper(root: &treeRoot)
            result.append(x)
        }
        return result
    }
    
    static func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.isEmpty || t.isEmpty {
            return false
        }
        
        let sVal = Array(s)
        let tVal = Array(t)
        
        let sLen = sVal.count
        let tLen = tVal.count

        if sLen != tLen {
            return false
        }
    
        var map = [Character: Character]()
        var set = Set<Character>()
        
        var j = 0
        var i = 0
        while i < sLen {
            if let val = map[sVal[i]] {
                if val != tVal[j] {
                    return false
                }
            }
            else {
                if !set.contains(tVal[j]) {
                    map[sVal[i]] = tVal[j]
                    set.insert(tVal[j])
                }
                else {
                    return false
                }
            }
            i += 1
            j += 1
        }
        
        return true
    }
    
    func hasCycle(_ head: SortedNode?) -> Bool {
        if head == nil {
            return false
        }
        
        var set = Set<SortedNode>()
        var curr = head
        while curr != nil {
            if let currVal = curr {
                if  set.contains(currVal) {
                    return true
                }
                set.insert(currVal)
            }
            curr = curr?.next
        }
        return false
    }
    
    static private func markNeighboursNodeVisited(mat : inout [[Int]], visited : inout [[Bool]], x : Int, y : Int, m : Int, n : Int) {
        
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
        
    static func numIslands(_ grid: [[Character]]) -> Int {
        
        if grid.isEmpty {
            return 0
        }
        
        var result = 0
        let innerList = grid[0]
        let m = grid.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        var matVal = Array(repeating: Array(repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if let val = Int(String(grid[i][j])), val == 1 {
                    matVal[i][j] = val
                }
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if matVal[i][j] == 1 {
                    result += 1
                    markNeighboursNodeVisited(mat: &matVal, visited: &visited, x: i, y: j, m: m, n: n)
                }
            }
        }
        return result
        
    }
    
    static func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        if nums1.isEmpty || nums2.isEmpty {
            return []
        }
        
        let len1 = nums1.count
        let len2 = nums2.count
        
        var result = [[Int]]()
        var vals = [PairItem]()
        for i in 0..<len1 {
            for j in 0..<len2 {
                vals.append(PairItem([nums1[i], nums2[j]]))
            }
        }
        
        let heap = Heap<PairItem>(type: .minHeap, list: vals)
        
        for _ in 1...k {
            if let item = heap.extract() {
                result.append(item.list)
            }
        }
        
        return result
    }
    
    static func smallestLetterGreaterThanTargetHelper(letters: [Character], target: Character, start: Int, end: Int) -> Int {
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        if mid >= 0 && mid + 1 <= end && letters[mid + 1] > target && letters[mid] <= target {
            return mid + 1
        }
        else if mid - 1 >= 0 && mid < end && letters[mid - 1] <= target && letters[mid] > target {
            return mid
        }
        else if mid >= 0 && mid < end && target < letters[mid] {
            return smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: start, end: mid - 1)
        }
        else {
            return smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: mid + 1, end: end)
        }
    }
    
    static func smallestLetterGreaterThanTarget(letters: [Character], target: Character) -> Character {
        if letters.isEmpty {
            return "a"
        }
        
        let start = 0
        let end = letters.count - 1
        if target < letters[start] {
            return letters[start]
        }
        let index = smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: start, end: end)
        let result = index != -1 ? letters[index] : letters[0]
        return result
    }
    
    static func isProductLessThan(target: Int, for list: [Int]) -> Bool {
        if list.isEmpty {
            return false
        }
        let product = list.reduce(1) { (val, curr) -> Int in
            return val * curr
        }
        return product < target
    }
    
    static func isProductEqualTo(target: Int, for list: [Int]) -> Bool {
        if list.isEmpty {
            return false
        }
        let product = list.reduce(1) { (val, curr) -> Int in
            return val * curr
        }
        return product == target
    }
    
    static func factorCombinationHelper(_ n: Int, _ start: Int, subset: inout Set<Int>, result: inout Set<Set<Int>>) {
        if start <= 1 {
            result.insert(subset)
            return
        }
        
        for i in start...n {
            if n % i == 0 {
                subset.insert(i)
                factorCombinationHelper(n / i, i, subset: &subset, result: &result)
                subset.remove(i)
            }
        }
    }
    
    static func factorCombination(target: Int) {
        var subset = Set<Int>()
        var result = Set<Set<Int>>()
        factorCombinationHelper(target, 2, subset: &subset, result: &result)
    }
    
    static func intToRomanSet2(_ num: Int) -> String {
        var result = ""
        if num >= 1 && num <= 3999 {
            var target = num
            let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
            let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
            for i in 0..<values.count {
                while values[i] <= target {
                    target -= values[i]
                    result += symbols[i]
                }
            }
        }
        return result
    }
    
    static func matrixMultiplication(mat1: [[Int]], mat2: [[Int]]) -> [[Int]] {
        if mat1.isEmpty {
            return mat2
        }
        else if mat2.isEmpty {
            return mat1
        }
        
        let m1 = mat1.count
        let n1 = mat1[0].count
        let m2 = mat2.count
        let n2 = mat2[0].count
            
        if n1 == m2 {
            var result = Array(repeating: Array(repeating: 0, count: n2), count: m1)
            for i in 0..<m1 {
                for l in 0..<n2 {
                    var sum = 0
                    var j = 0
                    for m in 0..<m2 {
                        let y = mat2[m][l]
                        let x = mat1[i][j]
                        sum += x*y
                        j += 1
                    }
                    result[i][l] = sum
                }
            }
            return result
        }
        
        return []
    }
    
    static func isPerfectSquare(_ n: Int) -> Bool {
        if n < 1 {
            return false
        }
        
        if n == 1 {
            return true
        }
        
        var left = 1
        var right = n
        
        while left <= right {
            
            let mid = (left + right) / 2
            
            if mid * mid == n {
                return true
            }
            else if mid * mid < n {
                left = mid + 1
            }
            else {
                right = mid - 1
            }
        }
        
        return false
    }
    
    static func squareRoot(_ n: Int) -> Int {
        if n < 1 {
            return 0
        }
        
        if n == 1 {
            return 1
        }
        
        var left = 1
        var right = n/2
        
        while left <= right {
            
            let mid = (left + right) / 2
            let val = mid * mid
            if val < n {
                left = mid + 1
            }
            else if val > n {
                right = mid - 1
            }
            else {
                return mid
            }
        }
        
        return right
    }
}
