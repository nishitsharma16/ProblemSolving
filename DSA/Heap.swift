//
//  Heap.swift
//  DSA
//
//  Created by Nishit on 06/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

// Root of Heap would be on (i-1)/2, Left at (2i+1) and Right at (2i+2) for a given i

enum HeapType {
    case minHeap
    case maxHeap
}

class Heap<Element : Comparable> {
    
    var list = [Element]()
    let heapType : HeapType
    
    
    init(type : HeapType, list : [Element]) {
        heapType = type
        self.list = list
        buildheap()
    }
    
    init(type : HeapType) {
        heapType = type
    }
    
    func swap(first : Int, second : Int) {
        
        if first < list.count && second < list.count {
            let temp = list[first]
            list[first] = list[second]
            list[second] = temp
        }
    }
    
    func maxHeapify(index : Int) {
        
        if index >= list.count / 2 {
            return
        }
        
        let left = 2*index + 1
        let right = 2*index + 2
        
        var largest = index
        
        if left < list.count && list[left] > list[largest] {
            largest = left
        }
        
        if right < list.count && list[right] > list[largest] {
            largest = right
        }
        
        if largest != index {
            swap(first: largest, second: index)
            maxHeapify(index: largest)
        }
    }
    
    func minHeapify(index : Int) {
        
        if index >= list.count / 2 {
            return
        }
        
        let left = 2*index + 1
        let right = 2*index + 2
        
        var smallest = index
        
        if left < list.count && list[left] < list[smallest] {
            smallest = left
        }
        
        if right < list.count && list[right] < list[smallest] {
            smallest = right
        }
        
        if smallest != index {
            swap(first: smallest, second: index)
            minHeapify(index: smallest)
        }
    }
    
    func heapify(index : Int) {
        
        switch heapType {
        case .minHeap:
             minHeapify(index: index)
        case .maxHeap:
            maxHeapify(index: index)
        }
    }
    
    func convertToHeap() {
        if !list.isEmpty {
            heapify(index: 0)
        }
    }
    
    func buildheap() {
        var count = list.count/2 - 1
        while count >= 0 {
            heapify(index: count)
            count -= 1
        }
    }
    
    func insert(element : Element) {
        list.append(element)
        buildheap()
    }
    
    @discardableResult
    func getRoot() -> Element? {
        if !list.isEmpty {
            return list[0]
        }
        return nil
    }
    
    @discardableResult
    func extract() -> Element? {
        
        if let element = getRoot() {
            swap(first: 0, second: (list.count - 1))
            list.removeLast()
            convertToHeap()
            return element
        }
        return nil
    }
    
    func parent(index : Int) -> Int {
        return (index - 1)/2
    }
    
    func decreaseKey(index : Int, newValue : Element) {
        
        var i = index
        list[i] = newValue
        while i != 0 && list[parent(index: i)] > list[i] {
            swap(first: i, second: parent(index: i))
            i = parent(index: i)
        }
    }
    
    func delete(index : Int, newElement : Element) -> Bool {
        decreaseKey(index: index, newValue: newElement)
        if let _ = extract() {
            return true
        }
        return false
    }
    
    var isEmpty : Bool {
        return list.isEmpty
    }
    
    var size: Int {
        return list.count
    }
}
