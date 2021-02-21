//
//  Adobe.swift
//  DSA
//
//  Created by Nishit on 04/02/21.
//  Copyright © 2021 Mine. All rights reserved.
//

import Foundation

extension Problems {
    
    static func getID(x: Int, w: Int) -> Int {
        return x / w
    }
    
    static func containsNearbyAlmostDuplicateV3(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k < 1 || t < 0 {
            return false
        }
        
        let n = nums.count
        let width = t + 1
        var map = [Int: Int]()
        for i in 0..<n {
            let item = nums[i]
            let id = getID(x: item, w: width)
            if let _ = map[id] {
                return true
            }
            if let x = map[id - 1], abs((item - x)) < width {
                return true
            }
            if let x = map[id + 1], abs((item - x)) < width {
                return true
            }
            map[id] = item
            if i >= k {
                let idVal = getID(x: nums[i - k], w: width)
                map.removeValue(forKey: idVal)
            }
        }
        return false
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
    
    func smallestRangeII(_ A: [Int], _ K: Int) -> Int {
        if A.isEmpty {
            return -1
        }
        let list = A.sorted()
        let n = list.count
        var result = list[n - 1] - list[0]
        for i in 0..<n - 1 {
            let x = list[i]
            let y = list[i + 1]
            let low = min(list[0] + K, y - K)
            let high = max(list[n - 1] - K, x + K)
            result = min(result, high - low)
        }
        return result
    }
    
    static func removeDuplicateLetters(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let sVal = Array(s)
        var set = Set<Character>()
        let stack = Stack<Character>()
        var lastOccuranceMap = [Character: Int]()
        for i in 0..<sVal.count {
            lastOccuranceMap[sVal[i]] = i
        }
        
        var j = 0
        
        while j < sVal.count {
            let item = sVal[j]
            if !set.contains(item) {
                while !stack.isEmpty, let top = stack.top(), item < top, let x = lastOccuranceMap[top], x > j {
                    set.remove(stack.pop())
                }
                set.insert(item)
                stack.push(val: item)
            }
            j += 1
        }
        
        var result = ""
        while !stack.isEmpty {
            result = String(stack.pop()) + result
        }
        return result
    }
    
    func majorityElement2(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var map = [Int: Int]()
        for item in nums {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        
        let len = nums.count
        var result = [Int]()
        for x in map {
            if x.value > len / 3 {
                result.append(x.key)
            }
        }
        return result
    }
    
    static func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        if nums.isEmpty || nums.count <= 1 {
            return []
        }
        
        var result = [Int]()
        var temp = [Int]()
        temp.append(nums[0])
        result.append(nums[0])
        for i in 1..<nums.count {
            let item = nums[i]
            if let last = temp.last, item > last, item % last == 0 {
                temp.append(item)
                result.append(item)
            }
            else if item < nums[0], nums[0] % item == 0 {
                temp.insert(item, at: 0)
                result.append(item)
            }
            else {
                for j in 0..<temp.count - 1 {
                    if item > temp[j] && item < temp[j + 1] {
                        if item % temp[j] == 0 && temp[j + 1] % item == 0 {
                            temp.insert(item, at: j + 1)
                            result.append(item)
                        }
                    }
                }
            }
        }
        return result.count == 1 ? [] : result
    }
    
//    func longestWellPerformingInterval(_ hours: [Int]) -> Int {
//        if hours.isEmpty {
//            return 0
//        }
//        var list = Array<(t: Int, nt: Int)>(repeating: (0,0), count: hours.count)
//        if hours[0] > 8 {
//            list[0].t = 1
//        }
//        else {
//            list[0].nt = 1
//        }
//        for i in 1..<hours.count {
//            let item = hours[i]
//            let prev = list[i - 1]
//            if item > 8 {
//                list[i] = (prev.t + 1, prev.nt)
//            }
//            else {
//                list[i] = (prev.t, prev.nt + 1)
//            }
//        }
//        for j in 0..<list.count {
//            if list[j].t <  {
//                <#code#>
//            }
//        }
//        return 0
//    }
    
    func deleteDuplicatesV2(_ head: SortedNode?) -> SortedNode? {
        if head == nil {
            return head
        }
        let dummy = SortedNode(-1)
        dummy.next = head
        var curr = head
        var prev: SortedNode? = dummy
        while curr != nil {
            if let x = curr?.val, let nextVal = curr?.next?.val, x == nextVal {
                while let x = curr?.val, let nextVal = curr?.next?.val, x == nextVal {
                    curr = curr?.next
                }
                prev?.next = curr?.next
            }
            else {
                prev = curr
            }
            curr = curr?.next
        }
        return dummy.next
    }
    
    func rangeBitwiseAnd(_ m: Int, _ n: Int) -> Int {
        var result = n
        while m < result {
            result = result & (result - 1)
        }
        return result & m
    }
    
    static func dfsLexicalOrderNumbers(_ i: Int, _ n: Int, _ result: inout [Int]) {
        if i > n {
            return
        }
        result.append(i)
        for j in 0..<10 {
            dfsLexicalOrderNumbers(10*i + j, n, &result)
        }
    }
    
    static func lexicalOrderNumbers(_ n: Int) -> [Int] {
        var result = [Int]()
        for i in 1...9 {
            dfsLexicalOrderNumbers(i, n, &result)
        }
        return result
    }
    
    //https://www.geeksforgeeks.org/min-cost-path-dp-6/ minCost
    // This is when user moves right, down
    static func minPathSumV3(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        
        let m = grid.count
        let n = grid[0].count
        let dstX = m - 1
        let dstY = n - 1
        
        var dp = Array(repeating: Array(repeating: 0, count: n), count: m)
        dp[0][0] = grid[0][0]
        
        for i in 0..<m {
            if i >= 1 {
                dp[i][0] =  dp[i - 1][0] + grid[i][0]
            }
        }
        
        for j in 0..<n {
            if j >= 1 {
                dp[0][j] =  dp[0][j - 1] + grid[0][j]
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if i >= 1 && j >= 1 {
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j]
                }
            }
        }
        
        return dp[dstX][dstY]
    }
    
