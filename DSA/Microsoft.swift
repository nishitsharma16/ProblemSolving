//
//  Microsoft.swift
//  DSA
//
//  Created by Nishit on 14/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {

    static func findDuplicates(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var result = [Int]()
        var map = [Int: Int]()
        for item in nums {
            if let val = map[item] {
                if val == 1 {
                    result.append(item)
                }
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        return result
    }
    
    func inorderSuccessorV2(_ node: TreeParentNode?) -> TreeParentNode? {
        if node == nil {
            return nil
        }
        var curr: TreeParentNode?
        if node?.right != nil {
            curr = node?.right
            while curr?.left != nil {
                curr = curr?.left
            }
            return curr
        }
        else {
            curr = node
            var parent = curr?.parent
            while parent != nil && parent?.left != curr {
                curr = curr?.parent
                parent = curr?.parent
            }
            return parent
        }
    }
    
    func reverseString(_ s: inout [Character]) {
        var l = 0
        var r = s.count - 1
        while l < r {
            s.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    static func myAtoi(_ str: String) -> Int {
        let val = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if val.isEmpty {
            return 0
        }
        var str = Array(val)
        let isPositive = str[0] != "-"
        if str[0] == "-" || str[0] == "+" {
            str.removeFirst()
        }
        if str.isEmpty {
            return 0
        }
        if !str[0].isNumber {
            return 0
        }
        
        var result = 0
        for item in str {
            if item.isNumber {
                let x = String(item)
                result = 10*result + (Int(x) ?? 0)
                if result > Int32.max {
                    return isPositive ? Int(Int32.max) : Int(Int32.min)
                }
            }
            else {
                break
            }
        }
        
        return isPositive ? result : -result
    }
    
    enum IPType: String {
        case Neither
        case IPv4
        case IPv6
    }
    
    static func validateIPComponent(_ val: String, _ ipType: IPType) -> Bool {
        let len = val.count
        if ipType == .IPv4 {
            if len > 1 && len <= 3 && val[0] != "0" {
                if let x = Int(val), x >= 0 && x <= 255 {
                    return true
                }
            }
            else if len == 1 {
                if let x = Int(val), x >= 0 && x <= 9 {
                    return true
                }
            }
        }
        else if ipType == .IPv6 {
            if len >= 1 && len <= 4 {
                return val.isHexaDecimal()
            }
        }
        return false
    }
    
    static func validIPAddress(_ IP: String) -> String {
        if IP.isEmpty {
            return IPType.Neither.rawValue
        }
        var components = [String]()
        var ipType: IPType = .Neither
        if let _ = IP.firstIndex(of: ".") {
            components = IP.components(separatedBy: ".")
            ipType = components.count == 4 ? .IPv4 : .Neither
        }
        else if let _ = IP.firstIndex(of: ":") {
            components = IP.components(separatedBy: ":")
            ipType = components.count == 8 ? .IPv6 : .Neither
        }
        
        for item in components {
            if !validateIPComponent(item, ipType) {
                return IPType.Neither.rawValue
            }
        }
        
        return ipType.rawValue
    }
    
    func reverseWord(_ s: inout [Character], _ start: Int, _ end: Int) {
        var l = start
        var r = end
        
        while l < r {
            s.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    func reverseWords(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        var list = s.map { $0 }
        var start = 0
        let len = s.count
        for i in 0..<len {
            if list[i] == " " {
                reverseWord(&list, start, i - 1)
                start = i + 1
            }
        }
        reverseWord(&list, start, len - 1)
        let result = list.reduce("", { (prev, curr) -> String in
            prev + String(curr)
        })
        return result
    }
    
    func reverseWordsV2(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        var result = ""
        let list = s.split(separator: " ")
        for item in list {
            result += String(item.reversed()) + " "
        }
        
        result.remove(at: result.index(before: result.endIndex))
        return result
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        let left = invertTree(root?.left)
        let rigt = invertTree(root?.right)
        root?.left = rigt
        root?.right = left
        return root
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let sum = nums.reduce(0, +)
        let set = Set<Int>(nums)
        let setSum = set.reduce(0, +)
        return 2*setSum - sum
    }
    
    func deleteNode(_ node: SortedNode?) {
        if node == nil {
            return
        }
        
        var curr = node
        if curr?.next != nil, let nextVal = curr?.next?.val {
            curr?.val = nextVal
            var temp = curr?.next
            curr?.next = temp?.next
            temp = nil
        }
        else {
            curr = nil
        }
    }
    
    func fizzBuzz(_ n: Int) -> [String] {
        if n < 1 {
            return []
        }
        
        var result = [String]()
        for i in 1...n {
            if i % 3 == 0 {
                result.append("Fizz")
            }
            else if i % 5 == 0 {
                result.append("Buzz")
            }
            else if i % 15 == 0 {
                result.append("FizzBuzz")
            }
            else {
                result.append("\(i)")
            }
        }
        return result
    }
    
    func inOrder(_ root: TreeNode?, _ list: inout [Int]) {
        if let r = root {
            inOrder(r.left, &list)
            list.append(r.value)
            inOrder(r.right, &list)
        }
    }
    
    func makeTree(_ list: [Int], _ low: Int, _ high: Int) -> TreeNode? {
        if low > high {
            return nil
        }
        
        let mid = (low + high)/2
        let root = TreeNode(val: list[mid])
        let left = makeTree(list, low, mid - 1)
        root.left = left
        root.right = makeTree(list, mid + 1, high)
        return root
    }
    
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if let val = root?.value {
            if val > high {
                return trimBST(root?.left, low, high)
            }
            else if val < low {
                return trimBST(root?.right, low, high)
            }
        }
        root?.left = trimBST(root?.left, low, high)
        root?.right = trimBST(root?.right, low, high)
        return root
    }
    
    static func canPermutePalindrome(_ s: String) -> Bool {
        var map = [Character: Int]()
        for item in s {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        var x = 0
        for item in map {
            x += item.value % 2
        }
        return x <= 1
    }
    
    static func reverseInt(_ x: Int) -> Int {
        var result = 0
        let isNegative = x < 0
        var n = x >= 0 ? x : -x
        while n > 0 {
            result = result * 10 + (n % 10)
            n /= 10
        }
        if result > Int32.max {
            return 0
        }
        return isNegative ? -result : result
    }
    
    func countPrimes(_ n: Int) -> Int {
        if n < 2 {
            return 0
        }
        var counter = 0
        var status = Array(repeating: false, count: n)
        for i in 2..<n {
            if !status[i] {
                counter += 1
                var j = 0
                while i*j < n {
                    status[i*j] = true
                    j += 1
                }
            }
        }
        return counter
    }
    
    func checkPalindrome(_ s: ArraySlice<Character>, _ start: Int, _ end: Int) -> Bool {
        var l = start
        var r = end
        while l < r {
            if s[l] != s[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
    
    func validPalindrome2(_ s: String) -> Bool {
        let str = Array(s)[0...]
        var start = 0
        var end = s.count - 1
        while start < end {
            if str[start] != str[end] {
                return checkPalindrome(str, start + 1, end) || checkPalindrome(str, start, end - 1)
            }
            start += 1
            end -= 1
        }
        return true
    }
    
    static func isPalindromeSentence(_ s: String) -> Bool {
        let str = Array(s)[0...]
        if str.isEmpty {
            return true
        }
        var l = 0
        var r = str.count - 1
        while l <= r {
            if !str[l].isValidAlphabet {
                l += 1
            }
            else if !str[r].isValidAlphabet {
                r -= 1
            }
            else if str[l].lowercased() == str[r].lowercased() {
                l += 1
                r -= 1
            }
            else {
                return false
            }
        }
        return true
    }
    
    static func compareVersionHelper(_ v1: [String], _ v2: [String], _ shouldToggle: Bool) -> Int {
        
        if v1.count > v2.count {
            return compareVersionHelper(v2, v1, true)
        }
        var counter = 0
        var i = 0
        while i < v1.count {
            let item1 = myAtoi(v1[i])
            let item2 = myAtoi(v2[i])
            if item1 > item2 {
                return shouldToggle ?  -1 : 1
            }
            else if item1 < item2 {
                return shouldToggle ?  1 : -1
            }
            i += 1
            counter += 1
        }
        while counter < v2.count {
            let item1 = myAtoi(v2[counter])
            if item1 > 0 {
                return shouldToggle ?  1 : -1
            }
            counter += 1
        }
        return 0
    }
    
    static func compareVersion(_ version1: String, _ version2: String) -> Int {
        let val1 = version1.components(separatedBy: ".")
        let val2 = version2.components(separatedBy: ".")
        let result = compareVersionHelper(val1, val2, false)
        return result
    }
    
    static func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k < 1 {
            return false
        }
        let n = nums.count
        for i in 0..<n {
            for l in 1...k {
                let j = i + l
                if j < n && i != j && abs(nums[i] - nums[j]) <= t {
                    return true
                }
            }
        }
        
        return false
    }
    
    func containsNearbyAlmostDuplicateV2(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        
        if k < 1 {
            return false
        }
        
        var set = Set<Int>()
        let n = nums.count
        for i in 0..<n {
            let status = set.contains { (val) -> Bool in
                return abs(val - nums[i]) <= t
            }
            if status {
                return true
            }
            set.insert(nums[i])
            if set.count > k {
                set.remove(nums[i - k])
            }
        }
        
        return false
    }
    
    static func circularArrayLoop(_ nums: [Int]) -> Bool {
        let len = nums.count
        if len <= 1 {
            return false
        }
        var i: Int = 0
        var status = false
        var lastValue = nums[0]
        var set = Set<Int>()
        while true {
            let val = nums[i]
            let position = (i + val) < 0 ? len + val : (i + val) % len
            if lastValue * val < 0 {
                status = false
                break
            }
            else if set.contains(position) {
                status = true
                break
            }
            set.insert(i)
            i = position
            lastValue = val
        }
        
        return status
    }
    
    static func numWaysToSpiltInThreeParts(_ s: String) -> Int {
        let list = Array(s)
        if list.count < 3 {
            return 0
        }
        let numberOfOnes = list.filter { (val) -> Bool in
            val == "1"
        }.count
        if numberOfOnes > 0 && numberOfOnes < 3 {
            return 0
        }
        let len = list.count
        var numberOfOnesList = Array(repeating: 0, count: len)
        numberOfOnesList[0] = (list[0] == "1" ? 1 : 0)
        for i in 1..<len {
            numberOfOnesList[i] = list[i] == "1" ? numberOfOnesList[i - 1] + 1 : numberOfOnesList[i - 1]
        }
        var counter = 0
        for i in 0..<len-2 {
            for j in i+1..<len-1 {
                if numberOfOnesList[i] == numberOfOnesList[j] - numberOfOnesList[i] && numberOfOnesList[len - 1] - numberOfOnesList[j] == numberOfOnesList[j] - numberOfOnesList[i]  {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }
        else {
            return gcd(b, a % b)
        }
    }
    
    func canMeasureWater(_ x: Int, _ y: Int, _ z: Int) -> Bool {
        if z == 0 {
            return true
        }
        else if z > x + y {
            return false
        }
        else {
            let r = gcd(x, y)
            return z % r == 0
        }
    }
    
    func rotateRight(_ head: SortedNode?, _ k: Int) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        let len = lengthOfList(head)
        let kVal = k >= len ? k % len : k
        if kVal == 0 {
            return head
        }
        var headValue = head
        var curr = headValue
        var counter = 0
        while curr != nil && counter < kVal {
            curr = curr?.next
            counter += 1
        }
        
        var last = headValue
        while curr?.next != nil {
            last = last?.next
            curr = curr?.next
        }
        
        let temp = last?.next
        last?.next = nil
        curr?.next = headValue
        headValue = temp
        return headValue
    }
    
    func removeNthFromEnd(_ head: SortedNode?, _ n: Int) -> SortedNode? {
        let len = lengthOfList(head)
        if head == nil || n > len {
            return nil
        }
        else if n == 0 {
            return head
        }
        
        var curr = head
        var counter = 0
        while curr != nil && counter < n {
            curr = curr?.next
            counter += 1
        }
        
        var last = head
        var prev: SortedNode?
        while curr != nil {
            prev = last
            last = last?.next
            curr = curr?.next
        }
        
        var temp = last?.next
        if temp != nil {
            if let tempVal = temp?.val {
                last?.val = tempVal
                last?.next = temp?.next
                temp = nil
            }
        }
        else {
            prev?.next = nil
            last = nil
        }
        
        return head
    }
    
    static func reverseList(_ list: inout [Int], _ start: Int, _ end: Int) {
        var l = start
        var r = end
        while l < r {
            list.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    static func rotateArray(_ nums: inout [Int], _ k: Int) {
        if nums.isEmpty || k == 0 {
            return
        }
        let len = nums.count
        let kVal = k >= len ? k % len : k
        let secondStart = len - kVal
        reverseList(&nums, 0, secondStart - 1)
        reverseList(&nums, secondStart, len - 1)
        reverseList(&nums, 0, len - 1)
    }
    
    static func get4SumV3WithOutDuplicates(nums: [Int], target: Int) -> [[Int]] {
        if nums.isEmpty {
            return []
        }
        else if nums.count < 4 {
            return []
        }
        let list = nums.sorted()
        let length = list.count
        var result = [[Int]]()
        var set = Set<String>()
        
        for i in 0..<length - 3 {
            for j in i + 1..<length - 2 {
                var l = j + 1
                var r = length - 1
                let val = target - (list[i] + list[j])
                while l < r {
                    let sum = list[l] + list[r]
                    if sum == val {
                        let str = "\(list[i]),\(list[j]),\(list[l]),\(list[r])"
                        if !set.contains(str) {
                            result.append(contentsOf: [[list[i], list[j], list[l], list[r]]])
                            set.insert(str)
                        }
                        while l < r && list[l] == list[l + 1] {
                            l += 1
                        }
                        while l < r && list[r] == list[r - 1] {
                            r -= 1
                        }
                        l += 1
                        r -= 1
                    }
                    else if sum < val {
                        l += 1
                    }
                    else {
                        r -= 1
                    }
                }
            }
        }
        return result
    }

    static func counterHelper(_ n: Int, _ map: inout [Int: Int]) -> Int {
        if n == 1 {
            return 0
        }
        else if let val = map[n], val != 0 {
            return val
        }
        else if n % 2 == 0 {
            map[n] = 1 + counterHelper(n / 2, &map)
        }
        else {
            map[n] = 1 + min(counterHelper(n - 1, &map), counterHelper(n + 1, &map))
        }
        return map[n] ?? 0
    }
    
    static func integerReplacement(_ n: Int) -> Int {
        if n <= 1 {
            return 0
        }
        var map = [Int: Int]()
        let result = counterHelper(n, &map)
        return result
    }
    
    static func lruCacheImplement() {
        let cache = LRUCache(2)
        cache.put(1, 1)
        cache.put(2, 2)
        var val = cache.get(1)
        cache.put(3, 3)
        val = cache.get(2)
    }
    
    func read4(_ buf: inout [Character]) -> Int {
        return 0
    }
    
    func read(_ buf: inout [Character], _ n: Int) -> Int {
        var nVal = n
        let empty: Character = " "
        while nVal > 0 {
            var str = Array<Character>(repeating: empty, count: 4)
            let x = read4(&str)
            if x == 0 {
                break
            }
            buf += str
            nVal -= x
        }
        let val = buf.reduce("") { (prev, curr) -> String in
            prev + String(curr)
        }.trimmingCharacters(in: CharacterSet.whitespaces).prefix(n)
        
        buf = Array(val)
        return buf.count
    }
    
    func readV2(_ buf: inout [Character], _ n: Int) -> Int {
        var counter = 0
        var readFour = 4
        let empty: Character = " "
        while counter < n && readFour == 4 {
            var str = Array<Character>(repeating: empty, count: 4)
            readFour = read4(&str)
            let end = min(n - counter, readFour)
            buf += str.prefix(end)
            counter += readFour
        }
        let val = buf.reduce("") { (prev, curr) -> String in
            prev + String(curr)
        }.trimmingCharacters(in: CharacterSet.whitespaces)
        buf = Array(val)
        return buf.count
    }
    
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        if pattern.isEmpty || s.isEmpty {
            return false
        }
        let x = Array(pattern)
        let y = s.split(separator: " ")
        if x.count != y.count {
            return false
        }
        
        var mapA = [Character: [Int]]()
        var mapB = [String: [Int]]()
        for i in 0..<x.count {
            if var val = mapA[x[i]] {
                val.append(i)
                mapA[x[i]] = val
            }
            else {
                mapA[x[i]] = [i]
            }
            
            let item = String(y[i])
            if var val = mapB[item] {
                val.append(i)
                mapB[item] = val
            }
            else {
                mapB[item] = [i]
            }
        }
        
        for i in 0..<x.count {
            let item = String(y[i])
            if let a = mapA[x[i]], let b = mapB[item], a != b {
                return false
            }
        }
        
        return true
    }
    
    func trailingZeroes(_ n: Int) -> Int {
        if n < 5 {
            return 0
        }
        var nVal = n
        var zeros = 0
        while nVal > 0 {
            nVal /= 5
            zeros += nVal
        }
        return zeros
    }
    
    func isPalindromeLinkedList(_ head: SortedNode?) -> Bool {
        if head == nil {
            return true
        }
        var curr = head
        var list = [Int]()
        while curr != nil {
            if let val = curr?.val {
                list.append(val)
            }
            curr = curr?.next
        }
        
        var l = 0
        var r = list.count - 1
        while l < r {
            if list[l] != list[r] {
                return false
            }
            l += 1
            r -= 1
        }
        
        return true
    }
    
    func isPalindromeLinkedListV2Helper(_ head: SortedNode?, front: inout SortedNode?) -> Bool {
        if head != nil {
            if !isPalindromeLinkedListV2Helper(head?.next, front: &front) {
                return false
            }
            if let headval = head?.val, let frontval = front?.val, frontval != headval {
                return false
            }
            front = front?.next
        }
        return true
    }
    
    func isPalindromeLinkedListV2(_ head: SortedNode?) -> Bool {
        var front = head
        return isPalindromeLinkedListV2Helper(head, front: &front)
    }
    
    static func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if nums1.isEmpty {
            nums1 = nums2
            return
        }
        else if nums2.isEmpty {
            return
        }
        var i = 0
        var j = 0
        var list = Array(repeating: 0, count: m + n)
        var k = 0
        while i < m && j < n {
            if nums1[i] <= nums2[j] {
                list[k] = nums1[i]
                i += 1
                k += 1
            }
            else {
                list[k] = nums2[j]
                j += 1
                k += 1
            }
        }
        
        while j < n {
            list[k] = nums2[j]
            j += 1
            k += 1
        }
        
        while i < m {
            list[k] = nums1[i]
            i += 1
            k += 1
        }
        nums1 = list
    }
    
    static func mergeV2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if nums1.isEmpty {
            nums1 = nums2
            return
        }
        else if nums2.isEmpty {
            return
        }
        var i = m - 1
        var j = n - 1
        var k = m + n - 1
        while i >= 0 && j >= 0 {
            if nums1[i] > nums2[j] {
                nums1[k] = nums1[i]
                i -= 1
            }
            else {
                nums1[k] = nums2[j]
                 j -= 1
            }
            k -= 1
        }
        while j >= 0 {
            nums1[k] = nums2[j]
            j -= 1
            k -= 1
        }
    }
    
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if k < 1 {
            return false
        }
        
        var set = Set<Int>()
        let n = nums.count
        for i in 0..<n {
            if set.contains(nums[i]) {
                return true
            }
            set.insert(nums[i])
            if set.count > k {
                set.remove(nums[i - k])
            }
        }
        
        return false
    }
    
    func removeElements(_ head: SortedNode?, _ val: Int) -> SortedNode? {
        if head == nil {
            return head
        }
        
        let dummy: SortedNode? = SortedNode(-1)
        dummy?.next = head
        var curr = head
        var prev = dummy

        while curr != nil {
            if let x = curr?.val, x == val {
                prev?.next = curr?.next
            }
            else {
                prev = curr
            }
            curr = curr?.next
        }
        
        return dummy?.next
    }
    
    func hasPathSumHelper(_ root: TreeNode?, _ sum: Int) -> Bool {
        if root == nil {
            return false
        }
        var sumVal = sum
        sumVal -= root?.value ?? 0
        if root?.left == nil && root?.right == nil {
            return sumVal == 0
        }
        let leftSum = hasPathSumHelper(root?.left, sumVal)
        let rightSum = hasPathSumHelper(root?.right, sumVal)
        return leftSum || rightSum
    }
    
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        if root == nil && sum == 0 {
            return true
        }
        else if root == nil {
            return false
        }
        
        return hasPathSumHelper(root, sum)
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        if digits.isEmpty {
            return []
        }
        
        let len = digits.count
        var result = Array(repeating: 0, count: len)
        var carry = 1
        var counter = len - 1
        while counter >= 0 {
            let sum = digits[counter] + carry
            result[counter] = sum % 10
            carry = sum / 10
            counter -= 1
        }
        if carry > 0 {
            if result.isEmpty {
                result.append(carry)
            }
            else {
                result.insert(carry, at: 0)
            }
        }
        return result
    }
    
    static func summaryRanges(_ nums: [Int]) -> [String] {
        if nums.isEmpty {
            return []
        }
        
        var list = [String]()
        var start = 0
        for i in 0..<nums.count - 1 {
            if nums[i] != nums[i + 1] - 1 {
                if nums[start] == nums[i] {
                    list.append("\(nums[start])")
                }
                else {
                    list.append("\(nums[start])->\(nums[i])")
                }
                start = i + 1
            }
        }
        
        let last = nums.count - 1
        if start <= last {
            if nums[start] == nums[last] {
                list.append("\(nums[start])")
            }
            else {
                list.append("\(nums[start])->\(nums[last])")
            }
        }
        return list
    }
    
    func findSecondMinimumValueHelper(_ root: TreeNode?, _ set: inout Set<Int>) {
        if root == nil {
            return
        }
        
        if let val = root?.value {
            set.insert(val)
        }
        findSecondMinimumValueHelper(root?.left, &set)
        findSecondMinimumValueHelper(root?.right, &set)
    }
    
    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        if root == nil {
            return -1
        }
        var set = Set<Int>()
        findSecondMinimumValueHelper(root, &set)
        var firstMin = Int.max
        var secondMin = Int.max
        for item in set {
            if firstMin > item {
                secondMin = firstMin
                firstMin = item
            }
            else if secondMin > item && firstMin != item {
                secondMin = item
            }
        }
        return secondMin == Int.max ? -1 : secondMin
    }
    
    func isSubtreeHelper(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        if (s == nil && t == nil) {
            return true
        }
        else if s == nil || t == nil {
            return false
        }
        
        return s?.value == t?.value && isSubtreeHelper(s?.left, t?.left) && isSubtreeHelper(s?.right, t?.right)
    }
    
    func traverse(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        return s != nil && (isSubtreeHelper(s, t) || traverse(s?.left, t) || traverse(s?.right, t))
    }
    
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        return traverse(s, t)
    }
    
    func height(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        let leftHeight = height(root?.left)
        let rightHeight = height(root?.right)
        return max(leftHeight, rightHeight) + 1
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        let leftHeight = height(root?.left)
        let rightHeight = height(root?.right)
        return abs(leftHeight - rightHeight) <= 1 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    static func sumPivotIndex(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let len = nums.count
        var sumList = Array(repeating: 0, count: len)
        sumList[0] = nums[0]
        for i in 1..<len {
            sumList[i] += sumList[i - 1] + nums[i]
        }
        
        for i in 0..<sumList.count {
            if sumList[i] - nums[i] == sumList[len - 1] - sumList[i] {
                return i
            }
        }
        return -1
    }
    
    func deleteDuplicates(_ head: SortedNode?) -> SortedNode? {
        if head == nil {
            return head
        }
        
        let dummy: SortedNode? = SortedNode(-1)
        dummy?.next = head
        var curr = head
        var next = curr?.next
        
        while curr != nil && next != nil {
            if let x = curr?.val, let nextVal = next?.val, x == nextVal {
                curr?.next = next?.next
            }
            else {
                curr = curr?.next
            }
            next = curr?.next
        }
        
        return dummy?.next
    }
    
    static func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        if paragraph.isEmpty || banned.isEmpty {
            return ""
        }
        
        let str = paragraph.lowercased()
        let list = str.split(separator: ",")
        var newList = [Substring]()
        for item in list {
            let val = String(item).split(separator: " ")
            newList.append(contentsOf: val)
        }
        var map = [String: Int]()
        for item in newList {
            let val = String(item).trimmingCharacters(in: CharacterSet.punctuationCharacters)
            if !banned.contains(val) {
                if let x = map[val] {
                    map[val] = x + 1
                }
                else {
                    map[val] = 1
                }
            }
        }
        
        var val: (key: String, val: Int) = ("", Int.min)
        for item in map {
            if item.value > val.val {
                val = (item.key, item.value)
            }
        }
        return val.key
    }
    
    func isSymmetricTreeHelper(_ r1: TreeNode?, _ r2: TreeNode?) -> Bool {
        if r1 == nil && r2 == nil {
            return true
        }
        else if r1 == nil || r2 == nil {
            return false
        }
        
        return r1?.value == r2?.value && isSymmetricTreeHelper(r1?.left, r2?.right) && isSymmetricTreeHelper(r1?.right, r2?.left)
    }
    
    func isSymmetricTree(root: TreeNode?) -> Bool {
        return isSymmetricTreeHelper(root, root)
    }
    
    static func isStrobogrammatic(_ num: String) -> Bool {
        if num.isEmpty {
            return true
        }
        var list = Array(num)
        let start = 0
        let evenSet = ["00", "11", "88", "69", "96"]
        let oddSet = ["0", "1", "8"]
        
        if list.count == 1 {
            let x = String(list[0])
            if oddSet.contains(x) {
                return true
            }
            else {
                return false
            }
        }
        
        if list.count % 2 != 0 {
            let mid = (start + list.count - 1)/2
            let x = String(list[mid])
            if oddSet.contains(x) {
                list.remove(at: mid)
            }
            else {
                return false
            }
        }
        
        while list.count > 2 {
            let mid = (start + list.count - 1)/2
            let x = String(list[mid + 1]) + String(list[mid])
            if evenSet.contains(x) {
                list.removeSubrange(mid...mid+1)
            }
            else {
                return false
            }
        }
        if list.count == 2 {
            let x = String(list[0]) + String(list[1])
            if evenSet.contains(x) {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
    
    static func modifyString(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let x = "abcdefghijklmnopqrstuvwxyz"
        let xList = Array(x)
        var list = Array(s)
        let len = list.count
        
        let aValue = 97
        if list[0] == "?" {
            list[0] = "a"
        }
        for i in 1..<len {
            if list[i] == "?" {
                if let val = list[i - 1].asciiValue {
                    let index = Int(val)
                    list[i] = xList[(index - aValue + 1) % 26]
                }
            }
            else if list[i] == list[i - 1] {
                if let val = list[i - 1].asciiValue {
                    let index = Int(val)
                    list[i - 1] = xList[(index - aValue + 1) % 26]
                }
            }
        }
        let result = list.reduce("") { (prev, curr) -> String in
            prev + String(curr)
        }
        return result
    }
    
    @discardableResult
    func diameterHeight(_ root: TreeNode?, _ maxVal: inout Int) -> Int {
        if root == nil {
            return 0
        }
        let leftHeight = diameterHeight(root?.left, &maxVal)
        let rightHeight = diameterHeight(root?.right, &maxVal)
        maxVal = max(maxVal, leftHeight + rightHeight)
        return max(leftHeight, rightHeight) + 1
    }
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var maxVal = 0
        diameterHeight(root, &maxVal)
        return maxVal
    }
    
    func addStrings(_ num1: String, _ num2: String) -> String {
        let list1 = Array(num1)
        let list2 = Array(num2)
        let len1 = list1.count
        let len2 = list2.count
        var result = Array(repeating: 0, count: max(len1, len2))
        var counter1 = len1 - 1
        var counter2 = len2 - 1
        var k = result.count - 1
        
        var carry = 0
        while counter1 >= 0 && counter2 >= 0 {
            if let x = Int(String(list1[counter1])), let y = Int(String(list2[counter2])) {
                let sum = x + y + carry
                result[k] = sum % 10
                carry = sum / 10
            }
            k -= 1
            counter2 -= 1
            counter1 -= 1
        }
        while counter2 >= 0 {
            if let y = Int(String(list2[counter2])) {
                let sum = y + carry
                result[k] = sum % 10
                carry = sum / 10
            }
            k -= 1
            counter2 -= 1
        }
        
        while counter1 >= 0 {
            if let y = Int(String(list1[counter1])) {
                let sum = y + carry
                result[k] = sum % 10
                carry = sum / 10
            }
            k -= 1
            counter1 -= 1
        }
        if carry > 0 {
            result.insert(carry, at: 0)
        }
        let str = result.reduce("") { (prev, curr) -> String in
            prev + "\(curr)"
        }
        return str
    }
    
    static func rotateString(_ A: String, _ B: String) -> Bool {
        if A == B {
            return true
        }
        let list1 = Array(A)
        let list2 = Array(B)
        if list1.count != list2.count {
            return false
        }
        
        var i = 0
        var start = -1
        var j = 0
        var k = 0
        while k < list1.count && i < list1.count {
            j = 0
            k = i
            if list1[i] == list2[j] {
                while k < list1.count && j < list2.count {
                    if list1[k] == list2[j] {
                        start = i
                        j += 1
                        k += 1
                    }
                    else {
                        start = -1
                        break
                    }
                }
            }
            i += 1
        }
        
        if start == -1 {
            return false
        }
        
        var x = list1.suffix(j)
        var y = list2.prefix(j)
        if x != y {
            return false
        }
        
        x = list1[0..<list1.count - j]
        y = list2[j..<list2.count]
        if x != y {
            return false
        }

        return true
    }
    
    static func isSubsequence(_ s: String, _ t: String) -> Bool {
        if s.isEmpty {
            return true
        }
        
        let sList = Array(s)
        var tList = Array(t)
        if sList.count > tList.count {
            return false
        }
        
        var j = 0
        var i = 0
        
        while j < sList.count && i < tList.count {
            if tList[i] == sList[j] {
                i += 1
                j += 1
            }
            else {
                tList.remove(at: i)
            }
        }
        
        return tList.prefix(sList.count) == sList[0...]
    }
    
    func getReverseNumber(_ n: Int) -> Int {
        var nVal = n
        var rev = 0
        while nVal > 0 {
            rev = 10 * rev + nVal % 10
            nVal = nVal / 10
        }
        return rev
    }
    
    func isPalindromeNumber(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        let y = getReverseNumber(x)
        return y == x
    }
    
    func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
        var closest = root?.value ?? -1
        var rootVal = root
        while rootVal != nil {
            if let val = rootVal?.value {
                closest = abs(Double(val) - target) < abs(Double(closest) - target) ? val : closest
                rootVal = target < Double(val) ? rootVal?.left : rootVal?.right
            }
        }
        return closest
    }
    
    func lowestCommonAncestorHelper(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        let x = root?.value ?? -1
        let y = p?.value ?? -1
        let z = q?.value ?? -1
        if x > y && x > z {
            return lowestCommonAncestor(root?.left, p, q)
        }
        else if x < y && x < z {
            return lowestCommonAncestor(root?.right, p, q)
        }
        else {
            return root
        }
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        return lowestCommonAncestorHelper(root, p, q)
    }
    
    func getNext(_ n: Int) -> Int {
        var result = 0
        var nVal = n
        while nVal > 0 {
            let x = nVal % 10
            nVal /= 10
            result += x * x
        }
        return result
    }
    
    func isHappy(_ n: Int) -> Bool {
        var set = Set<Int>()
        var nVal = n
        while nVal != 1 && !set.contains(nVal) {
            set.insert(nVal)
            nVal = getNext(nVal)
        }
        return nVal == 1
    }
    
    static func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.isEmpty || nums2.isEmpty {
            return []
        }
        
        if nums1.count > nums2.count {
            return intersect(nums2, nums1)
        }
        
        var map = [Int : Int]()
        for item in nums1 {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        var result = [Int]()
        
        for item in nums2 {
            if let x = map[item], x > 0 {
                result.append(item)
                map[item] = x - 1
            }
        }
        
        return result
    }
    
    static func intersectWithoutDuplicates(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.isEmpty || nums2.isEmpty {
            return []
        }
        
        if nums1.count > nums2.count {
            return intersect(nums2, nums1)
        }
        
        var map = [Int : Int]()
        for item in nums1 {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        var result = [Int]()
        
        for item in nums2 {
            if let x = map[item], x > 0 {
                if !result.contains(item) {
                    result.append(item)
                }
                map[item] = x - 1
            }
        }
        
        return result
    }
    
    static func getRowInPascleTringle(_ rowIndex: Int) -> [Int] {
        var list = Array<Array<Int>>()
        for i in 0...rowIndex {
            let count = i + 1
            var x = Array<Int>(repeating: 0, count: count)
            x[0] = 1
            x [count - 1] = 1
            if i > 1 {
                let y = list[i - 1]
                for j in 1..<count - 1 {
                    x[j] = y[j - 1] + y[j]
                }
            }
            list.append(x)
        }
        return list[rowIndex]
    }
    
    // Number of 1 bits
    func hammingWeight(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        var counter = 0
        var one = 1
        for _ in 0..<32 {
            let x = n & (one)
            if x != 0 {
                counter += 1
            }
            one = one << 1
        }
        return counter
    }
    
    func firstUniqChar(_ s: String) -> Int {
        
        if s.isEmpty {
            return 0
        }
        
        var map = [Character: Int]()
        let sVal = Array(s)
        
        for item in sVal {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        
        for i in 0..<sVal.count {
            let item = sVal[i]
            if let x = map[item], x == 1 {
                return i
            }
        }
        
        return -1
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        let n = nums.count
        let sum = n * (n + 1)/2
        let x = nums.reduce(0) { (prev, curr) -> Int in
            prev + curr
        }
        return sum - x
    }
    
    func binaryTreePathsHelper(_ root: TreeNode?, _ str: String, _ result: inout [String]) {
        if let rVal = root?.value {
            var val = str + "\(rVal)"
            if root?.left == nil && root?.right == nil {
                result.append(val)
                return
            }
            else {
                val += "->"
            }
            binaryTreePathsHelper(root?.left, val, &result)
            binaryTreePathsHelper(root?.right, val, &result)
        }
    }
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        if root == nil {
            return []
        }
        var result = [String]()
        binaryTreePathsHelper(root, "", &result)
        return result
    }
    
    // Not working
    func depthAndParentForNode(_ root: TreeNode?, _ parent: TreeNode?, _ val: Int) -> (h: Int, r: TreeNode?) {
        if root == nil {
            return (0, root)
        }
        else if let x = root?.value, val == x {
            return (0, parent ?? root)
        }
        let lHeight = depthAndParentForNode(root?.left, root, val)
        let rHeight = depthAndParentForNode(root?.right, root, val)
        return (max(lHeight.h, rHeight.h) + 1, lHeight.r ?? rHeight.r)
    }
    
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        let xVal = depthAndParentForNode(root, nil, x)
        let yVal = depthAndParentForNode(root, nil, y)
        return xVal.h == yVal.h && xVal.r !== yVal.r
    }
    
    static func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.isEmpty {
            return true
        }
        
        let sList = Array(ransomNote)
        let tList = Array(magazine)
        if sList.count > tList.count {
            return false
        }
        
        var map = [Character: Int]()
        for item in tList {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        var i = 0
        while i < sList.count {
            if let val = map[sList[i]], val > 0 {
                map[sList[i]] = val - 1
            }
            else {
                return false
            }
            i += 1
        }
        
        return true
    }
    
    static func canConstructV2(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.isEmpty {
            return true
        }
        
        let sList = Set(ransomNote)
        let tList = Set(magazine)
        if sList.count > tList.count {
            return false
        }
        return sList.isSubset(of: tList)
    }
    
    func generatePascleTringle(_ numRows: Int) -> [[Int]] {
        var list = Array<Array<Int>>()
        for i in 0..<numRows {
            let count = i + 1
            var x = Array<Int>(repeating: 0, count: count)
            x[0] = 1
            x [count - 1] = 1
            if i > 1 {
                let y = list[i - 1]
                for j in 1..<count - 1 {
                    x[j] = y[j - 1] + y[j]
                }
            }
            list.append(x)
        }
        return list
    }
    
    func levelOrderBottomHelper(_ root: TreeNode?, _ level: Int, _ map: inout [Int: [Int]]) {
        if let r = root {
            if var val = map[level] {
                val.append(r.value)
                map[level] = val
            }
            else {
                map[level] = [r.value]
            }
            levelOrderBottomHelper(root?.left, level + 1, &map)
            levelOrderBottomHelper(root?.right, level + 1, &map)
        }
    }
    
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var map = [Int: [Int]]()
        levelOrderBottomHelper(root, 0, &map)
        let x = map.sorted { (first, second) -> Bool in
            first.key > second.key
        }.map { $0.value }
        return x
    }
    
    func tree2strHelper(_ t: TreeNode?) -> String {
        if t == nil {
            return ""
        }
        let x = tree2str(t?.left)
        let y = tree2str(t?.right)
        var z = ""
        if let val = t?.value {
            z += "\(val)"
        }
        if !x.isEmpty && !y.isEmpty {
            z += "(\(x))" + "(\(y))"
        }
        else if !x.isEmpty {
            z += "(\(x))"
        }
        else if !y.isEmpty {
            z += "()" + "(\(y))"
        }
        return z
    }
    
    func tree2str(_ t: TreeNode?) -> String {
        if t == nil {
            return ""
        }
        let x = tree2strHelper(t)
        return x
    }
    
    func countOdds(_ low: Int, _ high: Int) -> Int {
        if low > high {
            return 0
        }
        else if low == high {
            if low % 2 == 0 {
                return 0
            }
            else {
                return 1
            }
        }
        else if low % 2 != 0 && high % 2 != 0 {
            let x = high - low - 1
            return x / 2 + 2
        }
        else if low % 2 == 0 && high % 2 == 0 {
            let x = high - low - 1
            return x - x / 2
        }
        else {
            let x = high - low - 1
            return x / 2 + 1
        }
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        var set = Set<Int>()
        for item in nums {
            if set.contains(item) {
                return true
            }
            else {
                set.insert(item)
            }
        }
        return false
    }
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        if numbers.isEmpty {
            return []
        }
        var l = 0
        var r = numbers.count - 1
        while l < r {
            if numbers[l] + numbers[r] == target {
                return [l + 1, r + 1]
            }
            else if numbers[l] + numbers[r] < target {
                l += 1
            }
            else {
                r -= 1
            }
        }
        return []
    }
    
    static func moveZeroes(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        let len = nums.count
        var i = 0
        var zeros = nums.filter { $0 == 0 }.count
        if zeros == nums.count {
            return
        }
        while i < len {
            if zeros == 0 {
                return
            }
            if nums[i] == 0 {
                for j in i..<len - 1 {
                    nums[j] = nums[j + 1]
                }
                nums[len - 1] = 0
                zeros -= 1
            }
            else {
                i += 1
            }
        }
    }
    
    static func moveZeroesV2(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        let len = nums.count
        var lastNonZeroFoundAt = 0
        for i in 0..<len {
            if nums[i] != 0 {
                nums[lastNonZeroFoundAt] = nums[i]
                lastNonZeroFoundAt += 1
            }
        }
        for i in lastNonZeroFoundAt..<len {
            nums[i] = 0
        }
    }
    
    func findKthPositiveMissingNumber(_ arr: [Int], _ k: Int) -> Int {
        if arr.isEmpty {
            return k
        }
        let last = arr[arr.count - 1]
        var j = 0
        var kVal = k
        var missing = 0
        for i in 1...last {
            if kVal == 0 {
                break
            }
            if i != arr[j] {
                kVal -= 1
                missing = i
            }
            else {
                j += 1
            }
        }
        if kVal > 0 {
            missing = last + kVal
        }
        return missing
    }
    
    func mergeTwoSortedLists(_ l1: SortedNode?, _ l2: SortedNode?) -> SortedNode? {
        let dummy = SortedNode(-1)
        var curr1 = l1
        var curr2 = l2
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
    
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        let set = Set<Int>(nums)
        let n = nums.count
        var result = [Int]()
        for i in 1...n {
            if !set.contains(i) {
                result.append(i)
            }
        }
        return result
    }
    
    
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        if root == nil {
            return false
        }
        var list = [Int]()
        inOrder(root, &list)
        var l = 0
        var r = list.count - 1
        while l < r {
            if list[l] + list[r] == k {
                return true
            }
            else if list[l] + list[r] < k {
                l += 1
            }
            else {
                r -= 1
            }
        }
        return false
    }
    
    static func romanToInt(_ s: String) -> Int {
        var result = 0
        let target = Array(s)
        let map = ["M" : 1000, "CM" : 900, "D" : 500, "CD" : 400, "C" : 100, "XC" : 90, "L" : 50, "XL" : 40, "X" : 10, "IX" : 9, "V" : 5, "IV" : 4, "I" : 1]
        var j = 0
        while j < target.count {
            if j + 1 < target.count {
                let x = String(target[j...j+1])
                if let y = map[x] {
                    result += y
                    j += 2
                }
                else {
                    if let x = map[String(target[j])] {
                        result += x
                        j += 1
                    }
                }
            }
            else {
                if let x = map[String(target[j])] {
                    result += x
                    j += 1
                }
            }
        }
        return result
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        let sVal = Array(s)
        let tVal = Array(t)
        if sVal.count != tVal.count {
            return false
        }
        var map = [Character: Int]()
        for item in sVal {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        for item in tVal {
            if let x = map[item] {
                map[item] = x - 1
            }
        }
        for item in map {
            if item.value != 0 {
                return false
            }
        }
        return true
    }
    
    func digitSum(_ n: Int) -> Int {
        var nVal = n
        var sum = 0
        while nVal > 0 {
            sum += nVal % 10
            nVal /= 10
        }
        return sum
    }
    
    func addDigits(_ num: Int) -> Int {
        if num < 10 {
            return num
        }
        var n = num
        while n >= 10 {
            n = digitSum(n)
        }
        return n
    }
    
    static func reverseOnlyLetters(_ S: String) -> String {
        var sVal = Array(S)
        if sVal.isEmpty {
            return ""
        }
        var l = 0
        var r = sVal.count - 1
        let x = "abcdefghijklmnopqrstuvwxyz" + "abcdefghijklmnopqrstuvwxyz".uppercased()
        let set = Set<Character>(x)
        
        while l < r {
            if set.contains(sVal[l]) && set.contains(sVal[r]) {
                sVal.swapAt(l, r)
                l += 1
                r -= 1
            }
            else if set.contains(sVal[r]) {
                l += 1
            }
            else {
                r -= 1
            }
        }
        return String(sVal)
    }
    
    func majorityElement(_ nums: [Int]) -> Int {
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
        var result = 0
        var max = Int.min
        for x in map {
            if x.value > len / 2 && x.value > max {
                max = x.value
                result = x.key
            }
        }
        return result
    }
    func sortedArrayToBSTHelper(_ nums: [Int], _ l: Int, _ r: Int, _ index: inout Int) -> TreeNode? {
        if l > r {
            return nil
        }
        let mid = (l + r) / 2
        let left = sortedArrayToBSTHelper(nums, l, mid - 1, &index)
        let root = TreeNode(val: nums[index])
        root.left = left
        index += 1
        root.right = sortedArrayToBSTHelper(nums, mid + 1, r, &index)
        return root
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty {
            return nil
        }
        var index = 0
        return sortedArrayToBSTHelper(nums, 0, nums.count - 1, &index)
    }
    
    func shortestDistance(_ words: [String], _ word1: String, _ word2: String) -> Int {
        if words.isEmpty {
            return -1
        }
        var map = [String: [Int]]()
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
        var min = Int.max
        if let x = map[word1], let y = map[word2] {
            for i in x {
                for j in y {
                    if min > abs(i - j) {
                        min = abs(i - j)
                    }
                }
            }
            return min != Int.max ? min : -1
        }
        return -1
    }
    
    func shortestDistance3(_ words: [String], _ word1: String, _ word2: String) -> Int {
        if words.isEmpty {
            return -1
        }
        var map = [String: [Int]]()
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
        var min = Int.max
        if let x = map[word1], let y = map[word2] {
            if x == y {
                let count = x.count
                if count > 1 {
                    return x[count - 1] - x[count - 2]
                }
                else {
                    return -1
                }
            }
            for i in x {
                for j in y {
                    if min > abs(i - j) {
                        min = abs(i - j)
                    }
                }
            }
            return min != Int.max ? min : -1
        }
        return -1
    }
    
    func shortestDistanceV2(_ words: [String], _ word1: String, _ word2: String) -> Int {
        if words.isEmpty {
            return -1
        }
        var x = -1
        var y = -1
        var min = Int.max
        for i in 0..<words.count {
            if words[i] == word1 {
                x = i
            }
            else if words[i] == word2 {
                y = i
            }
            if x != -1 && y != -1 && min > abs(x - y) {
                min = abs(x - y)
            }
        }
        return min != Int.max ? min : -1
    }
    
    static func dayOfTheWeek(_ day: Int, _ month: Int, _ year: Int) -> String {
        let days = ["Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"]
        var months = [31,28,31,30,31,30,31,31,30,31,30,31]
        var counter = 0
        if year % 100 == 0 {
            if year % 400 == 0 {
                months[1] = 29
            }
        }
        else if year % 4 == 0 {
            months[1] = 29
        }
        for i in 1972...year {
            if (i - 1) % 4 == 0 {
                counter += 2
            }
            else {
                counter += 1
            }
        }
        for i in 0..<month - 1 {
            counter += months[i]
        }
        counter += day - 1
        return days[counter % 7]
    }
    
    static func peakIndexInMountainArrayHelper(_ arr: [Int], _ l: Int, _ r: Int) -> Int {
        if l > r {
            return -1
        }
        let mid = (l + r) / 2
        if mid - 1 >= 0 && mid + 1 <= r && arr[mid - 1] < arr[mid] && arr[mid] > arr[mid + 1] {
            return mid
        }
        else if mid - 1 >= 0 && mid + 1 <= r && arr[mid - 1] < arr[mid] && arr[mid] < arr[mid + 1] {
            return peakIndexInMountainArrayHelper(arr, mid + 1, r)
        }
        return peakIndexInMountainArrayHelper(arr, l, mid - 1)
    }
    
    static func peakIndexInMountainArray(_ arr: [Int]) -> Int {
        if arr.isEmpty {
            return -1
        }
        return peakIndexInMountainArrayHelper(arr, 0, arr.count - 1)
    }
}

class ArrayReader {
    public func get(_ index: Int) -> Int {
        return -1
    }
}



class ArrayReaderItemSearch {
    
    static func binarySearchWith(_ reader: ArrayReader, _ low: Int, _ high: Int, _ target: Int) -> Int {
        if low > high {
            return -1
        }
        let mid = (low + high)/2
        if reader.get(mid) == target {
            return mid
        }
        else if reader.get(mid) > target {
            return binarySearchWith(reader, mid + 1, high, target)
        }
        else {
            return binarySearchWith(reader, low, mid - 1, target)
        }
    }
    
    static func search(_ reader: ArrayReader, _ target: Int) -> Int {
        var low = 0
        var high = 1
        if reader.get(low) > target {
            return -1
        }
        while target > reader.get(high) {
            low = high
            high = 2*high
        }
        while low <= high {
            let mid = (low + high)/2
            let val = reader.get(mid)
            if val == target {
                return mid
            }
            else if val < target {
                low = mid + 1
            }
            else {
                high = mid - 1
            }
        }
        return -1
    }
}

class ShuffleSolution {

    private func shuffleList() -> [Int] {
        let length = list.count
        for i in 0..<length {
            let randIndex = Int.random(in: i..<length)
            list.swapAt(i, randIndex)
        }
        return list
    }
    
    private var original: [Int]
    private var list: [Int]
    init(_ nums: [Int]) {
        list = nums
        original = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        list = original
        return list
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        return shuffleList()
    }
}

class MovingAverage {

    /** Initialize your data structure here. */
    private var list = [Int]()
    private var size: Int
    private var sum: Int = 0
    init(_ size: Int) {
        self.size = size
    }
    
    func next(_ val: Int) -> Double {
        if list.count < size {
            list.append(val)
            sum += val
        }
        else {
            let item = list.removeFirst()
            sum -= item
            list.append(val)
            sum += val
        }
        return Double(sum) / Double(list.count)
    }
}


extension Character {
    var isValidAlphabet: Bool {
        if let val = self.unicodeScalars.first, CharacterSet.alphanumerics.contains(val) {
            return true
        }
        return false
    }
}

class MyStack {

    /** Initialize your data structure here. */
    private var queue1 = Queue<Int>()
    private var queue2 = Queue<Int>()
    private var topVal = 0
    init() {
        
    }
    
    /** Push element x onto stack. */
    func push(_ x: Int) {
        queue1.enqueue(val: x)
        if !queue2.isEmpty {
            queue2.dQueue()
        }
        queue2.enqueue(val: x)
        topVal = x
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        let x = queue2.dQueue()
        while queue1.size > 1 {
            queue2.enqueue(val: queue1.dQueue())
        }
        queue1.dQueue()
        let temp = queue2
        queue2 = queue1
        queue1 = temp
        return x
    }
    
    /** Get the top element. */
    func top() -> Int {
        return topVal
    }
    
    /** Returns whether the stack is empty. */
    func empty() -> Bool {
        return queue2.isEmpty
    }
}


class KthLargest {

    private let heap: Heap<Int>
    let kVal: Int
    init(_ k: Int, _ nums: [Int]) {
        heap = Heap<Int>(type: .minHeap)
        kVal = k
        for item in nums {
            add(item)
        }
    }
    
    @discardableResult
    func add(_ val: Int) -> Int {
        if heap.size < kVal {
            heap.insert(element: val)
        }
        else if let x = heap.getRoot(), x < val {
            heap.extract()
            heap.insert(element: val)
        }
        return heap.getRoot() ?? -1
    }
}

class MyQueue {

    private let stack1 = Stack<Int>()
    private let stack2 = Stack<Int>()
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        stack1.push(val: x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        while !stack1.isEmpty {
            stack2.push(val: stack1.pop())
        }
        let val = stack2.pop()
        while !stack2.isEmpty {
            stack1.push(val: stack2.pop())
        }
        return val
    }
    
    /** Get the front element. */
    func peek() -> Int {
        while !stack1.isEmpty {
            stack2.push(val: stack1.pop())
        }
        let val = stack2.top()
        while !stack2.isEmpty {
            stack1.push(val: stack2.pop())
        }
        return val ?? -1
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack1.isEmpty
    }
}

