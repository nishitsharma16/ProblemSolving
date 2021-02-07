//
//  Facebook.swift
//  DSA
//
//  Created by Nishit on 15/09/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    
    static func continuousSubArraySum(list: [Int], k: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        if k == 0 && list.reduce(0, +) == 0  {
            return true
        }
        else if k == 0 {
            return false
        }
        
        let length = list.count
        var mat = Array(repeating: Array(repeating: 0, count: length), count: length)
        
        for i in 0..<length {
            mat[i][i] = list[i]
        }
        
        for l in 2...length {
            for i in 0..<length - l + 1 {
                let j = i + l - 1
                if (mat[i][j - 1] + list[j]) % k == 0 {
                    return true
                }
                else {
                    mat[i][j] = list[j] + mat[i][j - 1]
                }
            }
        }
        
        return false
    }
    
    func cloneGraph(_ node: GrapthNode?) -> GrapthNode? {
            guard let root = node else { return nil }
            
            var map = [GrapthNode: GrapthNode]()
            let queue = Queue<GrapthNode>()
            queue.enqueue(val: root)
            
            let cloneRootNode = GrapthNode(root.val)
            map[root] = cloneRootNode
            
            while !queue.isEmpty {
                let front = queue.dQueue()
                let list = front.neighbours
                for item in list {
                    if let _ = map[item] {
                        
                    }
                    else {
                        let cloneNode = GrapthNode(item.val)
                        map[item] = cloneNode
                        queue.enqueue(val: item)
                    }
                    if let frontMapClone = map[front], let newCloneNode = map[item] {
                        frontMapClone.neighbours.append(newCloneNode)
                    }
                }
            }
            return cloneRootNode
        }
    