    func generateTreesHelper(_ start: Int, _ end: Int) -> [TreeNode?] {
        var list = Array<TreeNode?>()
        if start > end {
            list.append(nil)
            return list
        }
        
        for i in start...end {
            let left = generateTreesHelper(start, i - 1)
            let right = generateTreesHelper(i + 1, end)
            for l in left {
                for r in right {
                    let currNode = TreeNode(val: i)
                    currNode.left = l
                    currNode.right = r
                    list.append(currNode)
                }
            }
        }
        return list
    }
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        if n <= 0 {
            return []
        }
        return generateTreesHelper(1, n)
    }
    
    //Catalan Number = nCn+1 = 2(2n + 1)/(n + 2)
    func numOfUniqueBST(_ n: Int) -> Int {
        var value: Double = 1
        for i in 0..<n {
            let x = Double(i)
            value = value * (2*(2*x + 1)/(x + 2))
        }
        return Int(value)
    }
    
    static func convertToTitle(_ n: Int) -> String {
        if n < 1 {
            return ""
        }
        
        let a: Character = "A"
        let aAscii = a.asciiValue ?? 65
        let aAsciiInt = Int(aAscii)
        var val = n
        var result = ""
        while val > 0 {
            var y = val % 26
            if y == 0 {
                y = 26
                val -= 1
            }
            result = String(UnicodeScalar(UInt8(aAsciiInt + y - 1))) + result
            val = val / 26
        }
        return result
    }
    
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        else if root?.left == nil && root?.right == nil {
            return 1
        }
        var minDepthVal = Int.max
        if root?.left != nil {
            minDepthVal = min(minDepth(root?.left), minDepthVal)
        }
        if root?.right != nil {
            minDepthVal = min(minDepth(root?.right), minDepthVal)
        }
        return minDepthVal + 1
    }
    
    static func searchInsertV2(list: [Int], val: Int) -> Int {
        if list.isEmpty {
            return -1
        }
        
        let length = list.count
        var left = 0
        var right = length - 1
        while left <= right {
            let mid = (left + right)/2
            if val == list[mid] {
                return mid
            }
            else if val < list[mid] {
                right = mid - 1
            }
            else {
                left = mid + 1
            }
        }
        return left
    }
    
    func twoSumIndexes(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var map = [Int: Int]()
        for i in 0..<nums.count {
            map[nums[i]] = i
        }
        var set = Set<Int>()
        for i in 0..<nums.count {
            let x = target - nums[i]
            if set.contains(x), let index = map[x] {
                return [index, i]
            }
            set.insert(nums[i])
        }
        return []
    }
    
    func climbStairsV2(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        else if n == 2 {
            return 2
        }
        var a = 1
        var b = 2
        var c = 0
        for _ in 3...n {
            c = a + b
            a = b
            b = c
        }
        return c
    }
    
    func climbStairsNStairsMSteps(_ n: Int, _ m: Int) -> Int {
        if n == 1 {
            return 1
        }
        else if n == 2 {
            return 2
        }
        var list = Array(repeating: 0, count: n + 1)
        list[1] = 1
        for i in 2...n {
            for j in 1...m {
                if i <= j {
                    list[i] += list[i - j]
                }
            }
        }
        return list[n]
    }
    
    func climbStairsNStairsMStepsV2(_ n: Int, _ m: Int) -> Int {
        if n == 1 {
            return 1
        }
        else if n == 2 {
            return 2
        }
        var list = Array(repeating: 0, count: n + 1)
        var temp = 0
        for i in 1...n {
            let x = i - m - 1
            if x >= 0 {
                temp -= list[x]
            }
            temp += list[i - 1]
            list[i] = temp
        }
        return list[n]
    }
    
    func sumOfLeftLeavesHelper(_ root: TreeNode?, _ side: String) -> Int {
        if root == nil {
            return 0
        }
        var x = 0
        if side == "l", root?.left == nil, root?.right == nil, let val = root?.value {
            x = val
        }
        return x + sumOfLeftLeavesHelper(root?.right, "r") + sumOfLeftLeavesHelper(root?.left, "l")
    }
    
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return sumOfLeftLeavesHelper(root, "r")
    }
    
    func findDisappearedNumbersV2(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var items = nums
        for i in 0..<items.count {
            if items[abs(items[i]) - 1] > 0 {
                items[abs(items[i]) - 1] = -items[abs(items[i]) - 1]
            }
        }
        var result = [Int]()
        for i in 0..<items.count {
            if items[i] > 0 {
                result.append(i + 1)
            }
        }
        return result
    }
    
    static func containsDuplicateV2(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        var items = nums
        for i in 0..<items.count {
            if items[abs(items[i]) - 1] > 0 {
                items[abs(items[i]) - 1] = -items[abs(items[i]) - 1]
            }
            else {
                return true
            }
        }
        return false
    }
    
    func canWinNim(_ n: Int) -> Bool {
        var list = Array<Int>(repeating: 0, count: n + 1)
        list[1] = 1
        list[2] = 2
        var left = n - 3
        var j = 3
        while left > 0 && j <= n  {
            if j % 2 != 0 {
                if left <= 3 {
                    return true
                }
            }
            list[j] = list[j - 3] + list[j - 2] + list[j - 1]
            left -= list[j]
            j += 1
        }
        return false
    }
    
    func findTheDifference(_ s: String, _ t: String) -> Character {
        let sVal = Array(s)
        var tVal = Array(t)
        for i in 0..<sVal.count {
            if let index = tVal.firstIndex(of: sVal[i]) {
                tVal.remove(at: index)
            }
        }
        return tVal[0]
    }
    
    //XOR Operation
    func findTheDifferenceV2(_ s: String, _ t: String) -> Character {
        let sVal = Array(s)
        let tVal = Array(t)
        var x: UInt8 = 0
        for i in 0..<sVal.count {
            if let val = sVal[i].asciiValue {
                x ^= val
            }
        }
        for i in 0..<tVal.count {
            if let val = tVal[i].asciiValue {
                x ^= val
            }
        }
        return Character(UnicodeScalar(x))
    }
    
    func getSum(_ a: Int, _ b: Int) -> Int {
        var x = abs(a)
        var y = abs(b)
        if x < y {
            return getSum(b, a)
        }
        
        let sign = a > 0 ? 1 : -1
        
        if a*b > 0 {
            while y != 0 {
                let ans = x ^ y
                let carry = (x & y) << 1
                x = ans
                y = carry
            }
        }
        else {
            while y != 0 {
                let ans = x ^ y
                let carry = (~x & y) << 1
                x = ans
                y = carry
            }
        }
        
        return x * sign
    }
    
    func countBits(_ num: Int) -> [Int] {
        var result = [Int]()
        for i in 0...num {
            var one = 1
            var n = i
            var counter = 0
            for _ in 0..<32 {
                n ^= one
                if n != 0 {
                    counter += 1
                }
                one = one << 1
            }
            result.append(counter)
        }
        return result
    }
    
    func reverseBits(_ n: Int) -> Int {
        var result = 0
        var nVal = n
        var pow = 31
        while nVal != 0 {
            result += (n & 1) << pow
            nVal = nVal >> 1
            pow -= 1
        }
        return result
    }
    
    func robHouseHelper(_ nums: [Int], _ start: Int, _ end: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var prevMax = 0
        var currMax = 0
        for i in start...end {
            let x = currMax
            currMax = max(prevMax + nums[i], currMax)
            prevMax = x
        }
        return currMax
    }
    
    func robHouse2(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let max1 = robHouseHelper(nums, 0, nums.count - 2)
        let max2 = robHouseHelper(nums, 1, nums.count - 1)
        return max(max1, max2)
    }
}

