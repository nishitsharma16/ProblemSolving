//
//  BinaryTree.swift
//  DSA
//
//  Created by Nishit on 14/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class BTNode<Item> {
    var left : BTNode<Item>?
    var right : BTNode<Item>?
    var value : Item
    init(val : Item) {
        value = val
    }
}

class BTLevelNode<Item> {
    var left : BTLevelNode<Item>?
    var right : BTLevelNode<Item>?
    var value : Item
    var level = 0
    init(val : Item) {
        value = val
    }
}

class TreeNode: Codable {
    var left : TreeNode?
    var right : TreeNode?
    var value : Int
    init(val : Int) {
        value = val
    }
}

class TreeParentNode: Equatable {
    
    static func == (lhs: TreeParentNode, rhs: TreeParentNode) -> Bool {
        lhs.value == rhs.value
    }
    
    var left : TreeParentNode?
    var right : TreeParentNode?
    var parent : TreeParentNode?
    var value : Int
    init(val : Int) {
        value = val
    }
}

class NextNode {
    var left : NextNode?
    var right : NextNode?
    var next : NextNode?
    var val : Int
    init(val : Int) {
        self.val = val
    }
}


class BinaryTree {
    
    func minMaxHorizontalDistance(root : BTNode<Int>?, min : inout Int, max : inout Int, hd : Int) {
        if let rootVal = root {
            
            if hd < min {
                min = hd
            }
            else if hd > max {
                max = hd
            }
            
            minMaxHorizontalDistance(root: rootVal.left, min: &min, max: &max, hd: hd - 1)
            minMaxHorizontalDistance(root: rootVal.right, min: &min, max: &max, hd: hd + 1)
        }
    }
    
    func printVerticatNodes(root : BTNode<Int>?, line : inout Int, hd: Int) {
        
        if let rootVal = root {
            if line == hd {
                print("val : \(rootVal.value)")
            }
            
            printVerticatNodes(root: rootVal.left, line: &line, hd: hd - 1)
            printVerticatNodes(root: rootVal.right, line: &line, hd: hd + 1)
        }
    }
    
    func printVerticalOrder(root : BTNode<Int>?) {
        
        var min = 0
        var max = 0
        var hd = 0
        
        minMaxHorizontalDistance(root: root, min: &min, max: &max, hd: hd)
        
        while min <= max {
            hd = 0
            printVerticatNodes(root: root, line: &min, hd: hd)
            min += 1
        }
    }
    
    func maxOfParentChildDiff(root : BTNode<Int>?, prevVal : Int, result : inout Int) {
        if let rootVal = root {
            
            if result < (prevVal - rootVal.value) {
                result = (prevVal - rootVal.value)
            }
                            
            maxOfParentChildDiff(root: rootVal.left, prevVal: rootVal.value, result: &result)
            maxOfParentChildDiff(root: rootVal.right, prevVal: rootVal.value, result: &result)
        }
    }
    
    func findLCAInBinaryTree(root : BTNode<Int>?, a : Int, b : Int) -> BTNode<Int>? {
        
        if let rootVal = root {
            if rootVal.value == a || rootVal.value == b {
                return rootVal
            }
            
            let leftRCA = findLCAInBinaryTree(root: rootVal.left, a: a, b: b)
            let rightRCA = findLCAInBinaryTree(root: rootVal.right, a: a, b: b)
            
            if let _ = leftRCA , let _ = rightRCA {
                return rootVal
            }
            else if let _ = leftRCA {
                return leftRCA
            }
            else {
                return rightRCA
            }
        }
        else {
            return root
        }
    }
    
    func distanceFromRoot(root : BTNode<Int>?, x : Int, distance : Int, result : inout Int) {
        if let rootVal = root {
            if rootVal.value == x {
                result = distance + 1
                return
            }
            distanceFromRoot(root: rootVal.left, x: x, distance: distance + 1, result: &result)
            distanceFromRoot(root: rootVal.right, x: x, distance: distance + 1, result: &result)
        }
    }
    
    func findDistanceBetweenTwoNodes(root : BTNode<Int>?, a : Int, b : Int, result : inout Int) {
        
        if let lca = findLCAInBinaryTree(root: root, a: a, b: b) {
            var dist3 = 0
            distanceFromRoot(root: root, x: lca.value, distance: 0, result: &dist3)
            
            var dist1 = 0
            distanceFromRoot(root: root, x: a, distance: 0, result: &dist1)
            
            var dist2 = 0
            distanceFromRoot(root: root, x: b, distance: 0, result: &dist2)
            
            result = dist1 + dist2 - 2*dist3
        }
    }
    
    func iterativeInorder(root : BTNode<Int>?) {
        let stack = Stack<BTNode<Int>>()
        var curr = root
        
        while curr != nil || !stack.isEmpty {
            
            while curr != nil {
                if let currVal = curr {
                    stack.push(val: currVal)
                }
                curr = curr?.left
            }
            
            if let top = stack.top() {
                print(top.value)
                stack.pop()
                curr = top.right
            }
        }
    }
    
    func iterativePostorder(root : BTNode<Int>?) {
        let stack = Stack<BTNode<Int>>()
        var curr = root
        
        while curr != nil || !stack.isEmpty {
            
            while curr != nil {
                if let currVal = curr {
                    stack.push(val: currVal)
                }
                curr = curr?.left
            }
            
            if let top = stack.top() {
                curr = top.right
                stack.pop()
                print(top.value)
            }
        }
    }
    
    func iterativePreorder(root : BTNode<Int>?) {
        let stack = Stack<BTNode<Int>>()
        var curr = root
        
        while curr != nil || !stack.isEmpty {
            
            if let currVal = curr {
                print(currVal.value)
            }
            
            while curr != nil {
                if let currVal = curr {
                    stack.push(val: currVal)
                }
                curr = curr?.left
            }
            
            let top = stack.pop()
            curr = top.right
        }
    }
    
    func numberOfNodesAtGivenLevel(root : BTLevelNode<Int>?, level : Int) -> [BTLevelNode<Int>]? {
        if let rootVal = root {
            var levelNodeList = [BTLevelNode<Int>]()
            let queue = Queue<BTLevelNode<Int>>()
            queue.enqueue(val: rootVal)
            let l = 1
            rootVal.level = l
            while !queue.isEmpty {
                
                let val = queue.dQueue()
                if val.level == level {
                    levelNodeList.append(val)
                }
                
                if let left = val.left {
                    left.level = val.level + 1
                    queue.enqueue(val: left)
                }
                
                if let right = val.right {
                    right.level = val.level + 1
                    queue.enqueue(val: right)
                }
            }
            return levelNodeList
        }
        return nil
    }
    
    private static func createBinaryTreeHelper(root: TreeNode?, value: Int) -> TreeNode? {
        if root == nil {
            return TreeNode(val: value)
        }
        
        root?.left = createBinaryTreeHelper(root: root?.left, value: value)
        root?.right = createBinaryTreeHelper(root: root?.right, value: value)
        return root
    }
    
    static func createBinaryTree(nodes: [Int]) -> TreeNode? {
        if nodes.isEmpty {
            return nil
        }
        var root: TreeNode?
        for item in nodes {
            root = createBinaryTreeHelper(root: root, value: item)
        }
        return root
    }
}