//    static func checkAnagram(_ str: String, _ map: [Character: Int]) -> Bool {
//        var inner = map
//        for item in str {
//            if let _ = inner[item] {
//                inner[item] = 0
//            }
//        }
//        
//        for item in inner {
//            if item.value == 1 {
//                return false
//            }
//        }
//        return true
//    }
//    
//    static func findAnagrams(_ s: String, _ p: String) -> [Int] {
//        if s.isEmpty {
//            return []
//        }
//        
//        let slen = s.count
//        let plen = p.count
//
//        var map = [Character: Int]()
//        for item in p {
//            map[item] = 1
//        }
//        
//        var result = [Int]()
//        var start = s.startIndex
//        for i in 0..<slen - plen + 1 {
//            let end = s.index(start, offsetBy: plen - 1)
//            let subStr = String(s[start...end])
//            if checkAnagram(subStr, map) {
//                result.append(i)
//            }
//            start = s.index(after: start)
//        }
//        
//        return result
//    }
    
    static func countSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        if nums.count == 1 {
            return nums[0] == k ? 1 : 0
        }
        
        let length = nums.count
        var mat = Array(repeating: Array(repeating: 0, count: length), count: length)
        var counter = 0
        
        for i in 0..<length {
            mat[i][i] = nums[i]
            if mat[i][i] == k {
                counter += 1
            }
        }
        
        for l in 2...length {
            for i in 0..<length - l + 1 {
                let j = i + l - 1
                if (mat[i][j - 1] + nums[j]) == k {
                    counter += 1
                }
                mat[i][j] = nums[j] + mat[i][j - 1]
            }
        }
        
        return counter
    }
    
    static func reverseWords(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let str = s.trimmingCharacters(in: .whitespacesAndNewlines)
        var result = ""
        let words = str.split { $0 == " " }
        let numberOfSpaes = words.count - 1
        let last = numberOfSpaes
        for i in stride(from: last, through: 1, by: -1) {
            result += words[i]
            result += " "
        }
        result += words[0]
        return result
    }
    
    static func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 || denominator == 0 {
            return "0"
        }
        
        if denominator == 0 {
            return "0"
        }
    
        let isResultNegative = numerator > 0 && denominator < 0 || numerator < 0 && denominator > 0
        let num = abs(numerator)
        let deno = abs(denominator)
        var fraction = "\(num / deno)"
        var remainder = num % deno
        if remainder == 0 {
            return fraction
        }
        else {
            var map = [Int: Int]()
            fraction += "."
            while remainder != 0 {
                if let length = map[remainder] {
                    let index = fraction.index(fraction.startIndex, offsetBy: length)
                    fraction.insert("(", at: index)
                    fraction += ")"
                    break
                }
                map[remainder] = fraction.count
                remainder *= 10
                fraction += "\(remainder / deno)"
                remainder = remainder % deno
            }
            return isResultNegative ? "-" + fraction : fraction
        }
    }
    
    static func zeroPosition(_ s: String) -> Int? {
        for index in 0..<s.count {
            if s[index] == "0" {
                return index
            }
        }
        return nil
    }
    
    static func numDecodings(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        let length = s.count
        var result = 0
        let zeroPos = zeroPosition(s)
        if length == 1 {
            if let _ = zeroPos {
                return 0
            }
            else {
                return 1
            }
        }
        else if length == 2 {
            if let val = zeroPos {
                if val == 0 {
                    return 0
                }
                else {
                    if let x = Int(s), x < 26 {
                        return 1
                    }
                }
            }
            else {
                result += 1
                if let x = Int(s), x <= 26 {
                    return result + 1
                }
                return result
            }
        }
        else {
            if let val = zeroPos {
                if val == 0 {
                    return 0
                }
                else {
                    
                }
            }
        }
        return result
    }
    
    private static func decodeWaysHelper(_ s: String, _ index: Int, map: inout [Int : Int]) -> Int {
        
        if index < s.count && s[index] == "0" {
            return 0
        }
        
        if index == s.count - 1 {
            return 1
        }
        
        if index == s.count {
            return 1
        }
        
        if let x = map[index] {
            return x
        }
        
        var result = decodeWaysHelper(s, index + 1, map: &map)
        
        if let y = Int(String(s[s.index(s.startIndex, offsetBy: index)..<s.index(s.startIndex, offsetBy: index + 2)])), y <= 26 {
            result += decodeWaysHelper(s, index + 2, map: &map)
        }
        
        map[index] = result
        
        return result
    }
    
    static func decodeWays(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var map = [Int: Int]()
        let x = decodeWaysHelper(s, 0, map: &map)
        return x
    }
    
    static func kDiffPairs(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty || nums.count == 1 {
            return 0
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
        var counter = 0
        
        for item in map.enumerated() {
            let key = item.element.key
            let val = item.element.value
            if k > 0 , let _ = map[key + k] {
                counter += 1
            }
            else if k == 0 && val > 1 {
                counter += 1
            }
        }
        
        return counter
    }
    
    static func missingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {
        if nums.isEmpty {
            return [formatString(lower, upper)]
        }
        var result = [String]()
        let len = nums.count
        if lower < nums[0] {
            result.append(formatString(lower, nums[0] - 1))
        }
        
        for i in 1..<len {
            if nums[i] - nums[i - 1] > 1 {
                result.append(formatString(nums[i - 1] + 1, nums[i] - 1))
            }
        }
        
        if upper > nums[len - 1] {
            result.append(formatString(nums[len - 1] + 1, upper))
        }
        
        return result
    }
    
    static func formatString(_ lower: Int, _ upper: Int) -> String {
        if lower == upper {
            return "\(lower)"
        }
        return "\(lower)->\(upper)"
    }
    
    func validateBST(_ root: TreeNode?, min: Int, max: Int) -> Bool {
        if let rootVal = root {
            if rootVal.value >= max {
                return false
            }
            if rootVal.value <= min {
                return false
            }
            return validateBST(rootVal.left, min: min, max: rootVal.value - 1) && validateBST(rootVal.right, min: rootVal.value + 1, max: max)
        }
        return true
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return validateBST(root, min: Int.min, max: Int.max)
    }
    
    static func removeKdigits(_ num: String, _ k: Int) -> String {
        if num.isEmpty {
            return ""
        }
        
        if k == 0 {
            return num
        }
        
        var kVal = k
        let stack = Stack<Character>()
        for item in num {
            while !stack.isEmpty, kVal > 0, let x = stack.top(), x > item {
                stack.pop()
                kVal -= 1
            }
            stack.push(val: item)
        }
        
        for _ in 0..<k {
            stack.pop()
        }
        
        var str = ""
        var leadingZero = true
        for val in stack.items {
            if leadingZero && val == "0" {
                
            }
            else {
                leadingZero = false
                str.append(val)
            }
        }
        
        return str.isEmpty ? "0" : str
    }

    static func dfsSolve(_ board: inout [[Character]], _ x: Int, _ y: Int, _ state: inout [[(visited: Bool, flip: Int)]], _ m : Int, _ n: Int) {
        var item = state[x][y]
        item.visited = true
        item.flip = 0
        state[x][y] = item

        let dir = [(1, 0), (-1, 0), (0, -1), (0, 1)]
        for item in dir {
            let i = x + item.0
            let j = y + item.1
            if i >= 0 && j >= 0 && i < m && j < n {
                let val = state[i][j]
                if !val.visited && board[i][j] == "O" {
                    dfsSolve(&board, i, j, &state, m, n)
                }
            }
        }
    }
    
    static func solve(_ board: inout [[Character]]) {
        if board.isEmpty {
            return
        }
        
        let m = board.count
        let n = board[0].count
        var state = Array(repeating: Array(repeating: (visited: false, flip: 1), count: board[0].count), count: board.count)

        for i in 0..<m {
            for j in 0..<n {
                if (i == 0 || j == 0 || i == m - 1 || j == n - 1) && board[i][j] == "O" {
                    let item = state[i][j]
                    if !item.visited {
                        dfsSolve(&board, i, j, &state, m, n)
                    }
                }
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                let item = state[i][j]
                if board[i][j] == "O" && item.flip == 1 {
                    board[i][j] = "X"
                }
            }
        }
    }
    
    static func largestNumber(_ nums: [Int]) -> String {
        if nums.isEmpty {
            return ""
        }
        
        let x = nums.reduce(0, +)
        if x == 0 {
            return "0"
        }
        
        let val = nums.sorted { (first, second) -> Bool in
            let x = "\(first)\(second)"
            let y = "\(second)\(first)"
            return x > y
        }
        
        let result = val.reduce("") { (result, curr) -> String in
            return result + "\(curr)"
        }
        return result
    }
    
    static func wiggleSort(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        
        let length = nums.count
        let val = nums.sorted { $0 > $1 }
        var mid = length / 2
        
        var j = 0
        for i in 0..<length {
            if i % 2 == 0 {
                nums[i] = val[mid]
                mid += 1
            }
            else {
                nums[i] = val[j]
                j += 1
            }
        }
    }
    
    static func checkValidParenthesisString(_ s: String) -> Bool {
        if s.isEmpty {
            return true
        }
        
        let list = s.map { String($0) }
        var low = 0
        var high = 0
        
        for item in list {
            low += item == "(" ? 1 : -1
            high += item != ")" ? 1 : -1
            if high < 0 {
                break
            }
            low = max(low, 0)
        }
        
        return low == 0
    }
    
    static func nextGreaterNumber3(_ n: Int) -> Int {
        if n < 10 {
            return -1
        }
        
        var list = [Int]()
        var number = n
        while number > 0 {
            list.append(number % 10)
            number /= 10
        }
        
        list.reverse()
        let length = list.count
        var i = length - 2
        while i >= 0 && list[i + 1] <= list[i] {
            i -= 1
        }
        
        if i == -1 {
            return -1
        }
        
        var j = length - 1
        while j >= 0 && list[i] >= list[j] {
            j -= 1
        }
        
        list.swapAt(i, j)
        list.reverseArray(start: i + 1, end: length - 1)
        
        i = 0
        var result = 0
        for item in list {
            result = result * 10 + item
        }
        
        return result == 0 ? -1 : result
    }
    
    static func check(_ node: SortedNode?, _ insertVal: Int) -> Bool {
        if let next = node?.next, let val = node?.val, val <= insertVal && insertVal <= next.val {
            return true
        }
        if let next = node?.next, let val = node?.val, val > next.val {
            if insertVal >= val || insertVal <= next.val {
                return true
            }
        }
        return false
    }
    
    static func insert(_ head: SortedNode?, _ insertVal: Int) -> SortedNode? {
        if head == nil {
            let headval = SortedNode(insertVal)
            headval.next = headval
            return headval
        }
        if head?.next == head {
            let insert = SortedNode(insertVal)
            insert.next = head
            head?.next = insert
            return head
        }
        var curr: SortedNode? = head
        let temp = SortedNode(-1)
        temp.next = head
        while !check(curr, insertVal) {
            curr = curr?.next
            if curr === head {
                break
            }
        }
        let insert = SortedNode(insertVal)
        insert.next = curr?.next
        curr?.next = insert
        return temp.next
    }
    
    static func findNthDigit(_ n: Int) -> Int {
        if n <= 0 {
            return -1
        }
        
        var nVal = n
        var rangeVal = 9
        var length = 1
        while nVal - (rangeVal * length) > 0 {
            nVal -= rangeVal * length
            length += 1
            rangeVal *= 10
        }
        
        let digitVal = (nVal - 1) / length
        let digitPos = (nVal - 1) % length
        let number = "\((rangeVal / 9) + digitVal)"
        let digit = String(number[digitPos])
        return Int(digit) ?? -1
    }
    
    static func isOneEditDistance(_ s: String, _ t: String) -> Bool {
        let sLen = s.count
        let tLen = t.count
        
        if sLen > tLen {
            return isOneEditDistance(t, s)
        }
        
        if tLen - sLen > 1 {
            return false
        }
            
        var foundForEqualLength = false
        var foundForDiffLength = false
        var index = 0
        
        for i in 0..<s.count {
            if s[i] != t[i] {
                if sLen == tLen {
                    foundForEqualLength = true
                    index = i
                    break
                }
                else {
                    foundForDiffLength = true
                    index = i
                    break
                }
            }
        }
        
        if foundForEqualLength {
            let index = s.index(s.startIndex, offsetBy: index + 1)
            return s[index..<s.endIndex] == t[index..<t.endIndex]
        }
        else if foundForDiffLength {
            let indexS = s.index(s.startIndex, offsetBy: index)
            let indexT = s.index(s.startIndex, offsetBy: index + 1)
            return s[indexS..<s.endIndex] == t[indexT..<t.endIndex]
        }
        return sLen + 1 == tLen
    }
    
    
    static func lps(pat : ArraySlice<Character>) -> [Int] {
        let str = pat
        if str.isEmpty {
            return []
        }
        let strLen = str.count
        var lps = Array<Int>(repeating: 0, count: strLen)
        var length = 0
        lps[0] = 0
        var index = 1
        while index < strLen {
            if str[index] == str[length] {
                length += 1
                lps[index] = length
                index += 1
            }
            else {
                if length != 0 {
                    length = lps[length - 1]
                }
                else {
                    if length == 0 {
                        lps[index] = 0
                        index += 1
                    }
                }
            }
        }
        return lps
    }
    
    static func kmpAlgorithmForFirstIndex(str : ArraySlice<Character>, pat : ArraySlice<Character>) -> Int {
        let strVal = str
        let patVal = pat

        if strVal.isEmpty || patVal.isEmpty {
            return -1
        }
        
        let strLength = strVal.count
        let patLength = patVal.count
        
        if patLength > strLength {
            return -1
        }
        
        let lpsVal = lps(pat: patVal)
        
        var i = 0
        var j = 0
        
        while i < strLength {
            if strVal[i] == patVal[j] {
                i += 1
                j += 1
            }
            
            if j == patLength {
                return i - j
            }
            else if i < strLength && patVal[j] != strVal[i] {
                if j > 0 {
                    j = lpsVal[j - 1]
                }
                else {
                    i += 1
                }
            }
        }
        return -1
    }
    
    static func repeatedStringMatch(_ a: String, _ b: String) -> Int {
        var strA = Array(a)[0...]
        let strB = Array(b)[0...]
        var counter = 1
        while strA.count < strB.count {
            strA += strA
            counter += 1
        }
        
        if kmpAlgorithmForFirstIndex(str: strA, pat: strB) != -1 {
            return counter
        }
        strA += strA
        if kmpAlgorithmForFirstIndex(str: strA, pat: strB) != -1 {
            return counter + 1
        }
        
        return -1
    }
    
    static func nextPermutation(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        
        let length = nums.count
        var i = length - 2
        while i >= 0 && nums[i + 1] <= nums[i] {
            i -= 1
        }
        
        if i == -1 {
            nums.sort()
            return
        }
        
        var j = length - 1
        while j >= 0 && nums[i] >= nums[j] {
            j -= 1
        }
        
        nums.swapAt(i, j)
        nums.reverseArray(start: i + 1, end: length - 1)
    }
    
    
    static func getPivotPosition(_ nums: [Int], _ l: Int, _ r: Int, _ length: Int) -> Int {
        if l > r {
            return -1
        }
        let mid = (l + r) / 2
        if mid - 1 >= 0 && mid + 1 < length && nums[mid] < nums[mid - 1] && nums[mid] <= nums[mid + 1] {
            return mid
        }
        else if mid - 1 >= 0 && mid + 1 < length && nums[mid] >= nums[mid - 1] && nums[mid] > nums[mid + 1] {
            return mid + 1
        }
        else if mid - 1 >= 0 && mid + 1 < length && nums[mid] > nums[mid - 1] && nums[mid] <= nums[mid + 1] {
            return getPivotPosition(nums, mid + 1, r, length)
        }
        else {
            return getPivotPosition(nums, l, mid - 1, length)
        }
    }
    
    static func searchInSortedPart(_ nums: [Int], start: Int, end: Int, _ target: Int) -> Bool {
        if start > end {
            return false
        }
        
        let mid = (start + end) / 2
        if nums[mid] == target {
            return true
        }
        else if target < nums[mid] {
            return searchInSortedPart(nums, start: start, end: mid - 1, target)
        }
        else {
            return searchInSortedPart(nums, start: mid + 1, end: end, target)
        }
    }
    
    static func searchHelper(_ nums: [Int], _ target: Int, _ l: Int, _ r: Int) -> Bool {
        if l > r {
            return false
        }
        
        let mid = (l + r) / 2
        if nums[mid] == target {
            return true
        }
        
        let leftSorted = nums[l] <= nums[mid]
        let righSorted = nums[mid] <= nums[r]
        
        if leftSorted && righSorted {
            return searchHelper(nums, target, l, mid - 1) || searchHelper(nums, target, mid + 1, r)
        }
        else if righSorted {
            if target > nums[mid] && target <= nums[r] {
                return searchHelper(nums, target, mid + 1, r)
            }
            else {
                return searchHelper(nums, target, l, mid - 1)
            }
        }
        else if leftSorted {
            if target >= nums[l] && target < nums[mid] {
                return searchHelper(nums, target, l, mid - 1)
            }
            else {
                return searchHelper(nums, target, mid + 1, r)
            }
        }
        return false
    }
    
    static func search(_ nums: [Int], _ target: Int) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        let length = nums.count
        return searchHelper(nums, target, 0, length - 1)
    }
    
    static func searchForIndexHelper(_ nums: [Int], _ target: Int, _ l: Int, _ r: Int) -> Int {
        if l > r {
            return -1
        }
        
        let mid = (l + r) / 2
        if nums[mid] == target {
            return mid
        }
        
        let leftSorted = nums[l] <= nums[mid]
        let righSorted = nums[mid] <= nums[r]
        
        if righSorted {
            if target > nums[mid] && target <= nums[r] {
                return searchForIndexHelper(nums, target, mid + 1, r)
            }
            else {
                return searchForIndexHelper(nums, target, l, mid - 1)
            }
        }
        else if leftSorted {
            if target >= nums[l] && target < nums[mid] {
                return searchForIndexHelper(nums, target, l, mid - 1)
            }
            else {
                return searchForIndexHelper(nums, target, mid + 1, r)
            }
        }
        return -1
    }
    
    static func searchForIndex(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let length = nums.count
        return searchForIndexHelper(nums, target, 0, length - 1)
    }
    
    static func simplifyPath(_ path: String) -> String {
        if path.isEmpty {
            return ""
        }
        
        let list = path.split(separator: "/", maxSplits: Int.max, omittingEmptySubsequences: true)
        let stack = Stack<String>()
        
        for item in list {
            if item == ".." {
                if !stack.isEmpty {
                    stack.pop()
                }
            }
            else if item != "." {
                stack.push(val: String(item))
            }
        }
        
        var result = ""
        while !stack.isEmpty {
            result = "/" + stack.pop() + result
        }
        
        return result.isEmpty ? "/" : result
    }
    
    static func multiplyHelper(_ num1: String, _ num2: String) -> String {
        guard let x = Int(num2) else { return "" }
        if x == 0 {
            return "0"
        }
        else if x == 1 {
            return num1
        }
        
        var result = ""
        var div = 0
        for item in num1 {
            if let y = Int(String(item)) {
                let m = y * x + div
                let rem = m % 10
                div = m / 10
                result = "\(rem)" + result
            }
        }
        
        if div != 0 {
            result = "\(div)" + result
        }
        return result
    }
    
    static func multiply(_ num1: String, _ num2: String) -> String {
        if num1.isEmpty || num2.isEmpty {
            return ""
        }
        
        var multiplier = 1
        for item in num2 {
            
        }
        
        return ""
    }
    
    static func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        if intervals.isEmpty {
            return [newInterval]
        }
        
        let length = intervals.count
        var result = [[Int]]()
        var index = 0
        let newIntervalStart = newInterval[0]
        let newIntervalEnd = newInterval[1]
        while index < length && newIntervalStart > intervals[index][0] {
            result.append(intervals[index])
            index += 1
        }
        
        var interval: [Int]
        if result.isEmpty {
            result.append(newInterval)
        }
        else if let last = result.last, last[1] < newIntervalStart {
            result.append(newInterval)
        }
        else {
            interval = result.removeLast()
            interval[1] = max(newIntervalEnd, interval[1])
            result.append(interval)
        }
        
        while index < length {
            interval = intervals[index]
            let start = interval[0]
            let end = interval[1]
            if let last = result.last, last[1] < start {
                result.append(interval)
            }
            else {
                interval = result.removeLast()
                interval[1] = max(end, interval[1])
                result.append(interval)
            }
            index += 1
        }
        
        return result
    }
    
    static func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.isEmpty {
            return []
        }
        
        var result = [Int]()
        let m = matrix.count
        let n = matrix[0].count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        let dir = [(0,1), (1,0), (0,-1), (-1,0)]
        var x = 0
        var y = 0
        var dirPos = 0
        var currDir: (Int, Int)
        for _ in 0..<m*n {
            result.append(matrix[x][y])
            currDir = dir[dirPos]
            visited[x][y] = true
            let row = x + currDir.0
            let col = y + currDir.1
            if row >= 0 && row < m && col >= 0 && col < n && !visited[row][col] {
                x = row
                y = col
            }
            else {
                dirPos = (dirPos + 1) % 4
                currDir = dir[dirPos]
                x += currDir.0
                y += currDir.1
            }
        }
        return result
    }
    
    static func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        if obstacleGrid.isEmpty {
            return 0
        }
        
        if obstacleGrid[0][0] == 1 {
            return 0
        }
        
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        
        var list = obstacleGrid
        list[0][0] = 1
        
        for j in 1..<n {
            list[0][j] = list[0][j] == 0 && list[0][j - 1] == 1 ? 1 : 0
        }
        
        for i in 1..<m {
            list[i][0] = list[i][0] == 0 && list[i - 1][0] == 1 ? 1 : 0
        }
        
        for i in 1..<m {
            for j in 1..<n {
                if list[i][j] == 0 {
                    list[i][j] = list[i - 1][j] + list[i][j - 1]
                }
                else {
                    list[i][j] = 0
                }
            }
        }
        return list[m - 1][n - 1]
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        var last = nums.count - 1
        var counter = last
        while counter >= 0 {
            if counter + nums[counter] >= last {
                last = counter
            }
            counter -= 1
        }
        return last == 0
    }
    
    static func findItineraryHelperDFS(_ origin: String, _ ticketsMap: inout [String: [String]], _ result: inout [String]) {
        if var val = ticketsMap[origin] {
            for _ in val {
                let dst = val.removeFirst()
                ticketsMap[origin] = val
                findItineraryHelperDFS(dst, &ticketsMap, &result)
            }
        }
        if result.isEmpty {
            result.append(origin)
        }
        else {
            result.insert(origin, at: 0)
        }
    }
    
    static func findItineraryV2(_ tickets: [[String]]) -> [String] {
        if tickets.isEmpty {
            return []
        }
        
        var map = [String: [String]]()
        for item in tickets {
            let source = item[0]
            let dst = item[1]
            if var val = map[source] {
                val.append(dst)
                map[source] = val
            }
            else {
                map[source] = [dst]
            }
        }
        
        map.forEach { (key, val) in
            map[key] = val.sorted()
        }
        var result = [String]()
        findItineraryHelperDFS("JFK", &map, &result)
        return result
    }
    
    static func basicCalculater2(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var lastVal = 0
        var currVal = 0
        var result = 0
        var operatorVal = "+"
        let length = s.count
        
        for i in 0..<length {
            let item = s[i]
            if item.isNumber, let x = Int(String(item)) {
                currVal = currVal * 10 + x
            }
            if !item.isDigit && !item.isWhitespace || i == length - 1 {
                if operatorVal == "+" || operatorVal == "-" {
                    result += lastVal
                    lastVal = operatorVal == "+" ? currVal : -currVal
                }
                else if operatorVal == "*" {
                    lastVal = currVal * lastVal
                }
                else if operatorVal == "/" {
                    lastVal = lastVal / currVal
                }
                operatorVal = String(item)
                currVal = 0
            }
        }
        result += lastVal
        return result
    }
    
    static func maximalSquare(_ matrix: [[Character]]) -> Int {
        if matrix.isEmpty {
            return 0
        }
        
        let m = matrix.count
        let n = matrix[0].count
        var dpMat = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        var length = 0
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i - 1][j - 1] == "1" {
                    let x = dpMat[i - 1][j - 1]
                    let y = dpMat[i][j - 1]
                    let z = dpMat[i - 1][j]
                    dpMat[i][j] = min(x, y, z) + 1
                    length = max(length, dpMat[i][j])
                }
            }
        }
        
        return length * length
    }
    
    func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        var totalArea = abs(C - A) * abs(D - B) + abs(G - E) * abs(H - F)
        
        if max(A, E) < min(C, G) && max(B, F) < min(D, H) {
            totalArea -= abs((min(C, G) - max(A, E)) * (min(D, H) - max(B, F)))
        }
        
        return totalArea
    }
    
    func reorderList(_ head: SortedNode?) {
        if head == nil {
            return
        }
        
        var slow: SortedNode? = head
        var fast: SortedNode? = head
        
        while slow != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        var prev: SortedNode?
        var temp: SortedNode?
        var curr = slow
        
        while curr != nil {
            temp = curr?.next
            curr?.next = prev
            prev = curr
            curr = temp
        }
        
        var first = head
        var second = prev
        while second?.next != nil {
            temp = first?.next
            first?.next = second
            first = temp
            
            temp = second?.next
            second?.next = first
            second = temp
        }
    }
    
    func reverseBetween(_ head: SortedNode?, _ m: Int, _ n: Int) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        var headVal = head
        var p1 = head
        var curr = head
        var mVal = m
        var nVal = n
        while m > 1 {
            p1 = curr
            curr = curr?.next
            mVal -= 1
            nVal -= 1
        }
        
        var temp: SortedNode?
        var prev: SortedNode?
        let trail = curr
        
        while nVal > 0 {
            temp = curr?.next
            curr?.next = prev
            prev = curr
            curr = temp
            nVal -= 1
        }
        
        if p1 != nil {
            p1?.next = prev
        }
        else {
            headVal = prev
        }
        
        trail?.next = curr
        
        return headVal
    }
    
    static func merge(_ intervals: [[Int]]) -> [[Int]] {
        if intervals.isEmpty {
            return []
        }
        
        var list = intervals.sorted { (first, second) -> Bool in
            return first[0] < second[0]
        }
        
        var i = 0
        while i < list.count - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if (curr[1] > next[0]) || (next[0] <= curr[0] && next[1] >= curr[1]) {
                list[i] = [min(curr[0], next[0]), max(curr[1], next[1])]
                list.remove(at: i + 1)
            }
            else {
                i += 1
            }
        }
        return list
    }
    
    func increasingTriplet(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        return lis.contains(3)
    }
    
    func longestincreasingSubSequenceToOne(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] == nums[j] + 1 && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        return lis.max()!
    }
    
    func longestincreasingSubSequence(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        return lis.max()!
    }
    
    func increasingTripletV2(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        var first = Int.max
        var second = Int.max
        
        for item in nums {
            if item <= first {
                first = item
            }
            else if item <= second {
                second = item
            }
            else {
                return true
            }
        }
        return false
    }
    
    func connectHelper(_ root: NextConnectedNode?, _ map: inout [Int: NextConnectedNode?], _ level: Int) {
        if root == nil {
            return
        }
        
        if let val = map[level] {
            val?.next = root
            map[level] = root
        }
        else {
            map[level] = root
        }
        
        connectHelper(root?.left, &map, level + 1)
        connectHelper(root?.right, &map, level + 1)
    }
    
    func connect(_ root: NextConnectedNode?) -> NextConnectedNode? {
        if root == nil {
            return nil
        }
        var levelMap = [Int: NextConnectedNode?]()
        connectHelper(root, &levelMap, 0)
        return root
    }
    
    func widthOfBinaryTreeHelper(_ root: TreeNode?, _ map: inout [Int: Int], _ level: Int) {
        if root == nil {
            return
        }
        
        if var val = map[level] {
            val += 1
            map[level] = val
        }
        else {
            map[level] = 1
        }
        
        if root?.left == nil || root?.right == nil {
            if var val = map[level + 1] {
                val += 1
                map[level + 1] = val
            }
            else {
                map[level + 1] = 1
            }
        }
        
        widthOfBinaryTreeHelper(root?.left, &map, level + 1)
        widthOfBinaryTreeHelper(root?.right, &map, level + 1)
    }
    
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var levelMap = [Int: Int]()
        widthOfBinaryTreeHelper(root, &levelMap, 0)
        var mavVal = Int.min
        for item in levelMap {
            let x = item.value
            if mavVal < x {
                mavVal = x
            }
        }
        return mavVal
    }
    
    static func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        if s.isEmpty || wordDict.isEmpty {
            return false
        }
        
        let length = s.count
        let queue = Queue<Int>()
        var visited = Array(repeating: 0, count: length)
        queue.enqueue(val: 0)
        
        while !queue.isEmpty {
            let start = queue.dQueue()
            if visited[start] == 0 {
                for end in start..<length {
                    let x = s.index(s.startIndex, offsetBy: start)
                    let y = s.index(s.startIndex, offsetBy: end)
                    let subStr = String(s[x...y])
                    if wordDict.contains(subStr) {
                        queue.enqueue(val: end + 1)
                        if end == length - 1 {
                            return true
                        }
                    }
                }
                visited[start] = 1
            }
        }
        
        return false
    }
    
    static func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        if arr.isEmpty {
            return []
        }
        
        let length = arr.count

        if x <= arr[0] {
            return Array(arr[0..<k])
        }
        else if x >= arr[length - 1] {
            return Array(arr[length - k..<length])
        }
        else {
            var index = binarySearchGivePosition(list: arr, start: 0, end: length - 1, element: x)
            if index < 0 {
                index = -index - 1
            }
            
            var low = max(0, index - k - 1)
            var high = min(length - 1, index + k - 1)
            
            while high - low > k - 1 {
                if low < 0 || (x - arr[low]) <= (arr[high] - x) {
                    high -= 1
                }
                else if high > length - 1 || (x - arr[low]) > (arr[high] - x) {
                    low += 1
                }
            }
            
            return Array(arr[low...high])
        }
    }
    
    func findMin(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        var curr = root
        while curr?.left != nil {
            curr = curr?.left
        }
        return curr
    }
    
    func inorderSuccessor(_ root: TreeNode?, _ p: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if p?.right != nil {
            return findMin(p?.right)
        }
        
        var succ: TreeNode?
        var rootNode = root
        while rootNode != nil {
            if let pVal = p?.value, let rootVal = rootNode?.value {
                if pVal < rootVal {
                    succ = rootNode
                    rootNode = rootNode?.left
                }
                else if pVal > rootVal {
                    rootNode = rootNode?.right
                }
                else {
                    break
                }
            }
        }
        
        return succ
    }
    
    static func longestSubstring(_ s: String, _ k: Int) -> Int {
        if s.isEmpty {
            return 0
        }
        
        let length = s.count
        if length < k {
            return 0
        }
        
        var map = [Character: Int]()
        for item in s {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        
        var index = 0
        while index < length {
            let item = s[index]
            if let x = map[item], x >= k {
                
            }
            else {
                var j = index + 1
                while j < length, let y = map[s[j]], y < k {
                    j += 1
                }
                
                let first = s[0, index - 1]
                let second = s[j, length - 1]
                return max(longestSubstring(first, k), longestSubstring(second, k))
            }
            index += 1
        }
        return length
    }
    
    static func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        var max = Int.min
        for item in lis {
            if max < item {
                max = item
            }
        }
        return max
    }
    
    static func findMaxLength(_ nums: [Int]) -> Int {
        let length = nums.count
        if length <= 1 {
            return 0
        }
        
        var maxLen = Int.min
        var map = [Int: Int]()
        map[0] = -1
        var count = 0
        for i in 0..<length {
            count = count + (nums[i] == 1 ? 1 : -1)
            if let x = map[count] {
                maxLen = max(maxLen, i - x)
            }
            else {
                map[count] = i
            }
        }
        return max(0, maxLen)
    }
    
    static func numFriendRequests(_ ages: [Int]) -> Int {
        let length = ages.count
        if length <= 1 {
            return 0
        }
        
        var countList = Array(repeating: 0, count: 121)
        for age in ages {
            var val = countList[age]
            val += 1
            countList[age] = val
        }
        
        var result = 0
        for ageA in 0...120 {
            let countA = countList[ageA]
            for ageB in 0...120 {
                let countB = countList[ageB]
                if (ageB <= ageA/2 + 7) || ageB > ageA || ageB > 100 && ageA < 100 {}
                else {
                    result += countA * countB
                    if ageA == ageB {
                        result -= countA
                    }
                }
            }
        }
        return result
    }
    
    static func findPeakElement(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let length = nums.count
        
        if length == 1 {
            return 0
        }
        else if length == 2 {
            return nums[0] > nums [1] ? 0 : 1
        }
        
        for index in 1..<length - 1 {
            if nums[index] > nums[index - 1] && nums[index] > nums[index + 1] {
                return index
            }
        }
        return nums[0] > nums[length - 1] ? 0 : length - 1
    }
    
    static func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        if intervals.isEmpty || intervals.count == 1 {
            return 0
        }
        
        var list = intervals.sorted { $0[0] < $1[0] }
        var index = 1
        var counter = 0
        while index < list.count {
            if list[index][1] < list[index - 1][1] {
                counter += 1
                list.remove(at: index - 1)
            }
            else if list[index][0] < list[index - 1][1] {
                counter += 1
                list.remove(at: index)
            }
            else {
                index += 1
            }
        }
        return counter
    }
    
    static func setZeroes(_ matrix: inout [[Int]]) {
        if matrix.isEmpty {
            return
        }
        
        let m = matrix.count
        let n = matrix[0].count
        var isCol = false
        for i in 0..<m {
            if matrix[i][0] == 0 {
                isCol = true
            }
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        
        if matrix[0][0] == 0 {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        if isCol {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
    
    // sum[i] - sum[j] = k i.e. sum[i] - k = sum[j] i.e. sum till ith index and sum till jth index
    static func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var sum = 0
        var map = [Int: Int]()
        map[0] = 1
        var count = 0
        
        for item in nums {
            sum += item
            if let x = map[sum - k] {
                count += x
            }
            if let y = map[sum] {
                map[sum] = y + 1
            }
            else {
                map[sum] = 1
            }
        }
        
        return count
    }
    
    func distanceFromTarget(_ root: TreeNode?, _ k: Int) -> (Int, TreeNode?) {
        if root == nil {
            return (-1, nil)
        }
        
        if let rootVal = root, rootVal.value == k {
            return (0, root)
        }
        let left = distanceFromTarget(root?.left, k)
        let right = distanceFromTarget(root?.right, k)
        if left.0 != -1 {
            return (left.0 + 1, left.1)
        }
        else if right.0 != -1 {
            return (right.0 + 1, right.1)
        }
        return (-1, nil)
    }
    
    func findClosestLeaf(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil {
            return 0
        }
        
        let distToTarget = distanceFromTarget(root, k)
        if distToTarget.0 != -1 {
            
        }
        
        
        return 0
    }
    
    static func binarySearch(_ matrix: [[Int]], _ row: Int, _ left: Int, _ right: Int, _ target: Int) -> Bool {
        if left > right {
            return false
        }
        
        let mid = (left + right) / 2
        if matrix[row][mid] == target {
            return true
        }
        else if matrix[row][mid] < target {
            return binarySearch(matrix, row, mid + 1, right, target)
        }
        return binarySearch(matrix, row, left, mid - 1, target)
    }
    
    static func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
        
        let m = matrix.count
        guard let first = matrix.first else { return false }
        
        let n = first.count
        
        if matrix.isEmpty || n == 0 {
            return false
        }
        
        if target < matrix[0][0] || target > matrix[m - 1][n - 1] {
            return false
        }
        
        for i in 0..<m {
            if target >= matrix[i][0] && target <= matrix[i][n - 1] {
                return binarySearch(matrix, i, i, n - 1, target)
            }
        }
        return false
    }
    
    func copyRandomList(_ head: RandomNode?) -> RandomNode? {
        guard let root = head else {
            return nil
        }
        
        var map = [RandomNode?: RandomNode?]()
        
        var curr = head
        while curr != nil {
            if let currVal = curr {
                map[currVal] = RandomNode(currVal.val)
            }
            curr = curr?.next
        }
        
        curr = head
        while curr != nil {
            if let clone = map[curr], let cloneNext = map[curr?.next], let cloneRandom = map[curr?.random] {
                clone?.next = cloneNext
                clone?.random = cloneRandom
            }
            curr = curr?.next
        }
        
        return map[root] ?? nil
    }
    
    func fixLeftPointer(_ root: TreeNode?, _ prev: inout TreeNode?) {
        if let _ = root {
            fixLeftPointer(root?.left, &prev)
            root?.left = prev
            prev = root
            fixLeftPointer(root?.right, &prev)
        }
    }
    
    func fixRightPointer(_ root: inout TreeNode?) -> TreeNode? {
        while root != nil && root?.right != nil {
            root = root?.right
        }
        
        var temp: TreeNode?
        while root != nil && root?.left != nil {
            temp = root
            root = root?.left
            root?.right = temp
        }
        return root
    }
    
    func binaryTreeToDLL(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        var rootVal = root
        var prev: TreeNode?
        fixLeftPointer(rootVal, &prev)
        let head = fixRightPointer(&rootVal)
        return head
    }
    
    func lengthOfList(_ head: DLLNode?) -> Int {
        var counter = 0
        var headVal = head
        while headVal != nil {
            headVal = headVal?.next
            counter += 1
        }
        return counter
    }
    
    func dLLToBinaryTreeHelper(_ head: inout DLLNode?, _ n: Int) -> DLLNode? {
        if n <= 0 {
            return nil
        }
        
        let left = dLLToBinaryTreeHelper(&head, n/2)
        let rootVal = head
        rootVal?.prev = left
        head = head?.next
        rootVal?.next = dLLToBinaryTreeHelper(&head, n - n / 2 - 1)
        return rootVal
    }
    
    func dLLToBinaryTree(_ root: DLLNode?) -> DLLNode? {
        if root == nil {
            return nil
        }
        let length = lengthOfList(root)
        var rootVal = root
        let result = dLLToBinaryTreeHelper(&rootVal, length)
        return result
    }
    
    func rotateMatrix90(_ matrix: inout [[Int]]) {
        if matrix.isEmpty {
            return
        }
        
        let n = matrix.count
        
        for x in 0..<n/2 {
            for y in x..<n-x-1 {
                let temp = matrix[x][y]
                matrix[x][y] = matrix[y][n-1-x]
                matrix[y][n-1-x] = matrix[n-1-x][n-1-y]
                matrix[n-1-x][n-1-y] = matrix[n-1-y][x]
                matrix[n-1-y][x] = temp
            }
        }
    }
    
    func reverseList(_ list: inout [Int]) {
        var l = 0
        var r = list.count - 1
        while l < r {
            let temp = list[r]
            list[r] = list[l]
            list[l] = temp
            l += 1
            r -= 1
        }
    }
    
    func rotateMatrix90V2(_ matrix: inout [[Int]]) {
        if matrix.isEmpty {
            return
        }
        
        let m = matrix.count
        let n = matrix[0].count

        // Transpose
        for i in 0..<m {
            for j in i..<n {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = temp
            }
        }
        
        // Reverse Rows
        for i in 0..<m {
            var list = matrix[i]
            reverseList(&list)
        }
    }
    
    static func addBoldTag(_ s: String, _ dict: [String]) -> String {
        if s.isEmpty {
            return ""
        }
        else if dict.isEmpty {
            return s
        }
        
        let strt = s.startIndex
        let n = s.count
        var list = [(x: Int, y: Int)]()
        
        for i in 0..<n {
            var l = 0
            for item in dict {
                let status = s.startWith(item, i)
                if status {
                    l = max(l, item.count)
                }
            }
            if l > 0 {
                list.append((i, i + l - 1))
            }
        }
        
        if list.isEmpty {
            return s
        }
        
        var listVal = list.sorted { (first, second) -> Bool in
            return first.x < second.x
        }
        
        var i = 0
        while i < listVal.count - 1 {
            let curr = listVal[i]
            let next = listVal[i + 1]
            if (curr.y >= next.x) || (next.x <= curr.x && next.y >= curr.y) || next.x == curr.y + 1 {
                listVal[i] = (min(curr.x, next.x), max(curr.y, next.y))
                listVal.remove(at: i + 1)
            }
            else {
                i += 1
            }
        }
        
        var last = 0
        var result = ""
        for item in listVal {
            let start = item.x
            let end = item.y
            if last == start {
                result += ""
            }
            else {
                result += String(s[s.index(strt, offsetBy: last + 1)...s.index(strt, offsetBy: start - 1)])
            }
            
            result += "<b>" + String(s[s.index(strt, offsetBy: start)...s.index(strt, offsetBy: end)]) + "</b>"
            last = end
        }
        
        result += last == s.count - 1 ? "" : String(s.suffix(from: s.index(strt, offsetBy: last + 1)))
        
        return result
    }
    
    static func canPartition(_ nums: [Int]) -> Bool {
        if nums.isEmpty || nums.count == 1 {
            return false
        }
        
        
        // If we have to divide the array in two sets then it has to have sum even and we just need to find sum/2 in the list

        let length = nums.count
        let sum = nums.reduce(0, +)
        if sum % 2 != 0 {
            return false
        }
        
        let subSetSum = sum / 2
        var dpMap = Array(repeating: Array(repeating: false, count: subSetSum + 1), count: length + 1)
        
        dpMap[0][0] = true
        
        for i in 1...length {
            let curr = nums[i - 1]
            for j in 0...subSetSum {
                if j < curr {
                    dpMap[i][j] = dpMap[i - 1][j]
                }
                else {
                    dpMap[i][j] = dpMap[i - 1][j] || dpMap[i - 1][j - curr]
                }
            }
        }
        
        return dpMap[length][subSetSum]
    }
    
    static func checkMapForPermutation(_ s1Map: [Int], _ s2Map: [Int]) -> Bool {
        for i in 0..<26 {
            if s1Map[i] != s2Map[i] {
                return false
            }
        }
        return true
    }
    
    static func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        if s2.isEmpty {
            return false
        }
        else if s1.isEmpty {
            return true
        }
        
        let s1Val = Array(s1)
        let s2Val = Array(s2)
        let s1Len = s1Val.count
        let s2Len = s2Val.count
        if s1Len > s2Len {
            return false
        }
        var s1Map = Array(repeating: 0, count: 26)
        var s2Map = Array(repeating: 0, count: 26)
        let aCharacter: Character = "a"
        let firstAscii = aCharacter.asciiValue
        for i in 0..<s1Len {
            if let x = s1Val[i].asciiValue, let y = firstAscii {
                let val = Int(x - y)
                s1Map[val] += 1
            }
            
            if let x = s2Val[i].asciiValue, let y = firstAscii {
                let val = Int(x - y)
                s2Map[val] += 1
            }
        }
        
        for i in 0..<s2Len - s1Len {
            if checkMapForPermutation(s1Map, s2Map) {
                return true
            }
            if let x = s2Val[i + s1Len].asciiValue, let y = firstAscii {
                let val = Int(x - y)
                s2Map[val] += 1
            }
            if let x = s2Val[i].asciiValue, let y = firstAscii {
                let val = Int(x - y)
                s2Map[val] -= 1
            }
        }
        
        return checkMapForPermutation(s1Map, s2Map)
    }
    
    static func reverseWord(_ s: inout [Character], _ start: Int, _ end: Int) {
        let length = s.count
        if start >= 0 && start < end && end < length {
            var l = start
            var r = end
            while l < r {
                s.swapAt(l, r)
                l += 1
                r -= 1
            }
        }
    }
    
    static func reverseWordsFromCharArray(_ s: inout [Character]) {
        if s.isEmpty {
            return
        }
        
        var start = 0
        let length = s.count
        for i in 0..<length {
            let item = s[i]
            if item == " " {
                reverseWord(&s, start, i - 1)
                start = i + 1
            }
        }
        
        if start < length {
            reverseWord(&s, start, length - 1)
        }
        
        reverseWord(&s, 0, length - 1)
    }
    
    func getSwappingIndex(_ s: String, _ item: (i: Int, val: String), _ start: Int, _ len: Int) -> Int {
        if start >= len {
            return -1
        }
        let firstItem = String(s[start])
        if firstItem == item.val {
            return getSwappingIndex(s, item, start + 1, len)
        }
        else {
            return start
        }
    }
    
    func maximumSwap(_ num: Int) -> Int {
        let x = num.toString()
        let len = x.count
        
        var positionList = Array(repeating: 0, count: 10)
        let zero: Character = "0"
        let zeroAscii = zero.asciiValue
        for i in 0..<len {
            if let x = x[i].asciiValue, let y = zeroAscii {
                positionList[Int(x - y)] = i
            }
        }
        
        var list = x.map { String($0) }
        
        for i in 0..<len {
            var digit = 9
            while let x = x[i].asciiValue, let y = zeroAscii, digit > Int(x - y) {
                if positionList[digit] > i {
                    list.swapAt(positionList[digit], i)
                    return list.reduce(0) { (prev, curr) -> Int in
                        return prev*10 + (Int(curr) ?? 0)
                    }
                }
                digit -= 1
            }
        }
        
        return num
    }
    
    func checkCycle(_ graph: [Int: [Int]], visited: inout [Bool], recStack: inout [Bool], _ root: Int) -> Bool {
        if !visited[root] {
            visited[root] = true
            recStack[root] = true
            
            if let list = graph[root] {
                for item in list {
                    if !visited[item] && checkCycle(graph, visited: &visited, recStack: &recStack, item) {
                        return true
                    }
                    else if recStack[item] {
                        return true
                    }
                }
            }
            recStack[root] = false
        }
        return false
    }
    
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        if numCourses == 0 || prerequisites.isEmpty {
            return false
        }
        
        var adjMap = [Int: [Int]]()
        var set = Set<Int>()
        
        for item in prerequisites {
            let source = item[1]
            let dest = item[0]
            set.insert(source)
            set.insert(dest)
            if var val = adjMap[source] {
                val.append(dest)
                adjMap[source] = val
            }
            else {
                adjMap[source] = [dest]
            }
        }
        
        if set.count != numCourses {
            return false
        }
        
        var visited = Array(repeating: false, count: numCourses)
        var recStack = Array(repeating: false, count: numCourses)

        for i in 0..<numCourses {
            if checkCycle(adjMap, visited: &visited, recStack: &recStack, i) {
                return false
            }
        }
        
        return true
    }
    
    static func findDiagonalOrder(_ nums: [[Int]]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        var result = [Int]()
        let m = nums.count
        var numsVal = nums
        
        let queue = Queue<(x: Int, y: Int)>()
        queue.enqueue(val: (0,0))
        
        while !queue.isEmpty {
            let item = queue.dQueue()
            let val = nums[item.x][item.y]
            result.append(val)
            let list = nums[item.x]
            let listCount = list.count
            if item.x + 1 < m && item.y < listCount {
                let nextList = nums[item.x + 1]
                if item.y < nextList.count && numsVal[item.x + 1][item.y] > 0 {
                    numsVal[item.x + 1][item.y] = -numsVal[item.x + 1][item.y]
                    queue.enqueue(val: (item.x + 1, item.y))
                }
            }
            if item.x < m && item.y + 1 < list.count && numsVal[item.x][item.y + 1] > 0 {
                numsVal[item.x][item.y + 1] = -numsVal[item.x][item.y + 1]
                queue.enqueue(val: (item.x, item.y + 1))
            }
            
        }
        return result
    }
    
    static func bulbSwitch(_ n: Int) -> Int {
        if n <= 0 {
            return 0
        }
        
        var result = 0
        var index = 1
        
        while index * index <= n {
            index += 1
            result += 1
        }
        
        return result
    }
    
    
    func sortList(_ head: SortedNode?) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        var result: SortedNode?
        var curr = head
        var temp: SortedNode?
        
        while curr != nil {
            if result == nil {
                result = curr
                curr = curr?.next
                result?.next = nil
            }
            else {
                if let currVal = curr?.val, let resultval = result?.val, currVal < resultval {
                    temp = curr
                    curr = curr?.next
                    temp?.next = result
                    result = temp
                }
                else {
                    var val = result
                    var prev: SortedNode?
                    while let currVal = val?.val, let targetVal = curr?.val, currVal < targetVal  {
                        prev = val
                        val = val?.next
                    }
                    if prev != nil {
                        temp = curr
                        curr = curr?.next
                        temp?.next = val
                        prev?.next = temp
                    }
                }
            }
        }
        
        return result
    }
    
    func findMiddleOfList(_ head: inout SortedNode?) -> SortedNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var slow = head
        
        while head != nil && head?.next != nil {
            slow = slow?.next
            head = head?.next?.next
        }
        
        let result = slow?.next
        slow?.next = nil
        return result
    }
    
    func mergeLists(_ list1: SortedNode?, _ list2: SortedNode?) -> SortedNode? {
        let dummy = SortedNode(-1)
        var curr1 = list1
        var curr2 = list2
        var temp: SortedNode? = dummy
        
        while curr1 != nil && curr2 != nil {
            if let val1 = curr1?.val, let val2 = curr2?.val, val1 < val2 {
                temp?.next = curr1
                curr1 = curr1?.next
                temp = temp?.next
            }
            else {
                temp?.next = curr2
                curr2 = curr2?.next
                temp = temp?.next
            }
        }
        
        temp?.next = curr1 != nil ? curr1 : curr2
        return dummy.next
    }
    
    func mergeSortList(_ head: SortedNode?) -> SortedNode? {
        var headVal = head
        if headVal == nil || headVal?.next == nil {
            return headVal
        }
        
        let mid = findMiddleOfList(&headVal)
        let left = sortList(headVal)
        let right = sortList(mid)
        return mergeLists(left, right)
    }
    
    static func searchForMinIndexHelper(_ nums: [Int], _ l: Int, _ r: Int, _ length: Int) -> Int {
        if l > r {
            return -1
        }
        
        let mid = (l + r) / 2
        if mid - 1 >= 0 && mid + 1 < length && nums[mid] < nums[mid - 1] && nums[mid] <= nums[mid + 1] {
            return mid
        }
        else if mid - 1 >= 0 && mid + 1 < length && nums[mid] >= nums[mid - 1] && nums[mid] > nums[mid + 1] {
            return mid + 1
        }
        
        let leftSorted = nums[l] <= nums[mid]
        let righSorted = nums[mid] <= nums[r]
        
        if righSorted {
            return searchForMinIndexHelper(nums, l, mid - 1, length)
        }
        else if leftSorted {
            return searchForMinIndexHelper(nums, mid + 1, r, length)
        }
        return -1
    }
    
    static func findMin(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let length = nums.count
        let index = searchForMinIndexHelper(nums, 0, length - 1, length)
        if index == -1 {
            return min(nums[0], nums[length - 1])
        }
        return nums[index]
    }
    
    func calculateSumHelper(_ nums: [Int], map: inout [[Int]], index: Int, sum: Int, target: Int) -> Int {
        if index == nums.count {
            if sum == target {
                return 1
            }
            else {
                return 0
            }
        }
        else {
            if map[index][sum + 1000] != Int.min {
                return map[index][sum + 1000]
            }
            else {
                let add = calculateSumHelper(nums, map: &map, index: index + 1, sum: sum + nums[index], target: target)
                let substract = calculateSumHelper(nums, map: &map, index: index + 1, sum: sum - nums[index], target: target)
                map[index][sum + 1000] = add + substract
                return map[index][sum + 1000]
            }
        }
    }
    
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
                
        let len = nums.count
        var dpMemo = Array(repeating: Array(repeating: Int.min, count: 2001), count: len)
        let counter = calculateSumHelper(nums, map: &dpMemo, index: 0, sum: 0, target: S)
        return counter
    }
    
    // Variation of coin channge (https://leetcode.com/problems/coin-change/solution/)
    static func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        var amountList = Array(repeating: 0, count: target + 1)
        amountList[0] = 1
        for i in 1...target {
            for item in nums {
                if i >= item {
                    amountList[i] += amountList[i - item]
                }
            }
        }
        return amountList[target]
    }
    
    static func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        
        if nums.isEmpty {
            return 0
        }
        
        let list = nums.sorted()
        let length = list.count
        var result = list[length - 1] + list[length - 2] + list[length - 3]
        
        for i in 0..<length - 2 {
            var l = i + 1
            var r = length - 1
            while l < r {
                let sum = list[i] + list[l] + list[r]
                result = abs(result - target) > abs(sum - target) ? sum : result
                if target > sum {
                    l += 1
                }
                else if sum > target {
                    r -= 1
                }
                else {
                    return sum
                }
            }
        }
        
        return result
    }
    
    // DP solution
    func maxSumLengthSubArrayToTarget(list : [Int], _ target: Int) -> Int {
        
        if list.isEmpty {
            return 0
        }
        
        let len = list.count
        var maxLen = 0
        
        var map = Array(repeating: Array(repeating: 0, count: len), count: len)
        for i in 0..<len {
            let item = list[i]
            if item == target {
                maxLen = 1
            }
            map[i][i] = item
        }
        
        if len == 1 {
            return maxLen
        }
        
        for i in 0..<len - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if curr + next == target {
                maxLen = 2
            }
            map[i][i + 1] = curr + next
        }
        
        if len == 2 {
            return maxLen
        }
        
        for l in 3...len {
            for i in 0..<len - l + 1 {
                let j = i + l - 1
                if map[i][j - 1] + list[j] == target {
                    maxLen = l
                }
                map[i][j] = map[i][j - 1] + list[j]
            }
        }
        
        return maxLen
    }
    
    func maxSubArrayLen(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var map = [Int: Int]()
        map[0] = -1
        var maxLen = 0
        var sum = 0
        
        for i in 0..<nums.count {
            sum += nums[i]
            if map.keys.contains(sum - k) {
                if let x = map[sum - k], i - x > maxLen {
                    maxLen = i - x
                }
            }
            if let _ = map[sum] {
                
            }
            else {
                map[sum] = i
            }
        }
        
        return maxLen
    }
    
    @discardableResult
    func longestConsecutiveHelper(_ root: TreeNode?, _ maxLength: inout Int) -> (incr: Int, dcr: Int) {
        if root == nil {
            return (0, 0)
        }
        var incr = 1
        var dcr = 1
        
        if root?.left != nil {
            let val = longestConsecutiveHelper(root?.left, &maxLength)
            if let x = root?.value, let leftVal = root?.left?.value {
                if  x ==  leftVal + 1 {
                    dcr = val.dcr + 1
                }
                else if x == leftVal - 1 {
                    incr = val.incr + 1
                }
            }
        }
        if root?.right != nil {
            let val = longestConsecutiveHelper(root?.right, &maxLength)
            if let x = root?.value, let rightVal = root?.right?.value {
                if  x ==  rightVal + 1 {
                    dcr =  max(dcr, val.dcr + 1)
                }
                else if x == rightVal - 1 {
                    incr =  max(incr, val.incr + 1)
                }
            }
        }
        maxLength = max(maxLength, incr + dcr - 1)
        return (incr, dcr)
    }
    
    func longestConsecutive(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var result = 0
        longestConsecutiveHelper(root, &result)
        return result
    }
    
    func isBipartite(_ graph: [[Int]]) -> Bool {
        if graph.isEmpty {
            return false
        }
        var color = Array(repeating: -1, count: graph.count)
        for i in 0..<graph.count {
            if color[i] == -1 {
                color[i] = 1
                let queue = Queue<Int>()
                queue.enqueue(val: i)
                while !queue.isEmpty {
                    let u = queue.dQueue()
                    let list = graph[u]
                    for v in list {
                        if v == u {
                            return false
                        }
                        else if color[v] == -1 {
                            color[v] = 1 - color[u]
                            queue.enqueue(val: v)
                        }
                        else if color[u] == color[v] {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    static func findStrobogrammatic(_ n: Int) -> [String] {
        if n <= 0 {
            return []
        }
        var result = [String]()
        var set = Set<String>()
        
        if n == 1 {
            set.insert("1")
            set.insert("8")
        }
        else if n >= 2 {
            set.insert("11")
            set.insert("88")
            set.insert("69")
            set.insert("96")
        }
        if n > 2 {
            for i in 3...n {
                var tempSet = Set<String>()
                if i % 2 == 0 {
                    for item in set {
                        tempSet.insert(insertAtMiddle(item, "00"))
                        tempSet.insert(insertAtMiddle(item, "11"))
                        tempSet.insert(insertAtMiddle(item, "88"))
                        tempSet.insert(insertAtMiddle(item, "69"))
                        tempSet.insert(insertAtMiddle(item, "96"))
                    }
                }
                else {
                    for item in set {
                        tempSet.insert(insertAtMiddle(item, "0"))
                        tempSet.insert(insertAtMiddle(item, "1"))
                        tempSet.insert(insertAtMiddle(item, "8"))
                    }
                }
                set = tempSet
            }
        }
        result.append(contentsOf: set)
        return result
    }
    
    static func insertAtMiddle(_ s: String, _ val: String) -> String {
        var x = s
        let length = s.count
        let mid = length / 2
        if length % 2 == 0 {
            let index = s.index(s.startIndex, offsetBy: mid)
            x.insert(contentsOf: val, at: index)
        }
        else {
            let index = s.index(s.startIndex, offsetBy: mid)
            x.replaceSubrange(index...index, with: val)
        }
        return x
    }
    
    func leftMostColumnWithOne(_ binaryMatrix: BinaryMatrix) -> Int {
        let dimension = binaryMatrix.dimensions()
        let m = dimension[0]
        let n = dimension[1]
        
        if m == 0 {
            return -1
        }
        
        var row = 0
        var col = n - 1
        
        while row < m && col >= 0 {
            let x = binaryMatrix.get(row, col)
            if x == 0 {
                row += 1
            }
            else {
                col -= 1
            }
        }
        
        return col == n - 1 ? -1 : col + 1
    }
    
    // Dutch flag problem
    static func sortColors(_ nums: inout [Int]) {
        if nums.count < 2 {
            return
        }
        
        var low = 0
        var mid = 0
        var high = nums.count - 1
        while mid <= high {
            switch nums[mid] {
            case 0:
                nums.swapAt(low, mid)
                low += 1
                mid += 1
            case 1:
                mid += 1
            default:
                nums.swapAt(mid, high)
                high -= 1
            }
        }
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return []
        }
        
        let diglen = digits.count
        var prev = [String]()
        var curr = [String]()
        let map: [Character: String] = ["2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"]
        if let val = map[digits[0]] {
            for item in val {
                prev.append(String(item))
            }
        }
        
        for i in 1..<diglen {
            if let val = map[digits[i]] {
                for item in val {
                    for inner in prev {
                        curr.append(inner + String(item))
                    }
                }
                prev = curr
                curr = []
            }
        }
        
        return prev
    }
    
    func addTwoNumbers(_ l1: SortedNode?, _ l2: SortedNode?) -> SortedNode? {
        if let _ = l1, let _ = l2 {
            let dummy: SortedNode? = SortedNode(-1)
            var temp = dummy
            var val1 = l1
            var val2 = l2
            var remainder = 0
            while val1 != nil && val2 != nil {
                if let item1 = val1?.val, let item2 = val2?.val {
                    let sum = item1 + item2 + remainder
                    temp?.next = SortedNode(sum % 10)
                    remainder = sum / 10
                }
                val1 = val1?.next
                val2 = val2?.next
                temp = temp?.next
            }
            
            if let _ = val1 {
                while val1 != nil {
                    if let item1 = val1?.val {
                        let sum = item1 + remainder
                        temp?.next = SortedNode(sum % 10)
                        remainder = sum / 10
                    }
                    val1 = val1?.next
                    temp = temp?.next
                }
            }
            
            if let _ = val2 {
                while val2 != nil {
                    if let item2 = val2?.val {
                        let sum = item2 + remainder
                        temp?.next = SortedNode(sum % 10)
                        remainder = sum / 10
                    }
                    val2 = val2?.next
                    temp = temp?.next
                }
            }
            if remainder != 0 {
                temp?.next = SortedNode(remainder)
                temp = temp?.next
            }
            return dummy?.next
        }
        else if let root1 = l1 {
            return root1
        }
        else if let root2 = l2 {
            return root2
        }
        return nil
    }
    
    func oddEvenList(_ head: SortedNode?) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        var odd = head
        var even = odd?.next
        let evenHead = even
        
        while even != nil && even?.next != nil {
            odd?.next = even?.next
            odd = odd?.next
            even?.next = odd?.next
            even = even?.next
        }
        odd?.next = evenHead
        return head
    }
    
    func getIntersectionNode(_ headA: SortedNode?, _ headB: SortedNode?) -> SortedNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        var set = Set<SortedNode>()
        var curr1 = headA
        var curr2 = headB
        
        while curr1 != nil && curr2 != nil {
            if let x = curr1, let y = curr2 {
                if set.contains(x) {
                    return x
                }
                if set.contains(y) {
                    return y
                }
                
                set.insert(x)
                set.insert(y)
            }
            curr1 = curr1?.next
            curr2 = curr2?.next
        }
        
        while curr1 != nil {
            if let x = curr1 {
                if set.contains(x) {
                    return x
                }
                set.insert(x)
            }
            curr1 = curr1?.next
        }
        
        while curr2 != nil {
            if let x = curr2 {
                if set.contains(x) {
                    return x
                }
                set.insert(x)
            }
            curr2 = curr2?.next
        }
        
        return nil
    }
    
    func inorderTraversalHelper(_ root: TreeNode?, _ result: inout [Int]) {
        if let r = root {
            inorderTraversalHelper(r.left, &result)
            result.append(r.value)
            inorderTraversalHelper(r.right, &result)
        }
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var result = [Int]()
        inorderTraversalHelper(root, &result)
        return result
    }
    
    func zigzagLevelOrderHelper(_ root: TreeNode?, _ level: Int, _ map: inout [Int: [Int]]) {
        if let r = root {
            if var val = map[level] {
                if level % 2 == 0 {
                    val.append(r.value)
                }
                else {
                    val.insert(r.value, at: 0)
                }
                map[level] = val
            }
            else {
                map[level] = [r.value]
            }
            zigzagLevelOrderHelper(root?.left, level + 1, &map)
            zigzagLevelOrderHelper(root?.right, level + 1, &map)
        }
    }
    
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        
        var map = [Int: [Int]]()
        zigzagLevelOrderHelper(root, 0, &map)
        if let maxLeval = map.keys.max() {
            var result = [[Int]]()
            for i in 0...maxLeval {
                if let val = map[i] {
                    result.append(val)
                }
            }
            return result
        }
        return []
    }
    
    static func findZigZagDiagonalOrderHelper(_ matrix: inout [[Int]], _ level: Int, _ map: inout [Int: [Int]], _ visited: inout [[Bool]], _ x: Int, _ y: Int) {
        let m = matrix.count
        let n = matrix[0].count
        if x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] {
            if var val = map[level] {
                if level % 2 == 0 {
                    val.append(matrix[x][y])
                }
                else {
                    val.insert(matrix[x][y], at: 0)
                }
                map[level] = val
            }
            else {
                map[level] = [matrix[x][y]]
            }
            visited[x][y] = true
            findZigZagDiagonalOrderHelper(&matrix, level + 1, &map, &visited, x + 1, y)
            findZigZagDiagonalOrderHelper(&matrix, level + 1, &map, &visited, x, y + 1)
        }
    }
    
    static func findZigZagDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.isEmpty {
            return []
        }
        var matVal = matrix
        var map = [Int: [Int]]()
        var visited = Array(repeating: Array(repeating: false, count: matrix[0].count), count: matrix.count)
        
        findZigZagDiagonalOrderHelper(&matVal, 0, &map, &visited, 0, 0)
        if let maxLeval = map.keys.max() {
            var result = [Int]()
            for i in 0...maxLeval {
                if let val = map[i] {
                    result.append(contentsOf: val)
                }
            }
            return result
        }
        return []
    }
    
    static func buildTreeHelper(_ preOrder: [Int], _ inLeft: Int, _ inRight: Int, _ preIndex: inout Int, _ map: [Int: Int]) -> TreeNode? {
        if inLeft >= inRight {
            return nil
        }
        
        let rootVal = preOrder[preIndex]
        let root = TreeNode(val: rootVal)
        if let inIndexVal = map[rootVal] {
            preIndex = preIndex + 1
            root.left = buildTreeHelper(preOrder, inLeft, inIndexVal, &preIndex, map)
            root.right = buildTreeHelper(preOrder, inIndexVal + 1, inRight, &preIndex, map)
        }
        return root
    }
    
    static func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        if preorder.isEmpty || inorder.isEmpty {
            return nil
        }
        
        var inorderMap = [Int: Int]()
        for i in 0..<inorder.count {
            inorderMap[inorder[i]] = i
        }
        
        var start = 0
        let result = buildTreeHelper(preorder, 0, inorder.count, &start, inorderMap)
        return result
    }
    
    static func buildTreeInPostHelper(_ postorder: [Int], _ inLeft: Int, _ inRight: Int, _ postIndex: inout Int, _ map: [Int: Int]) -> TreeNode? {
        if inLeft >= inRight || postIndex < 0 {
            return nil
        }
        
        let rootVal = postorder[postIndex]
        let root = TreeNode(val: rootVal)
        if let postIndexVal = map[rootVal] {
            postIndex = postIndex - 1
            root.right = buildTreeInPostHelper(postorder, postIndexVal + 1, inRight, &postIndex, map)
            root.left = buildTreeInPostHelper(postorder, inLeft, postIndexVal, &postIndex, map)
        }
        return root
    }
    
    static func buildTreeInPost(_ postorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        if postorder.isEmpty || inorder.isEmpty {
            return nil
        }
        
        var inorderMap = [Int: Int]()
        for i in 0..<inorder.count {
            inorderMap[inorder[i]] = i
        }
        
        var start = postorder.count - 1
        let result = buildTreeInPostHelper(postorder, 0, inorder.count, &start, inorderMap)
        return result
    }
    
    func kthSmallestBSTTreeNodeValueHelper(_ root: TreeNode?, _ k: Int, _ counter: inout Int, _ result: inout Int) {
        if let _ = root {
            kthSmallestBSTTreeNodeValueHelper(root?.left, k, &counter, &result)
            counter += 1
            if counter == k {
                result = root?.value ?? -1
                return
            }
            kthSmallestBSTTreeNodeValueHelper(root?.right, k, &counter, &result)
        }
    }
    
    func kthSmallestBSTTreeNodeValue(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil {
            return -1
        }
        var counter = 0
        var result = -1
        kthSmallestBSTTreeNodeValueHelper(root, k, &counter, &result)
        return result
    }
    
    func connectNextPointerInTreeHelper(_ root: NextNode?, _ level: Int, _ map: inout [Int: [NextNode]]) {
        if let r = root {
            if var val = map[level] {
                if let last = val.last {
                    last.next = r
                }
                val.append(r)
                map[level] = val
            }
            else {
                map[level] = [r]
            }
            connectNextPointerInTreeHelper(root?.left, level + 1, &map)
            connectNextPointerInTreeHelper(root?.right, level + 1, &map)
        }
    }
    
    func connectNextPointerInTree(_ root: NextNode?) -> NextNode? {
        if root == nil {
            return nil
        }
        var map = [Int: [NextNode]]()
        connectNextPointerInTreeHelper(root, 0, &map)
        return root
    }
    
    static func permuteHelper(_ nums: inout [Int], _ l: Int, _ r: Int, result: inout [[Int]]) {
        if l == r {
            result.append(nums)
            return
        }
        
        for i in l...r {
            nums.swapAt(i, l)
            permuteHelper(&nums,  l + 1, r, result: &result)
            nums.swapAt(i, l)
        }
    }
    
    static func permute(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return []
        }
        
        var val = nums
        var result = [[Int]]()
        permuteHelper(&val, 0, nums.count - 1, result: &result)
        return result
    }
    
    static func findAllPowerSubSets(list: [Int], numberOfSets: Int) -> [[Int]] {
        if list.isEmpty {
            return []
        }
        
        var result = [[Int]]()
        let len = list.count
        let size = Int(pow(Double(2), Double(len)))
        for i in 0..<size {
            var list = [Int]()
            for j in 0..<len {
                if i & (1 << j) != 0 {
                    list.append(list[j])
                }
            }
            if !result.contains(list) {
                result.append(list)
            }
        }
        return result
    }
    
    static func findAllPowerSubSetsBFS(_ nums: [Int]) -> [[Int]] {
        if nums.isEmpty {
            return []
        }
        
        let listVal = nums.sorted()
        var result = [[Int]]()
        result.append([])
        let len = listVal.count
        var prevNum = -1
        var prevSize = 0
        for i in 0..<len {
            let item = listVal[i]
            let start = prevNum == item ? prevSize : 0
            let size = result.count
            for j in start..<size {
                var copy = [Int]()
                copy.append(item)
                if !result[j].isEmpty {
                    copy.append(contentsOf: result[j])
                }
                result.append(copy)
            }
            prevNum = item
            prevSize = size
        }
        return result
    }
    
    static func findSubSetsWithDuplicates(list: [Int], subset: inout [Int], index: Int, result: inout [[Int]]) {
        if index == list.count {
            return
        }
        if !result.contains(subset) {
            result.append(subset)
        }
        for i in index..<list.count {
            if subset.contains(list[i]) {
                subset.append(list[i])
                findSubSetsWithDuplicates(list: list, subset: &subset, index: index + 1, result: &result)
                subset.removeLast()
            }
        }
    }
    
    static func findAllPowerSubSetsWithDuplicates(list: [Int], numberOfSets: Int) -> [[Int]] {
        if list.isEmpty {
            return []
        }
        
        var subset = [Int]()
        var result = [[Int]]()
        
        findSubSetsWithDuplicates(list: list, subset: &subset, index: 0, result: &result)

        return result
    }
    
    // Boogle Solver
    private static func findWord(mat : inout [[Character]], x : Int, y : Int, target: ArraySlice<Character>, _ m: Int, _ n: Int, _ index: Int) -> Bool {
        
        if index >= target.count {
            return true
        }
        
        if x < 0 || x >= m || y < 0 || y >= n || target[index] != mat[x][y] {
            return false
        }
        
        
        var result = false
        
        mat[x][y] = "#"
        
        let dir = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        for item in dir {
            let row = x + item.0
            let col = y + item.1
            result = findWord(mat: &mat, x: row, y: col, target: target, m, n, index + 1)
            if result {
                break
            }
        }
        mat[x][y] = target[index]
        return result
    }
    
    static func exist(_ board: [[Character]], _ word: String) -> Bool {
        if board.isEmpty || word.isEmpty {
            return false
        }
        
        var mat = board
        let str = Array(word)[0...]
        let innerList = board[0]
        let m = board.count
        let n = innerList.count
        
        for i in 0..<m {
            for j in 0..<n {
                let status = findWord(mat: &mat, x: i, y: j, target: str, m, n, 0)
                if status {
                    return status
                }
            }
        }
        return false
    }
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var map = Array(repeating: Array(repeating: 1, count: n), count: m)
        for i in 1..<m {
            for j in 1..<n {
                map[i][j] = map[i - 1][j] + map[i][j - 1]
            }
        }
        return map[m - 1][n - 1]
    }
    
    static func sortTransformedArray(_ nums: [Int], _ a: Int, _ b: Int, _ c: Int) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        let  len = nums.count
        var result = Array(repeating: 0, count: len)
        var l = 0
        var r = len - 1
        
        for i in 0..<len {
            var val = nums[l]
            let x = a*val*val + b*val + c
            val = nums[r]
            let y = a*val*val + b*val + c
            
            if a >= 0 {
                if x > y {
                    result[i] = x
                    l += 1
                }
                else {
                    result[i] = y
                    r -= 1
                }
            }
            else {
                if x > y {
                    result[i] = y
                    r -= 1
                }
                else {
                    result[i] = x
                    l += 1
                }
            }
        }
        
        return a < 0 ? result.reversed() : result
    }
    
    
    static func combinationSum2Helper(_ candidates: [Int], _ target: Int, _ index: Int, _ set: inout [Int], _ result: inout Array<Array<Int>>, _ s: inout Int) {
        
        if target < s {
            return
        }
        
        if s == target && !result.contains(set) {
            result.append(set)
            return
        }
        
        for i in 0..<candidates.count {
            let x = candidates[i]
            set.append(x)
            s += x
            combinationSum2Helper(candidates, target, index + 1, &set, &result, &s)
            set.removeLast()
            s -= x
        }
    }
    
    static func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        if candidates.isEmpty {
            return []
        }
        
        let vals = candidates.sorted()
        var result = Array<Array<Int>>()
        var temp = [Int]()
        var s = 0
        combinationSum2Helper(vals, target, 0, &temp, &result, &s)
        return result
    }
    
    func lengthOfList(_ head: SortedNode?) -> Int {
        if head == nil {
            return 0
        }
        
        var curr = head
        var count = 0
        while curr != nil {
            count += 1
            curr = curr?.next
        }
        
        return count
    }
    
    func sortedListToBSTHelper(_ head: inout SortedNode?, _ l: Int, _ r: Int) -> TreeNode? {
        if l > r {
            return nil
        }
        
        let mid = (l + r)/2
        let left = sortedListToBSTHelper(&head, l, mid - 1)
        
        if let val = head?.val {
            let treeNode = TreeNode(val: val)
            treeNode.left = left
            head = head?.next
            treeNode.right = sortedListToBSTHelper(&head, mid + 1, r)
            return treeNode
        }
        
        return nil
    }
    
    func sortedListToBST(_ head: SortedNode?) -> TreeNode? {
        if head == nil {
            return nil
        }
        
        var headVal = head
        let len = lengthOfList(head)
        let result = sortedListToBSTHelper(&headVal, 0, len - 1)
        return result
    }
    
    
    func leafNodeSumNumbersHelper(_ root: TreeNode?, _ s: String, _ result: inout Int) {
        guard let val = root?.value else { return }
        if root?.left == nil, root?.right == nil {
            let y = s + String(val)
            result += (Int(y) ?? 0)
            return
        }
        
        let x = s + "\(val)"
        leafNodeSumNumbersHelper(root?.left, x, &result)
        leafNodeSumNumbersHelper(root?.right, x, &result)
    }
    
    func leafNodeSumNumbers(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var result = 0
        leafNodeSumNumbersHelper(root, "", &result)
        return result
    }
    
    func reorganizeString(_ S: String) -> String {
        if S.isEmpty {
            return ""
        }
        let len = S.count
        var count = Array(repeating: 0, count: 26)
        let a: Character = "a"
        let aAscii = a.asciiValue
        for i in 0..<len {
            if let cVal = S[i].asciiValue, let aVal = aAscii {
                let index = Int(cVal - aVal)
                count[index] += 100
            }
        }
        
        for i in 0..<26 {
            count[i] += i
        }
        
        let sort = count.sorted()
        
        var result = Array<Character>(repeating: "a", count: len)
        var ct = 1
        for i in 0..<sort.count {
            let counter = sort[i] / 100
            let char = UInt8(sort[i] % 100)
            if counter > (len + 1)/2 {
                return ""
            }
            if let aVal = aAscii {
                for _ in 0..<counter {
                    if ct >= len {
                        ct = 0
                    }
                    let x = Character(UnicodeScalar(aVal + char))
                    result[ct] = x
                    ct += 2
                }
            }
        }
        
        let s = result.reduce("") { (prev, curr) -> String in
            return prev + String(curr)
        }
        return s
    }
    
    static func findMinArrowShots(_ points: [[Int]]) -> Int {
        if points.isEmpty {
            return 0
        }
        
        let sorted = points.sorted { (firsrt, second) -> Bool in
            firsrt[1] < second[1]
        }
        
        var result = 1
        var counter = 1
        var firstlast = sorted[0][1]
        
        while counter < sorted.count {
            let curr = sorted[counter]
            if firstlast < curr[0] {
                result += 1
                firstlast = curr[1]
            }
            counter += 1
        }
        return result
    }
    
    func complexNumberMultiply(_ a: String, _ b: String) -> String {
        let x = a.split(separator: "+")
        let x1 = x[1].split(separator: "i")
        let y = b.split(separator: "+")
        let y1 = y[1].split(separator: "i")
        let aReal = x[0]
        let aImg = x1[0]

        let bReal = y[0]
        let bImg = y1[0]
        if let a1 = Int(aReal), let a2 = Int(aImg), let b1 = Int(bReal), let b2 = Int(bImg) {
            return "\(a1*b1 - a2*b2)" + "+" + "\(a1*b2 + a2*b1)" + "i"
        }
        return ""
    }
    
    static func dfsMaxAreaOfIsland(_ grid: inout [[Int]], m: Int, n: Int, x: Int, y: Int, _ val: inout Int) {
        if x < 0 || y < 0 || x >= m || y >= n || grid[x][y] == 0 {
            return
        }
        
        grid[x][y] = 0
        val += 1
        let dir = [(-1, 0), (1, 0), (0, 1), (0, -1)]
        for item in dir {
            let xPos = x + item.0
            let yPos = y + item.1
            dfsMaxAreaOfIsland(&grid, m: m, n: n, x: xPos, y: yPos, &val)
        }
    }
    
    static func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        
        var myGrid = grid
        var result = 0
        let m = myGrid.count
        let n = myGrid[0].count
        var val = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if myGrid[i][j] == 1 {
                    val = 0
                    dfsMaxAreaOfIsland(&myGrid, m: m, n: n, x: i, y: j, &val)
                    result = max(result, val)
                }
            }
        }
        
        return result
    }
    
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        if points.isEmpty || K > points.count {
            return []
        }
        var dist = [Int]()
        for item in points {
            dist.append(distanceFromOrigin(item))
        }
        dist.sort()
        let k = dist[K - 1]
        var result = [[Int]]()
        for item in points {
            if distanceFromOrigin(item) <= k {
                result.append(item)
            }
        }
        return result
    }
    
    func distanceFromOrigin(_ point: [Int]) -> Int {
        return point[0]*point[0] + point[1]*point[1]
    }
    
    func missing(_ index: Int, _ nums: [Int]) -> Int {
        return nums[index] - nums[0] - index
    }
    
    func missingElement(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let n = nums.count
        if k > missing(n - 1, nums) {
            return nums[n - 1] + k - missing(n - 1, nums)
        }
        
        var i = 1
        while k > missing(i, nums) {
            i += 1
        }
        
        return nums[i - 1] + k - missing(i - 1, nums)
    }
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        var map = [Int: Int]()
        for item in nums {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        
        let list = map.sorted { (first, second) -> Bool in
            first.value > second.value
        }
        
        var result = [Int]()
        if k <= list.count {
            for i in 0..<k {
                result.append(list[i].key)
            }
        }
        
        return result
    }
    
    func splitArray(_ nums: [Int]) -> Bool {
        let len = nums.count

        if nums.isEmpty || len < 7 {
            return false
        }
        
        var preSum = Array(repeating: 0, count: len)
        preSum[0] = nums[0]
        for i in 1..<len {
            preSum[i] = preSum[i - 1] + nums[i]
        }
        
        for j in 3..<len - 3 {
            var set = Set<Int>()
            for i in 1..<j - 1 {
                if preSum[i - 1] == preSum[j - 1] - preSum[i] {
                    set.insert(preSum[i - 1])
                }
            }
            
            for k in j+2..<len - 1 {
                if preSum[len - 1] - preSum[k] == preSum[k - 1] - preSum[j] && set.contains(preSum[k - 1] - preSum[j]) {
                    return true
                }
            }
        }
        return false
    }
    
    func rightSideViewHelper(_ root: TreeNode?, _ level: Int, _ map: inout [Int: Int]) {
        if root == nil {
            return
        }
        
        if let rootX = root?.value {
            map[level] = rootX
        }
        rightSideViewHelper(root?.left, level + 1, &map)
        rightSideViewHelper(root?.right, level + 1, &map)
    }
    
    func rightSideView(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var map = [Int: Int]()
        rightSideViewHelper(root, 0, &map)
        let list = map.sorted { (first, second) -> Bool in
            first.key < second.key
        }.map { $0.value }
        return list
    }
    
    func kthSmallestInSortedMatrix(_ matrix: [[Int]], _ k: Int) -> Int {
        if matrix.isEmpty {
            return 0
        }
        
        let m = matrix.count
        let n = matrix[0].count
        
        var list = [MatrixNode]()
        for i in 0..<n {
            let node = MatrixNode(point: (0, i), val: matrix[0][i])
            list.append(node)
        }
        
        if k <= n {
            return list[k - 1].val
        }
        
        var counter = 0
        let queue = Heap(type: .minHeap, list: list)
        while !queue.isEmpty && counter >= 0 {
            if let item = queue.extract() {
                counter += 1
                if counter == k {
                    return item.val
                }
                let nextX = item.point.x + 1
                let nextY = item.point.y
                if nextX < m {
                    let node = MatrixNode(point: (nextX, nextY), val: matrix[nextX][nextY])
                    queue.insert(element: node)
                }
            }
        }
        
        return 0
    }
    
    static func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        if preorder.isEmpty {
            return nil
        }
        
        let inorder = preorder.sorted()
        var inorderMap = [Int: Int]()
        for i in 0..<inorder.count {
            inorderMap[inorder[i]] = i
        }
        
        var start = 0
        let result = buildTreeHelper(preorder, 0, inorder.count, &start, inorderMap)
        return result
    }
    
    static func bstFromPreorderV2Helper(_ preorder: [Int], _ min: Int, _ max: Int, _ preIndex: inout Int, _ count: Int) -> TreeNode? {
        if preIndex > count - 1 {
            return nil
        }
        
        let val = preorder[preIndex]
        if val < min || val > max {
            return nil
        }
        
        preIndex += 1
        let node = TreeNode(val: val)
        node.left = bstFromPreorderV2Helper(preorder, min, val, &preIndex, count)
        node.right = bstFromPreorderV2Helper(preorder, val, max, &preIndex, count)
        return node
    }
    
    static func bstFromPreorderV2(_ preorder: [Int]) -> TreeNode? {
        if preorder.isEmpty {
            return nil
        }
        
        var preIndex = 0
        let result = bstFromPreorderV2Helper(preorder, Int.min, Int.max, &preIndex, preorder.count)
        return result
    }
    
    func minAddToMakeValid(_ S: String) -> Int {
        if S.isEmpty {
            return 0
        }
        
        let len = S.count
        let stack = Stack<Character>()
        stack.push(val: S[0])
        var i = 1
        while !stack.isEmpty && i < len {
            let curr = S[i]
            var shouldAdd = true
            if let top = stack.top() {
                if curr == ")" && top == "(" {
                    stack.pop()
                    shouldAdd = false
                }
            }
            if shouldAdd {
                stack.push(val: curr)
            }
            i += 1
        }
        return stack.size
    }
    
    func minAddToMakeValidV2(_ S: String) -> Int {
        if S.isEmpty {
            return 0
        }
        
        var x = 0
        var y = 0
        
        for item in S {
            x += item == "(" ? 1 : -1
            // x can't be greater than -1
            if x == -1 {
                x += 1
                y += 1
            }
        }
        
        return x + y
    }
    
    func countBattleships(_ board: [[Character]]) -> Int {
        if board.isEmpty {
            return 0
        }
        
        let m = board.count
        let n = board[0].count
        var result = 0
        for i in 0..<m {
            var prev = false
            for j in 0..<n {
                let curr = board[i][j] == "X"
                let top = i > 0 && board[i - 1][j] == "X"
                if curr && !prev && !top {
                    result += 1
                }
                prev = curr
            }
        }
        return result
    }
    
    func maxAncestorDiffBinaryTreeHelper(_ root: TreeNode?, _ min: inout Int, _ max: inout Int, result: inout Int) {
        if root == nil {
            return
        }
        
        if let val = root?.value {
            let maxAbs = Int(abs(val - min)) > Int(abs(val - max)) ? Int(abs(val - min)) : Int(abs(val - max))
            result = result > maxAbs ? result : maxAbs
            min = min < val ? min : val
            max = max < val ? val : max
            maxAncestorDiffBinaryTreeHelper(root?.left, &min, &max, result: &result)
            maxAncestorDiffBinaryTreeHelper(root?.right, &min, &max, result: &result)
        }
    }
    
    func maxAncestorDiffBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var result = Int.min
        var min = root?.value ?? 0
        var max = root?.value ?? 0
        maxAncestorDiffBinaryTreeHelper(root, &min, &max, result: &result)
        return result
    }
    
    @discardableResult
    func flattenTreeToSingleListHelper(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if root?.left == nil && root?.right == nil {
            return root
        }
        
        let leftTail = flattenTreeToSingleListHelper(root?.left)
        let rightTail = flattenTreeToSingleListHelper(root?.right)
        
        if leftTail != nil {
            leftTail?.right = root?.right
            root?.right = root?.left
            root?.left = nil
        }
        
        return rightTail == nil ? leftTail : rightTail
    }
    
    func flattenTreeToSingleList(_ root: TreeNode?) {
        flattenTreeToSingleListHelper(root)
    }
    
    func rangeIntersection(_ range1: Range<Int>, _ range2: Range<Int>) -> Range<Int>? {
        if range1.upperBound < range2.lowerBound || range2.upperBound < range1.lowerBound {
            return nil
        }
        let minVal = min(range1.lowerBound, range2.lowerBound)
        let maxVal = max(range1.upperBound, range2.upperBound)
        return Range(minVal...maxVal)
    }
    
    static func fbEnumarator() {
        let x: [Any] = [1,[2,3],4,5,[1,[2,3,5,6,[10,11]]]]
        let iterator = FacebookIterator(x)
        let y = iterator.allObjects()
    }
    
    
    func addBinary(_ a: String, _ b: String) -> String {
        if a.isEmpty && b.isEmpty {
            return ""
        }
        else if a.isEmpty {
            return b
        }
        else if b.isEmpty {
            return a
        }
        
        var result = ""
        
        let len1 = a.count
        let len2 = b.count
        if len1 > len2  {
            return addBinary(b, a)
        }
        else {
            var counter = len1 - 1
            var carry = 0
            var j = len2 - 1
            while counter >= 0 {
                let item1 = String(a[counter])
                let item2 = String(b[j])
                if let x = Int(item1), let y = Int(item2) {
                    result = String((x + y + carry) % 2) + result
                    carry = (x + y + carry) / 2
                }
                counter -= 1
                j -= 1
            }
            if j >= 0 {
                while j >= 0 {
                    let item2 = String(b[j])
                    if let y = Int(item2) {
                        result = String((y + carry) % 2) + result
                        carry = (y + carry) / 2
                    }
                    j -= 1
                }
            }
            if carry > 0 {
                result = String((carry) % 2) + result
            }
        }
        
        return result
    }
    
    func isMonotonic(_ A: [Int]) -> Bool {
        if A.isEmpty {
            return false
        }
        var inc = true
        var dec = true
        for i in 0..<A.count - 1 {
            if A[i] > A[i + 1] {
                inc = false
            }
            else if A[i] < A[i + 1] {
                dec = false
            }
        }
        return dec || inc
    }
    
    func convertZigZagInString(_ s: String, _ numRows: Int) -> String {
        if s.isEmpty {
            return ""
        }
        else if numRows == 1 {
            return s
        }
        let len = s.count
        var goesDown = false
        let rows = min(len, numRows)
        var list = Array(repeating: "", count: rows)
        var rowVal = 0
        for item in s {
            var x = list[rowVal]
            x.append(item)
            list[rowVal] = x
            if rowVal == 0 || rowVal == numRows - 1 {
                goesDown = !goesDown
            }
            rowVal += goesDown ? 1 : -1
        }
        
        let result = list.reduce("") { (prev, curr) -> String in
            prev + curr
        }
        return result
    }
    
    func rob(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var prevMax = 0
        var currMax = 0
        for i in 0..<nums.count {
            let x = currMax
            currMax = max(prevMax + nums[i], currMax)
            prevMax = x
        }
        return currMax
    }
    
    func climbStairs(_ n: Int) -> Int {
        if n <= 1 {
            return 1
        }
        var list = Array(repeating: 0, count: n + 1)
        list[0] = 1
        list[1] = 2
        for i in 3...n {
            list[i] = list[i - 1] + list[i - 2]
        }
        return list[n]
    }
    
    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        if intervals.isEmpty {
            return false
        }
        
        let list = intervals.sorted { (first, second) -> Bool in
            first[0] < second[0]
        }
        
        for i in 0..<list.count - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if curr[1] > next[0] {
                return false
            }
        }
        return true
    }
    
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        if intervals.isEmpty && newInterval.isEmpty {
            return []
        }
        else if intervals.isEmpty {
            return [newInterval]
        }
        else if newInterval.isEmpty {
            return intervals
        }
        
        var list = intervals
        list.append(newInterval)
        list.sort { (first, second) -> Bool in
            first[0] < second[0]
        }
        
        var i = 0
        while i  < list.count - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if curr[1] >= next[0] || curr[0] >= next[0] && curr[1] <= next[0]  {
                let item = [min(curr[0], next[0]), max(curr[1], next[1])]
                list[i] = item
                list.remove(at: i + 1)
            }
            else {
                i += 1
            }
        }
        
        return list
    }
}

