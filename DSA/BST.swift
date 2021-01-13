//
//  BST.swift
//  DSA
//
//  Created by Nishit on 11/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class BSTNode<Item> {
    var left : BSTNode<Item>?
    var right : BSTNode<Item>?
    var value : Item
    init(val : Item) {
        value = val
    }
}

class BST {
    
    func inOrder(root : BSTNode<Int>?) {
        if let rootVal = root {
            inOrder(root: rootVal.left)
            print("Val : \(rootVal.value)")
            inOrder(root: rootVal.right)
        }
    }
    
    func preOrder(root : BSTNode<Int>?) {
        if let rootVal = root {
            print("Val : \(rootVal.value)")
            inOrder(root: rootVal.left)
            inOrder(root: rootVal.right)
        }
    }
    
    func postOrder(root : BSTNode<Int>?) {
        if let rootVal = root {
            inOrder(root: rootVal.left)
            inOrder(root: rootVal.right)
            print("Val : \(rootVal.value)")
        }
    }
}

extension BST {
    
    func createMaxSumTreeSet1(root : BSTNode<Int>?, sum : inout Int) {
        if let rootVal = root {
            createMaxSumTreeSet1(root: rootVal.right, sum: &sum)
            sum = sum + rootVal.value
            rootVal.value = sum - rootVal.value
            createMaxSumTreeSet1(root: rootVal.left, sum: &sum)
        }
    }
    
    func createBSTFromPreorder(preOrder : [Int]) -> BSTNode<Int>? {
        if preOrder.isEmpty {
            return nil
        }
        
        let root = BSTNode<Int>(val: preOrder[0])
        let stack = Stack<BSTNode<Int>>()
        stack.push(val: root)
        
        var temp : BSTNode<Int>?
        
        for index in 1..<preOrder.count {
            
            let currentNode = BSTNode<Int>(val : preOrder[index])
            
            if let topVal = stack.top() {
                while !stack.isEmpty && topVal.value < currentNode.value {
                    temp = stack.pop()
                }
                
                if let tempVal = temp {
                    tempVal.right = currentNode
                }
                else {
                    if let topVal = stack.top() {
                        if topVal.value > currentNode.value {
                            topVal.left = currentNode
                        }
                        else {
                            topVal.right = currentNode
                        }
                    }
                }
                stack.push(val: currentNode)
            }
        }
        
        return root
    }
    
    func storeInorder(root : inout BSTNode<Int>?, output : inout [Int]) {
        if let rootVal = root {
            storeInorder(root: &rootVal.left, output: &output)
            output.append(rootVal.value)
            storeInorder(root: &rootVal.right, output: &output)
        }
    }
    
    func putInOrderValues(root : inout BSTNode<Int>?, output : inout [Int], index : inout Int) {
        if let rootVal = root {
            putInOrderValues(root: &rootVal.left, output: &output, index: &index)
            rootVal.value = output[index]
            index += 1
            putInOrderValues(root: &rootVal.right, output: &output, index: &index)
        }
    }
    
    func convertBinaryTreeToBST(root : inout BSTNode<Int>?) {
        
        var inorderValList = [Int]()
        storeInorder(root: &root, output: &inorderValList)
        
        inorderValList = inorderValList.sorted()
        
        var index = 0
        putInOrderValues(root: &root, output: &inorderValList, index: &index)
    }
    
    func delete(root: BSTNode<Int>?, key: Int) -> BSTNode<Int>? {
        if root == nil {
            return root
        }
        
        // Go let or right to search
        if let x = root?.value, x < key {
            root?.left = delete(root: root?.left, key: key)
        }
        else if let x = root?.value, x > key {
            root?.right = delete(root: root?.right, key: key)
        }
        else {
            // Root Found
            var temp: BSTNode<Int>?
            if root?.left == nil {
                temp = root?.right
                root?.value = temp?.value ?? 0
                temp = nil
            }
            else if root?.right == nil {
                temp = root?.left
                root?.value = temp?.value ?? 0
                temp = nil
            }
            
            let succParent: BSTNode<Int>? = root
            var succ: BSTNode<Int>? = root?.right
            
            while succ?.left != nil {
                succ = succ?.left
            }
            
            if succParent === root {
                succParent?.right = succ?.right
            }
            else {
                succParent?.left = succ?.right
            }
            
            succ = nil
        }
        return root
    }
    