// Segment Tree
class NumArray {

    private var tree = Array<Int>()
    private var list = [Int]()
    init(_ nums: [Int]) {
        if !nums.isEmpty {
            list = nums
            tree = Array<Int>(repeating: 0, count: NumArray.getNumberOfTreeNodes(nums.count))
            buildTree(&tree, nums, 0, nums.count - 1, 0)
        }
    }
    
    func update(_ index: Int, _ val: Int) {
        if index < list.count {
            list[index] = val
            updateTree(&tree, list, 0, list.count - 1, 0, index)
        }
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        let result = subRangeSumHelper(tree, left, right, 0, list.count - 1, 0)
        return result
    }
    
    private static func getNumberOfTreeNodes(_ n: Int) -> Int {
        var x = 2
        while true {
            if x == n || x > n {
                return 2*x - 1
            }
            x = x * 2
        }
    }
    
    private func buildTree(_ tree: inout [Int], _ input: [Int], _ l: Int, _ r: Int, _ pos: Int) {
        if l == r {
            tree[pos] = input[l]
            return
        }
        let mid = (l + r)/2
        let leftChild = 2*pos + 1
        let rightChild = 2*pos + 2
        buildTree(&tree, input, l, mid, leftChild)
        buildTree(&tree, input, mid + 1, r, rightChild)
        tree[pos] = tree[leftChild] + tree[rightChild]
    }
    