struct MatrixNode {
    let point: (x: Int, y: Int)
    let val: Int
}

extension MatrixNode: Comparable {
    static func < (lhs: MatrixNode, rhs: MatrixNode) -> Bool {
        return lhs.val < rhs.val
    }
    
    static func == (lhs: MatrixNode, rhs: MatrixNode) -> Bool {
        return lhs.val == rhs.val
    }
}

class TrieNodeV2 {
    var list = Array<TrieNodeV2?>(repeating: nil, count:26)
    var isEndOfWord = false
}

class TrieSet2 {
    
    /** Initialize your data structure here. */
    private let root = TrieNodeV2()
    init() {
    }
    
    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        var curr: TrieNodeV2? = root
        for item in word {
            if item.isAlphabet, let val = item.asciiValue {
                let index = Int(val) - 97
                if curr?.list[index] == nil {
                    curr?.list[index] = TrieNodeV2()
                }
                curr = curr?.list[index]
            }
        }
        curr?.isEndOfWord = true
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    private func searchHelper(_ word: String, _ node: TrieNodeV2?) -> Bool {
        var curr: TrieNodeV2? = node
        for i in 0..<word.count {
            let item = word[i]
            if item.isAlphabet, let val = item.asciiValue {
                let index = Int(val) - 97
                if curr?.list[index] == nil {
                    return false
                }
                curr = curr?.list[index]
            }
            else {
                if item == "." {
                    if let currList = curr?.list {
                        for item in currList {
                            if item != nil {
                                let node = item
                                let nextIndex = word.index(word.startIndex, offsetBy: i + 1)
                                let suffix = word.suffix(from: nextIndex)
                                if searchHelper(String(suffix), node) {
                                    return true
                                }
                            }
                        }
                    }
                }
            }
        }
        return curr != nil && curr?.isEndOfWord == true
    }
    
