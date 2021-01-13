//
//  ArrayExtension.swift
//  DSA
//
//  Created by Nishit on 17/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation


extension Array where Element == Int {
    
    func swapValues<T>(first : inout T, second : inout T) {
        let temp = first
        first = second
        second = temp
    }
    
    mutating func reverseArray(start : Int, end : Int) {
        var startVal = start
        var endVal = end
        
        while startVal < endVal {
            self.swapAt(startVal, endVal)
            startVal += 1
            endVal -= 1
        }
    }
    
    mutating func arrayRotation(distance : Int) {
        
        let start = 0
        let end = self.count - 1
        let dPos = distance - 1

        self.reverseArray(start: start, end: dPos)
        self.reverseArray(start: dPos + 1, end: end)
    }
    
    func binarySearch(list : [Int], element : Int, start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] == element {
            return mid
        }
        else {
            if element > list[mid] {
                return binarySearch(list: list, element: element, start: mid + 1, end: end)
            }
            else {
                return binarySearch(list: list, element: element, start: start, end: mid - 1)
            }
        }
    }
    
    func findPivot(list : [Int], start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] > list[mid + 1] {
            return mid
        }
        else {
            if list[mid] < list[mid + 1] {
                return findPivot(list: list, start: mid + 1, end: end)
            }
            else if list[mid - 1] < list[mid] {
                return findPivot(list: list, start: start, end: mid - 1)
            }
        }
        
        return -1
    }
    
    func searchElementInSortedRotatedArrayVer1(list : [Int], element : Int) -> Int {
        
        let start = 0
        let end = list.count - 1
        var index = -1
        let pivot = findPivot(list: list, start: start, end: end)
        
        if pivot != -1 || pivot < list.count {
            index = binarySearch(list: list, element: element, start: start, end: pivot)
            if index == -1 {
                index = binarySearch(list: list, element: element, start: pivot + 1, end: end)
            }
        }
        
        return index
    }
    
    func searchElementInSortedRotatedArrayVer2(list : [Int], element : Int, start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] == element {
            return mid
        }
        else {
            if list[start] <= list[mid] {
                if element >= list[start] && element <= list[mid] {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: start, end: mid - 1)
                }
                else {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: mid + 1, end: end)
                }
            }
            else {
                if element >= list[mid] && element <= list[end] {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: mid + 1, end: end)
                }
            }
        }
        
        return -1
    }
    
    //1122 1-122
    // Find duplicate count in an array having elements 0 to n-1
    func findDuplicates(list : inout [Int]) -> Int {
        
        var result = 0
        
        for index in 0..<list.count {
            
            if list[abs(list[index])] > 0 {
                list[index] = -list[index]
            }
            else {
                result += 1
            }
        }
        
        return result
    }
    
    func reverseArray(list : inout [Int]) {
        
        if list.isEmpty {
            return
        }
        
        var start = 0
        var end = list.count - 1
        
        while start < end {
            var first = list[start]
            var second = list[end]
            
            swapValues(first: &first, second: &second)
            
            start += 1
            end -= 1
        }
    }
    
    func allNegativeAtEndAllPositiveAtStart(list : inout [Int]) {
        
        if list.isEmpty {
            return
        }
        
        var start = 0
        var end = list.count - 1
        
        while start < end {
            var first = list[start]
            var second = list[end]
            
            if first < 0 && second > 0 {
                swapValues(first: &first, second: &second)
                start += 1
                end -= 1
            }
            else if first < 0 && second < 0 {
                end -= 1
            }
            else if first > 0 && second > 0 {
                start += 1
            }
            else {
                start += 1
                end -= 1
            }
        }
    }
    
    func countPositiveNegativeNumbers(list : [Int]) -> (pos : Int, neg : Int) {
        
        if list.isEmpty {
            return (0, 0)
        }
        
        var negativeIndex = -1
        for index in 0..<list.count {
            if list[index] < 0 {
                negativeIndex = index
                break
            }
        }
        
        return (negativeIndex, list.count - negativeIndex)
    }
    
    //[-1, 2, -3, 4, 5, 6, -7, 8, 9]
    func placeNegativeAndPositiveAlternatePosition(list : inout [Int]) {
        
        if list.isEmpty {
            return
        }
        
        allNegativeAtEndAllPositiveAtStart(list: &list)
        
        let val = countPositiveNegativeNumbers(list: list)
        
        var firstPos = 1
        var secPos = val.pos
        let end = list.count - 1
        
        while firstPos < secPos && secPos < end {
            var first = list[firstPos]
            var second = list[secPos]
            swapValues(first: &first, second: &second)
            firstPos += 2
            secPos += 1
        }
    }
    
    func swapsInSeparateZeroAndOne(list : [Int]) -> Int {
        var result = 0
        
        if list.isEmpty {
            return result
        }
        
        var start = 0
        var end = list.count - 1
        
        while start < end {
            var first = list[start]
            var second = list[end]
            
            if first == 0 && second == 1 {
                swapValues(first: &first, second: &second)
                result += 1
                start += 1
                end -= 1
            }
            else if first == 0 && second == 0 {
                end -= 1
            }
            else if first == 1 && second == 1 {
                start += 1
            }
            else {
                start += 1
                end -= 1
            }
        }
        
        return result
    }
    
    //arr[] = {2, 1, 5, 6, 3}, k = 3 [1,1,0,0,1]
    //arr[] = {2, 7, 9, 5, 8, 7, 4}, k = 5 [1,0,0,1,0,0,1]
    func minSwapForPlaceElementsTogether(list : [Int], value : Int) -> Int {
        
        var result = 0
        
        var statusList = Array<Int>(repeating: 0, count: list.count)
        
        for index in 0..<list.count {
            let val = list[index]
            if val <= value {
                statusList[index] = 1
            }
        }
        
        result = swapsInSeparateZeroAndOne(list: statusList)
        
        return result
    }
    
    func evenElementsSmallerOddGreater(list : inout [Int]) {
        
        for index in 0..<list.count - 1 {
            var first = list[index]
            var second = list[index + 1]
            
            if index % 2 == 0 && (first > second) {
                swapValues(first: &first, second: &second)
            }
            
            if index % 2 != 0 && (first < second) {
                swapValues(first: &first, second: &second)
            }
        }
    }
    
    func evenElementsPositiveOddNegative(list : inout [Int]) {
        
        for index in 0..<list.count - 1 {
            var first = list[index]
            var second = list[index + 1]
            
            if index % 2 == 0 && (first < 0 && second > 0) {
                swapValues(first: &first, second: &second)
            }
            
            if index % 2 != 0 && (first > 0 && second < 0) {
                swapValues(first: &first, second: &second)
            }
        }
    }
    
    //arr[] = {2, 3, 4, 5, 6}
    func replaceElementByMultiplicationOfPrevAndNext(list : inout [Int]) {
        
        if list.isEmpty {
            return
        }
        
        var prev = 0
        var curr = 0
        
        for index in 0..<list.count - 1 {
            
            curr = list[index]
            
            if index == 0 {
                list[index] = curr * list[index + 1]
            }
            else {
                list[index] = prev * list[index + 1]
            }
            
            prev = curr
        }
        
        list[count - 1] = prev * list[count - 1]
    }
    
    //{-2, -3, 4, -1, -2, 1, 5, -3} : Kadne's Algo
    func maxSumSubArray(list : [Int]) -> Int {
        
        var maxSum = Int.min
        var currentSum = 0
        
        for item in list {
            
            currentSum += item
            if maxSum < currentSum {
                maxSum = currentSum
            }
            
            if currentSum < 0 {
                currentSum = 0
            }
        }
        
        return maxSum
    }
    
    func maxProfitInBuySellStock(list : [Int], maxTransactions : Int) -> Int {
        
        if list.isEmpty {
            return 0
        }
        
        var maxProfit = Int(INT16_MIN)
        var profitList = Array<Int>(repeating: 0, count: maxTransactions)
        
        var buy = list[0]
        var sell = 0
        if list.count == 1 {
            return 0
        }
        else if list.count == 2 {
            sell = list[1]
            if sell > buy {
                return sell - buy
            }
            else {
                return 0
            }
        }
        else {
            
            sell = list[1]
            for index in 2..<list.count {
                if profitList.count == maxTransactions {
                    break
                }
                let val = list[index]
                if val > sell {
                    sell = val
                }
                else {
                    if sell > buy {
                        let profitVal = sell - buy
                        profitList.append(profitVal)
                        buy = val
                    }
                }
            }
            
            var currSum = 0
            
            for profit in profitList {
                currSum += profit
                if currSum > maxProfit {
                    maxProfit = currSum
                }
            }
        }
        
        return maxProfit
    }
    
    func findSubArrayWithAvg(list : [Int], subListCount : Int) -> (start : Int, end : Int, minAvg : Int) {
        var start = -1
        var end = -1

        if list.isEmpty || list.count < subListCount {
            return (start, end, 0)
        }
        
        var currSum = 0
        
        for index in 0..<subListCount {
            currSum += list[index]
        }
        
        var minAvg = currSum/subListCount
        var counter = 1
        var prev = 0
        
        start = 0
        end = (subListCount - 1)
        
        while counter < (list.count - subListCount - 1) {
            prev = list[counter - 1]
            let nextIndex = counter + subListCount - 1
            let sum = currSum - prev + list[nextIndex]
            let avg = sum/subListCount
            if avg < minAvg {
                minAvg = avg
                start = counter
                end = nextIndex
            }
            counter += 1
        }
        
        return (start, end, minAvg)
    }
    
    //{3, 5, 4, 2, 6, 5, 6, 6, 5, 4, 8, 3} -> 3,6
    func findMinDistanceBetweenXY(list : [Int], x : Int, y : Int) -> Int {
        
        if list.isEmpty {
            return 0
        }
        
        var foundX = -1
        var foundY = -1
        var xPos = -1
        var yPos = -1
        var currDist = 0
        var minDist = Int(INT_MAX)
        
        for index in 0..<list.count {
            
            if foundX != -1 && foundY != -1 {
                currDist = abs(xPos - yPos)
                if currDist < minDist {
                    minDist = currDist
                }
            }
            let val = list[index]
            if val == x {
                foundX = val
                xPos = index
            }
            else if val == y {
                foundY = val
                yPos = index
            }
        }

        
        return minDist
    }
    
    func findTriplateFormAPInSortedList(list : [Int]) {
        for index in 0..<list.count - 2 {
            let innerStart = index + 2
            for i in innerStart..<list.count {
                let elementToSearch = (list[index] + list[i])/2
                let searchElement = binarySearch(list: list, element: elementToSearch, start: index, end: i)
                print("first -> \(list[index]) | second -> \(list[searchElement]) | third -> \(list[i])")
            }
        }
    }
    
    func findIndexToJump(start : Int, end : Int, list : [Int]) -> Int {
        
        if start > end {
            return -1
        }
        
        var startVal = start
        var endVal = end
        
        
        while startVal < endVal {
            let val = list[startVal]
            
        }
        
        return -1
    }
    
    func findMinJumpsToReachEnd(start : Int, end : Int, list : [Int]) -> Int {
        
        if list.isEmpty || start > end {
            return 0
        }
        
        let jumps = 0
        
        if list[start] == 0 {
            return jumps
        }
        else if list[start] >= list.count {
            return jumps + 1
        }
        else {
            let startVal = start
            let val = list[startVal]
            if val > list.count - startVal - 1 {
                return jumps + 1
            }
            else {
                return findIndexToJump(start: startVal + 1, end: startVal + val - 1, list: list)
            }
        }
    }
    
    func kMaxSumOfNonOverLappingSubarrays(list : inout [Int], kVal : Int) {
        if list.isEmpty {
            return
        }
        
        for _ in 0..<kVal {
            
            var currentSum = 0
            var maxSum = Int(INT16_MIN)
            var start = 0
            var end = -1
            var tempIndex = 0
            
            for index in 0..<list.count {
                
                currentSum += list[index]
                
                if currentSum > maxSum {
                    maxSum = currentSum
                    start = tempIndex
                    end = index
                }
                
                if currentSum < 0 {
                    currentSum = 0
                    tempIndex = index + 1
                }
            }
            
            print("MaxSum \(maxSum)")

            for startIndex in start...end {
                list[startIndex] = Int(INT16_MIN)
            }
        }
    }
    
    // Not sure
    func minimizeTheDiffOfArrayOfTowers(list : [Int], byValue kVal : Int) -> Int {
        var result = 0
        
        let count = list.count
        let sortedList = list.sorted()
        
        var big = sortedList[count - 1] - kVal
        var small = sortedList[0] + kVal
        
        if small > big {
            swapValues(first: &small, second: &big)
        }
        
        result = big - small
        
        for index in 1..<count-1 {
            let val = sortedList[index]
            let increased = val + kVal
            let decreased = val - kVal
            
            let x = big > increased ? big - increased : increased - big
            let y = small > decreased ? small - decreased : decreased - small
            
            if increased > big {
                big = increased
            }
            
            if decreased > small {
                small = decreased
            }
            
            if x < result {
                result = x
            }
            else if y < result {
                result = y
            }
        }
        
        return result
    }
    
    func getMinLenghtOfSubArraywithSumGreaterThanOrEqual(list : [Int], target : Int) -> Int {
        
        if list.isEmpty {
            return 0
        }
        
        var start = 0
        var end = 0
        var currSum = 0
        let count = list.count
        var minLength = Int(INT_MAX)
        
        while end < count {
            
            while currSum <= target && end < count {
                currSum += list[end]
                end += 1
            }
            
            while currSum > target && start < count {
                
                if end - start < minLength {
                    minLength = end - start
                }
                
                if currSum > target {
                    currSum -= list[start]
                    start += 1
                }
            }
        }
    
        return minLength
    }
    
    func numberOfOperaionsToGetDesiredList(targetList : [Int]) -> Int {
        if targetList.isEmpty {
            return 0
        }
        
        var result = targetList.count
        var min = Int(INT_MAX)
        
        var dividendList = [Int]()
        var remainderList = [Int]()
        
        for item in targetList {
            dividendList.append(item / 2)
            remainderList.append(item % 2)
        }
        
        for item in remainderList {
            if item != 0 {
                result += 1
            }
        }
        
        for val in dividendList {
            if val < min {
                min = val
            }
        }
        
        result += min
        
        for index in 0..<dividendList.count {
            let val = dividendList[index]
            dividendList[index] = val - min
        }
        
        for item in dividendList {
            result += item*2
        }
        
        return result
    }
    
    func numberOfSubsetProductLessThan(list : [Int], value : Int) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var result = 0
        
        for index in 0..<list.count-1 {
            let x = list[index]
            for i in index+1..<list.count {
                if x*list[i] <= value {
                    result += 1
                }
            }
        }
        return result
    }
    
    func sumOfFourElementsEqualToGivenVal(list : [Int], target : Int) {
        
        var sumList = [SumItem]()
        
        for i in 0..<list.count - 1 {
            let val = list[i]
            for j in i + 1..<list.count {
                let item = SumItem()
                item.sum = val + list[j]
                item.first = i
                item.second = j
                sumList.append(item)
            }
        }
        
        sumList.sort()
        
        var left = 0
        var right = sumList.count - 1
        
        while left < right {
            if sumList[left].sum + sumList[right].sum == target {
                print("Elements Found")
            }
            else if sumList[left].sum + sumList[right].sum < target {
                left += 1
            }
            else {
                right += 1
            }
        }
    }
    
    // Max Sum of i.a[i] with all rotaions from 0 to n-1 in clockwise
    func maxSum(list : [Int]) -> Int {
        var maxSum = Int(INT16_MIN)
        
        if list.isEmpty {
            return maxSum
        }
        
        var sum = 0
        var curr = 0
        
        for index in 0..<list.count {
            let val = list[index]
            sum += val
            curr += index*val
        }
        
        for index in 1..<list.count {
            curr = curr - sum + (list.count - index)
            if maxSum < curr {
                maxSum = curr
            }
        }

        return maxSum
    }
    
    func findMaxInWindow(list : [Int], kVal : Int) -> [Int] {
        var result = [Int]()
        
        if list.isEmpty {
            return result
        }
        
        var max = Int(INT16_MIN)
        
        var index = 0
        
        while index < kVal {
            if max < list[index] {
                max = list[index]
                result.append(max)
            }
            index += 1
        }
                
        for index in kVal..<list.count {
            if max < list[index] {
                max = list[index]
            }
            result.append(max)
        }
        
        return result
    }
    
    func kmallestElementsInRowAndColWiseSortedMat(mat : [[Int]], kVal : Int) -> [Int] {
        var result = [Int]()
        
        if mat.isEmpty {
            return result
        }
        
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        
        var temp = [HeapItem]()
        
        for index in 0..<n {
            temp.append(HeapItem(val: mat[0][index], x: 0, y: index))
        }
        
        let heap = Heap<HeapItem>(type: .minHeap, list: temp)
        
        for _ in 0..<kVal {
            if let min = heap.getRoot() {
                result.append(min.val)
                
                if min.row + 1 < m && min.col < n {
                    let nextItem = HeapItem(val: mat[min.row + 1][min.col], x: min.row + 1, y: min.col)
                    heap.decreaseKey(index: 0, newValue: nextItem)
                    heap.heapify(index: 0)
                }
            }
        }
        return result
    }
    
    func findTriplateWithGivenSum(list : [Int], sum : Int) -> Bool {
        if list.isEmpty {
            return false
        }
        var set = Set<Int>()
        for i in 0..<list.count - 2 {
            let currSum = sum - list[i]
            for j in i+1..<list.count {
                if set.contains(currSum - list[j]) {
                    return true
                }
                set.insert(list[j])
            }
        }
        return false
    }
}

class HeapItem {
    let val : Int
    let row : Int
    let col : Int
    init(val : Int, x : Int, y : Int) {
        self.val = val
        row = x
        col = y
    }
}

extension HeapItem : Comparable {
    static func < (lhs: HeapItem, rhs: HeapItem) -> Bool {
        return lhs.val < rhs.val
    }
    
    static func == (lhs: HeapItem, rhs: HeapItem) -> Bool {
        return lhs.val == rhs.val
    }
}

class SumItem {
    
    var sum = 0
    var first = -1
    var second = -1
}

extension SumItem : Comparable {
    
    static func < (lhs: SumItem, rhs: SumItem) -> Bool {
        return lhs.sum < rhs.sum
    }
    
    static func == (lhs: SumItem, rhs: SumItem) -> Bool {
        return lhs.sum == rhs.sum
    }
}


extension ArraySlice where Element == Character {
    func isPalindrome() -> Bool {
        var l = 0
        var r = self.count - 1
        while l < r {
            if self[l] != self[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
    
    func toString(_ start: Int, _ length: Int) -> String {
        let x = self[start...start+length-1]
        return x.reduce("") { (prev, curr) -> String in
            prev + String(curr)
        }
    }
}