    func levelOrderOfTree(root: BSTNode<Int>?) -> [Int] {
        if let rootVal = root {
            var result = [Int]()
            let queue = Queue<BSTNode<Int>>()
            queue.enqueue(val: rootVal)
            result.append(rootVal.value)
            
            while !queue.isEmpty {
                let front = queue.dQueue()
                if let left = front.left {
                    queue.enqueue(val: left)
                    result.append(left.value)
                }
                if let right = front.right {
                    queue.enqueue(val: right)
                    result.append(right.value)
                }
            }
            
            return result
        }
        return []
    }
    
    func heightOfBinayTree(_ root: BSTNode<Int>?) -> Int {
        if let rootVal = root {
            let leftHeight = heightOfBinayTree(rootVal.left)
            let rightheight = heightOfBinayTree(rootVal.right)
            return 1 + max(leftHeight, rightheight)
        }
        return 0
    }
    
    func getNodeValuesLevelWise(_ root: BSTNode<Int>?, level: Int, result: inout [[Int]]) {
        if let rootVal = root {
            var list = result[level]
            list.append(rootVal.value)
            result[level] = list
            getNodeValuesLevelWise(rootVal.left, level: level + 1, result: &result)
            getNodeValuesLevelWise(rootVal.right, level: level + 1, result: &result)
        }
    }
    
    func levelOrder(_ root: BSTNode<Int>?) -> [[Int]] {
        let height = heightOfBinayTree(root)
        var result = Array(repeating: Array<Int>(), count: height)
        getNodeValuesLevelWise(root, level: 0, result: &result)
        return result
    }
    
    func constructBSTFromLevelOrderHelper(root: inout BSTNode<Int>?, data: Int) -> BSTNode<Int>? {
        if root == nil {
            root = BSTNode<Int>(val: data)
            return root
        }
        
        if let x = root?.value, data < x {
            var left = root?.left
            root?.left = constructBSTFromLevelOrderHelper(root: &left, data: data)
        }
        else {
            var right = root?.right
            root?.right = constructBSTFromLevelOrderHelper(root: &right, data: data)
        }
        
        return root
    }
    
    func constructBSTFromLevelOrder(levelOrder: [Int]) -> BSTNode<Int>? {
        if levelOrder.isEmpty {
            return nil
        }
        
        var root: BSTNode<Int>?
        for item in levelOrder {
            root = constructBSTFromLevelOrderHelper(root: &root, data: item)
        }
        
        return root
    }
    
    //Pending
    func reverseThePathInBSTHelper(root: BSTNode<Int>?, key: Int, map: inout [Int: Int], level: Int, index: inout Int) -> BSTNode<Int>? {
        if root != nil {
            if let val = root?.value {
                map[level] = val
                if val == key {
                    if let savedVal = map[index] {
                        root?.value = savedVal
                    }
                    index += 1
                    return root
                }
                else if key < val {
                    root?.left = reverseThePathInBSTHelper(root: root?.left, key: key, map: &map, level: level + 1, index: &index)
                }
                else {
                    root?.right = reverseThePathInBSTHelper(root: root?.right, key: key, map: &map, level: level + 1, index: &index)
                }
            }
            if root?.left != nil || root?.right != nil {
                if let savedVal = map[index] {
                    root?.value = savedVal
                }
                index += 1
                return root?.left != nil ? root?.left : root?.right
            }
        }
        return nil
    }
    
    func reverseThePathInBST(root: BSTNode<Int>?, key: Int) -> BSTNode<Int>? {
        var map = [Int: Int]()
        var index = 0
        let result = reverseThePathInBSTHelper(root: root, key: key, map: &map, level: 0, index: &index)
        return result
    }
    
    func createBalancedBSTFromSortedArrayHelper(list: [Int], start: Int, end: Int) -> BSTNode<Int>? {
        if start > end {
            return nil
        }
        
        let mid = (start + end)/2
        let root = BSTNode<Int>(val: list[mid])
        
        root.left = createBalancedBSTFromSortedArrayHelper(list: list, start: start, end: mid - 1)
        root.right = createBalancedBSTFromSortedArrayHelper(list: list, start: mid + 1, end: end)
        
        return root
    }
    
    func createBalancedBSTFromSortedArray(list: [Int]) -> BSTNode<Int>? {
        let result = createBalancedBSTFromSortedArrayHelper(list: list, start: 0, end: list.count - 1)
        return result
    }
    
}

extension BSTNode: Equatable where Item : Equatable {
    static func == (lhs: BSTNode<Item>, rhs: BSTNode<Item>) -> Bool {
        return lhs.value == rhs.value
    }
}