    func search(_ word: String) -> Bool {
        return searchHelper(word, root)
    }
}

class GrapthNode {
    let val: Int
    var neighbours = [GrapthNode]()
    init(_ val: Int) {
        self.val = val
    }
}

extension GrapthNode: Hashable {
    static func == (lhs: GrapthNode, rhs: GrapthNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}

class ValidWordAbbr {

    private var map = [String: Set<String>]()
    init(_ dictionary: [String]) {
        for item in dictionary {
            let x = getAbbr(item)
            if var val = map[x] {
                val.insert(item)
                map[x] = val
            }
            else {
                var set = Set<String>()
                set.insert(item)
                map[x] = set
            }
        }
    }
    
    func isUnique(_ word: String) -> Bool {
        if word.isEmpty {
            return false
        }
        
        let x = getAbbr(word)
        if let val = map[x] {
            return  val.count == 1 && val.contains(word)
        }
        return true
    }
    
    private func getAbbr(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let last = s.index(before: s.endIndex)
        return "\(s[s.startIndex])" + "\(s.count - 2)" + "\(s[last])"
    }
}


class LRUCache {
    private var map = [Int : Int]()
    private var dq : DQueue<Int>
    init(_ capacity: Int) {
        dq = DQueue(sizeVal: capacity)
    }
    