    private func updateTree(_ tree: inout [Int], _ input: [Int], _ l: Int, _ r: Int, _ pos: Int, _ index: Int) {
        if l == r {
            tree[pos] = input[index]
            return
        }
        let mid = (l + r)/2
        let leftChild = 2*pos + 1
        let rightChild = 2*pos + 2
        if index > mid {
            buildTree(&tree, input, mid + 1, r, rightChild)
        }
        else {
            buildTree(&tree, input, l, mid, leftChild)
        }
        tree[pos] = tree[leftChild] + tree[rightChild]
    }
    
    private func subRangeSumHelper(_ tree: [Int], _ lInput: Int, _ rInput: Int, _ left: Int, _ right: Int, _ pos: Int) -> Int {
        if left >= lInput && right <= rInput {
            return tree[pos]
        }
        else if left > rInput || right < lInput {
            return 0
        }
        let mid = (left + right)/2
        return subRangeSumHelper(tree, lInput, rInput, left, mid, 2*pos + 1) + subRangeSumHelper(tree, lInput, rInput, mid + 1, right, 2*pos + 2)
    }
}

class UglyNumberSolution {
    
    private var list = Array<Int>(repeating: 0, count: 1690)
    init() {
        var i2 = 0
        var i3 = 0
        var i5 = 0
        list[0] = 1
        var nextVal = 1
        var nextVal2 = 2
        var nextVal3 = 3
        var nextVal5 = 5
        for i in 1..<1690 {
            nextVal = min(min(nextVal2, nextVal3), nextVal5)
            list[i] = nextVal
            if nextVal == nextVal2 {
                i2 += 1
                nextVal2 = list[i2] * 2
            }
            if nextVal == nextVal3 {
                i3 += 1
                nextVal3 = list[i3] * 3
            }
            if nextVal == nextVal5 {
                i5 += 1
                nextVal5 = list[i5] * 5
            }
        }
    }
    func nthUglyNumber(_ n: Int) -> Int {
        return n <= 1690 ? list[n - 1] : -1
    }
}
