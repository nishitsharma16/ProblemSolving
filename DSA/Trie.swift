//
//  Trie.swift
//  DSA
//
//  Created by Nishit on 24/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

enum TrieNodeType : Int {
    case standard = 26
    case binary = 2
}

class TrieNode {
    var list : Array<TrieNode?>
    var isEndOfWord = false
    init(numberOfNodes : Int) {
        list = Array<TrieNode?>(repeating: nil, count:numberOfNodes)
    }
}

class Trie {
    
    func getNode(nodeType : TrieNodeType) -> TrieNode {
        return TrieNode(numberOfNodes: nodeType.rawValue)
    }
    
    func insert(root : inout TrieNode?, key : String, nodeType : TrieNodeType) {
        for index in 0..<key.count {
            let charIndex = key.getCharIndex(offset: index)
            if root?.list[charIndex] == nil {
                root?.list[charIndex] = getNode(nodeType: nodeType)
            }
            root = root?.list[charIndex]
        }
        root?.isEndOfWord = true
    }
    
    func search(root : inout TrieNode?, key : String) -> Bool {
        for index in 0..<key.count {
            let charIndex = key.getCharIndex(offset: index)
            if root?.list[charIndex] == nil {
                return false
            }
            root = root?.list[charIndex]
        }
        if let val = root {
            return val.isEndOfWord
        }
        else {
            return false
        }
    }
    
    func insertFromBinaryMatrix(mat : [[Int]], root : inout TrieNode?, columns : Int, rowIndex : inout Int) {
        
    }
}