    func get(_ key: Int) -> Int {
        if let node = map[key] {
            return node
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let _ = map[key] {
        }
        else {
            if let removedVal = dq.insert(val: value) {
                map[removedVal] = nil
            }
            map[key] = value
        }
    }
}

class LargestBSTSolve {
    
    struct CheckBST {
        let count: Int
        let max: Int
        let min: Int
    }
    
    var counter = 0
    @discardableResult
    func largestBSTSubtreeHelper(_ root: TreeNode?) -> CheckBST {
        if root == nil {
            return CheckBST(count: 0, max: -1, min: -1)
        }
        let left = largestBSTSubtreeHelper(root?.left)
        let right = largestBSTSubtreeHelper(root?.right)
        if let rootVal = root, ((left.count == 0 || left.max < rootVal.value) && (right.count == 0 || right.min > rootVal.value)) {
            let count = left.count + right.count + 1
            let min = left.count == 0 ? rootVal.value : left.min
            let max = right.count == 0 ? rootVal.value : right.max
            counter = count > counter ? count : counter
            return CheckBST(count: count, max: max, min: min)
        }
        else {
            return CheckBST(count: 1, max: Int.max, min: Int.min)
        }
    }
    
    func largestBSTSubtree(_ root: TreeNode?) -> Int {
        largestBSTSubtreeHelper(root)
        return counter
    }
}

class NumMatrix {

