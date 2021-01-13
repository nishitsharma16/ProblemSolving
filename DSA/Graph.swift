//
//  Graph.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Node<Element : Hashable> {
    let value : Element
    init(x : Element) {
        value = x
    }
}

extension Node : Hashable {
    static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

class Graph<ElementType : Hashable> {
    
    var addjancyList : [Node<ElementType> : [Node<ElementType>]] = [:]
    
    func addEdge(currNode: Node<ElementType>, otherNode: Node<ElementType>) {
        guard var value = addjancyList[currNode] else {
            var list = [Node<ElementType>]()
            list.append(otherNode)
            addjancyList[currNode] = list
            return
        }
        value.append(otherNode)
    }
    
    // BFS means Level Order Traversal
    func bfs(node : Node<ElementType>) {
        
        var map : [Node<ElementType> : Bool] = [:]
        let queue = Queue<Node<ElementType>>()
        map[node] = true
        queue.enqueue(val: node)
        
        while !queue.isEmpty {
            let front = queue.dQueue()
            print("Value : \(front.value)")
            if let list = addjancyList[front] {
                for node in list {
                    if let visited = map[node], visited == true {}
                    else {
                        map[node] = true
                        queue.enqueue(val: node)
                    }
                }
            }
        }
    }
    
    func dfsTraversal(node : Node<ElementType>, visited: inout [Node<ElementType> : Bool]) {
        visited[node] = true
        print("Value : \(node.value)")
        if let list = addjancyList[node] {
            for node in list {
                if let visitedVal = visited[node], visitedVal == true {}
                else {
                    dfsTraversal(node: node, visited: &visited)
                }
            }
        }
    }
    
    // DFS means Traversal like Inorder/Preorder/Postorder or stack traversal
    func dfs(node : Node<ElementType>) {
        var visited : [Node<ElementType> : Bool] = [:]
        for item in addjancyList.keys {
            visited[item] = false
        }
        dfsTraversal(node: node, visited: &visited)
    }
    
    @discardableResult
    func dfsDetectCycleInDirectedGraph(node : Node<ElementType>, visited: inout [Node<ElementType> : Bool], stackRef: inout [Node<ElementType> : Bool]) -> Bool {
        if let visitedVal = visited[node], !visitedVal {
            visited[node] = true
            stackRef[node] = false
            if let list = addjancyList[node] {
                for node in list {
                    if let visitedVal = visited[node], !visitedVal, dfsDetectCycleInDirectedGraph(node: node, visited: &visited, stackRef: &stackRef) {
                        return true
                    }
                    else if let inStack = stackRef[node], inStack == true {
                        return true
                    }
                }
            }
        }
        stackRef[node] = false
        return false
    }
    
    func detectCycleInDirectedGraph(node: Node<ElementType>, visited: inout [Node<ElementType> : Bool]) {
        var visited : [Node<ElementType> : Bool] = [:]
        var stackRef : [Node<ElementType> : Bool] = [:]
        for item in addjancyList.keys {
            visited[item] = false
            stackRef[item] = false
        }
        for item in addjancyList.keys {
            dfsDetectCycleInDirectedGraph(node: item, visited: &visited, stackRef: &stackRef)
        }
    }
    
    @discardableResult
    func dfsDetectCycleInUnDirectedGraph(node : Node<ElementType>, visited: inout [Node<ElementType> : Bool], parent: Node<ElementType>) -> Bool {
        if let visitedVal = visited[node], !visitedVal {
            visited[node] = true
            if let list = addjancyList[node] {
                for item in list {
                    if let visitedVal = visited[node], !visitedVal {
                        if dfsDetectCycleInUnDirectedGraph(node: item, visited: &visited, parent: node) {
                            return true
                        }
                    }
                    else if item != parent {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func detectCycleInUnDirectedGraph(node: Node<ElementType>, visited: inout [Node<ElementType> : Bool], parent: Node<ElementType>) {
        var visited : [Node<ElementType> : Bool] = [:]
        for item in addjancyList.keys {
            visited[item] = false
        }
        for item in addjancyList.keys {
            dfsDetectCycleInUnDirectedGraph(node: item, visited: &visited, parent: parent)
        }
    }
}

class GraphBuilder {
    
    func createGraph() {
        let graph = Graph<Int>()
        let root = Node<Int>(x: 2)
        let one = Node<Int>(x: 1)
        let zero = Node<Int>(x: 0)
        let three = Node<Int>(x: 3)
        graph.addEdge(currNode: root, otherNode: one)
        graph.addEdge(currNode: root, otherNode: three)
        graph.addEdge(currNode: zero, otherNode: one)
        graph.addEdge(currNode: zero, otherNode: root)
        graph.addEdge(currNode: one, otherNode: root)
        graph.addEdge(currNode: three, otherNode: three)
        graph.bfs(node : root)
        graph.dfs(node : root)
    }
}

extension Array {
    
}