    private let matval: [[Int]]
    let m: Int
    let n: Int
    init(_ matrix: [[Int]]) {
        matval = matrix
        m = matrix.count
        n = m > 0 ? matrix[0].count : 0
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        if row1 >= 0 && row1 < m && row2 >= 0 && row2 < m && col1 >= 0 && col1 < n && col2 >= 0 && col2 < n {
            for i in row1...row2 {
                for j in col1...col2 {
                    sum += matval[i][j]
                }
            }
        }
        return sum
    }
}

class NumMatrixV2 {

    private var matval: [[Int]]
    let m: Int
    let n: Int
    init(_ matrix: [[Int]]) {
        m = matrix.count
        n = m > 0 ? matrix[0].count : 0
        matval = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        for i in 0..<m {
            for j in 0..<n {
                matval[i + 1][j + 1] = matval[i + 1][j] + matval[j][j + 1] + matrix[i][j] - matval[i][j]
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        if row1 >= 0 && row1 < m && row2 >= 0 && row2 < m && col1 >= 0 && col1 < n && col2 >= 0 && col2 < n {
            sum = matval[row2 + 1][col2 + 1] - matval[row2 + 1][col1] - matval[row1][col2 + 1] + matval[row1][col1]
        }
        return sum
    }
}

class RandomPickWeightSolution {

    private var prefixSum: Array<Int>
    private var sum = 0
    init(_ w: [Int]) {
        let length = w.count
        prefixSum = Array(repeating: 0, count: length)
        for i in 0..<length {
            sum += w[i]
            prefixSum[i] = sum
        }
    }
    
    func pickIndex() -> Int {
        let randomSum = Int.random(in: 0...sum)
        var i = 0
        while i < prefixSum.count {
            if randomSum < prefixSum[i] {
                return i
            }
            i += 1
        }
        return i - 1
    }
}

class Vector2D {

    private var start = 0
    private var stateList = [Int]()
    init(_ v: [[Int]]) {
        for i in 0..<v.count {
            let list = v[i]
            for j in 0..<list.count {
                stateList.append(list[j])
            }
        }
    }
    
    func next() -> Int {
        if start < stateList.count {
            let item = stateList[start]
            start += 1
            return item
        }
        return -1
    }
    
    func hasNext() -> Bool {
        return start < stateList.count
    }
}


class MyCircularQueue {

    /** Initialize your data structure here. Set the size of the queue to be k. */
    private var list : Array<Int>
    private let capacity: Int
    init(_ k: Int) {
        capacity = k
        list = Array()
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        list.append(value)
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if list.isEmpty {
            return false
        }
        list.removeFirst()
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        if list.isEmpty {
            return -1
        }
        return list[0]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        return list.last ?? -1
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return list.isEmpty
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return capacity == list.count
    }
}

class BinaryMatrix {
    func get(_ row: Int, _ col: Int) -> Int {
        return 0
    }
    func dimensions() -> [Int] {
        return []
    }
}


class WordDistance {

    let words: [String]
    private var map = [String: [Int]]()
    init(_ words: [String]) {
        self.words = words
        for i in 0..<words.count {
            let item = words[i]
            if var val = map[item] {
                val.append(i)
                map[item] = val
            }
            else {
                map[item] = [i]
            }
        }
    }
    
    func shortest(_ word1: String, _ word2: String) -> Int {
        if words.isEmpty {
            return 0
        }
        
        if let x = map[word1], let y = map[word2] {
            var l1 = 0
            var l2 = 0
            var ans = Int.max
            
            while l1 < x.count && l2 < y.count {
                ans = min(ans, abs(x[l1] - y[l2]))
                if x[l1] < y[l2] {
                    l1 += 1
                }
                else if x[l1] > y[l2] {
                    l2 += 1
                }
            }
            return ans
        }
        return 0
    }
}


class Codec {
    
    func serializeHelper(_ root: TreeNode?, str: inout String) {
        if root == nil {
            str += "null,"
        }
        
        if let val = root?.value {
            str += "\(val),"
            serializeHelper(root?.left, str: &str)
            serializeHelper(root?.right, str: &str)
        }
    }
    
    func serialize(_ root: TreeNode?) -> String {
        var str = ""
        serializeHelper(root, str: &str)
        return str
    }
    
    func deserializeHeler(_ val: inout [String]) -> TreeNode? {
        if val[0] == "null" {
            val.remove(at: 0)
            return nil
        }
        let x = val.remove(at: 0)
        if let y = Int(x) {
            let root = TreeNode(val: y)
            root.left = deserializeHeler(&val)
            root.right = deserializeHeler(&val)
            return root
        }
        return nil
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        var val = data.components(separatedBy: ",")
        let result = deserializeHeler(&val)
        return result
    }
}

class CodecString {
    private let delimeter = "==||=="
    func encode(_ strs: [String]) -> String {
        if strs.isEmpty {
            return ""
        }
        if strs.count == 1 {
            return strs[0] + delimeter
        }
        
        var result = ""
        
        for i in 0..<strs.count - 1 {
            result += strs[i] + delimeter
        }
        result += strs.last ?? ""
        return result
    }
    
    func decode(_ s: String) -> [String] {
        if s.isEmpty {
            return []
        }
        return s.components(separatedBy: delimeter)
    }
}




class FacebookIterator {

    //@[@1, @[@2, @[@3, @4]], @[ ], @5],
    static func helper(_ list: [Any]) -> [Int] {
        if list.isEmpty {
            return []
        }
        var listVal = [Int]()
        for item in list {
            if let val = item as? Int {
                listVal.append(val)
            }
            else if let val = item as? [Any] {
                let x = helper(val)
                listVal.append(contentsOf: x)
            }
        }
        
        return listVal
    }
    
    private var list: [Int]
    init(_ nestedList: [Any]) {
        list = FacebookIterator.helper(nestedList)
    }
    
    func next() -> Int {
        let x = list.removeFirst()
        return x
    }
    
    func hasNext() -> Bool {
        return list.count > 0
    }
    
    func allObjects() -> [Int] {
        return list
    }
}



class NestedIterator {

    //@[@1, @[@2, @[@3, @4]], @[ ], @5],
    static func helper(_ list: [NestedInteger]) -> [Int] {
        if list.isEmpty {
            return []
        }
        var listVal = [Int]()
        for item in list {
            if item.isInteger() {
                listVal.append(item.getInteger())
            }
            else {
                let x = helper(item.getList())
                listVal.append(contentsOf: x)
            }
        }
        
        return listVal
    }
    
    private var list: [Int]
    init(_ nestedList: [NestedInteger]) {
        list = NestedIterator.helper(nestedList)
    }
    
    func next() -> Int {
        let x = list.removeFirst()
        return x
    }
    
    func hasNext() -> Bool {
        return list.count > 0
    }
}


class BSTIterator {

    private func inorder(_ root: TreeNode?) {
        if let r = root {
            inorder(r.left)
            list.append(r.value)
            inorder(r.right)
        }
    }
    
    private var list = [Int]()
    init(_ root: TreeNode?) {
        inorder(root)
    }
    
    func next() -> Int {
        return list.removeFirst()
    }
    
    func hasNext() -> Bool {
        return list.count > 0
    }
}

class RandomPickIndex {

    private let map: [Int: [Int]]
    
    init(_ nums: [Int]) {
        var map = [Int: [Int]]()
        
        for i in 0..<nums.count {
            if var x = map[nums[i]] {
                x.append(i)
                map[nums[i]] = x
            }
            else {
                map[nums[i]] = [i]
            }
        }
        
        self.map = map
    }
    
    func pick(_ target: Int) -> Int {
        if let x = map[target] {
            let index = Int.random(in: 0..<x.count)
            return x[index]
        }
        return -1
    }
}

class TimeMap {

    /** Initialize your data structure here. */
    private var map = [String: [Int: String]]()
    init() {
        
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        if var val = map[key] {
            val[timestamp] = value
            map[key] = val
        }
        else {
            map[key] = [timestamp: value]
        }
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        if let val = map[key] {
            let keys = val.keys.sorted()
            let x = binarySearch(keys, timestamp)
            if x != -1 {
                return val[x] ?? ""
            }
        }
        return ""
    }
    
    func binarySearch(_ list: [Int], _ target: Int) -> Int {
        if list.isEmpty {
            return -1
        }
        var counter = list.count - 1
        while counter >= 0 {
            let item = list[counter]
            if item > target {
                
            }
            else {
                return item
            }
            counter -= 1
        }
        return -1
    }
}

struct TimeMapItem {
    let time: Int
    let val: String
}

extension TimeMapItem: Comparable {
    static func < (lhs: TimeMapItem, rhs: TimeMapItem) -> Bool {
        lhs.time <= rhs.time
    }
}




