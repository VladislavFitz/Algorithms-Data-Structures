//
//  BinaryHeap.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 20.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryHeap<Element: Comparable> {
    
    fileprivate var elements: [Element] = []
    
    private init(_ elements: [Element] = []) {
        self.elements = elements
    }
    
    init<S: Sequence>(_ sequence: S) where S.Element == Element {
        
        for element in sequence {
            add(element)
        }
        
        
        for element in (0...(elements.count/2)).reversed() {
            heapify(fromElementAtIndex: element)
        }

    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    func subHeapFromIndex(_ index: Int) -> BinaryHeap? {
        
        guard index < elements.count else { return nil }
        
        var subHeapIndexes: Set<Int> = []
        
        var indexesToAddQueue: [Int] = [index]
        
        while let indexToAdd = indexesToAddQueue.first {
            
            subHeapIndexes.insert(indexToAdd)
            
            let li = leftIndex(forElementAtIndex: indexToAdd)
            if li < elements.count {
                indexesToAddQueue.append(li)
            }
            
            let ri = rightIndex(forElementAtIndex: indexToAdd)
            if ri < elements.count {
                indexesToAddQueue.append(ri)
            }
            
            indexesToAddQueue = Array(indexesToAddQueue.dropFirst())
            
        }
        
        let subHeapElements = elements.enumerated().filter({ subHeapIndexes.contains($0.offset) }).map({ $0.element })
        
        return BinaryHeap(subHeapElements)
    }
    
    var left: BinaryHeap? {
        return subHeapFromIndex(leftIndex(forElementAtIndex: 0))
    }
    
    var right: BinaryHeap? {
        return subHeapFromIndex(rightIndex(forElementAtIndex: 0))
    }
    
    mutating func add(_ element: Element) {
        
        elements.append(element)
        
        var elementIndex = elements.endIndex - 1
        var parentIndex = (elementIndex - 1) / 2
        
        while elementIndex > 0 && elements[parentIndex] < elements[elementIndex] {
            elements.swapAt(elementIndex, parentIndex)
            elementIndex = parentIndex
            parentIndex = (elementIndex - 1) / 2
        }
        
    }
    
    mutating func remove(_ element: Element) {
        
    }
    
    mutating func extract() -> Element? {
        guard let rootElement = elements.first else { return .none }
        
        elements[0] = elements[elements.endIndex-1]
        elements.remove(at: elements.endIndex-1)
        
        heapify(fromElementAtIndex: 0)
        
        return rootElement
    }
    
    private mutating func heapify(fromElementAtIndex elementIndex: Int) {
        
        guard !elements.isEmpty else { return }
        
        var elementIndex = elementIndex
        var largestChildIndex = elementIndex
        
        while true {
            
            if let leftChild = leftChildForElement(atIndex: elementIndex), leftChild > elements[largestChildIndex] {
                largestChildIndex = leftIndex(forElementAtIndex: elementIndex)
            }
            
            if let rightChild = rightChildForElement(atIndex: elementIndex), rightChild > elements[largestChildIndex] {
                largestChildIndex = rightIndex(forElementAtIndex: elementIndex)
            }
            
            if largestChildIndex == elementIndex {
                break
            }
            
            elements.swapAt(elementIndex, largestChildIndex)
            elementIndex = largestChildIndex
            
        }
        
    }
    
    func isCorrect() -> Bool {
        
        for elementIndex in 0..<elements.endIndex {
            
            let currentElement = elements[elementIndex]
            
            if let leftChild = leftChildForElement(atIndex: elementIndex), leftChild > currentElement {
                return false
            }
            
            if let rightChild = rightChildForElement(atIndex: elementIndex), rightChild > currentElement {
                return false
            }
            
        }
        
        return true
        
    }
    
    var count: Int {
        return elements.count
    }
    
    fileprivate func leftIndex(forElementAtIndex index: Int) -> Int {
        return 2 * index + 1
    }
    
    fileprivate func rightIndex(forElementAtIndex index: Int) -> Int {
        return 2 * index + 2
    }

    
    func leftChildForElement(atIndex index: Int) -> Element? {
        
        let leftElementIndex = leftIndex(forElementAtIndex: index)
        
        if leftElementIndex < count {
            return elements[leftElementIndex]
        } else {
            return .none
        }
        
    }
    
    func rightChildForElement(atIndex index: Int) -> Element? {
        
        let rightElementIndex = rightIndex(forElementAtIndex: index)
        
        if rightElementIndex < count {
            return elements[rightElementIndex]
        } else {
            return .none
        }
        
    }
    
    var nodeDescription: String {
        return elements.first.flatMap({ "\($0)" }) ?? "nil"
    }
    
    var internalDescription: String {
        return "\(elements)"
    }
    
}

extension BinaryHeap: CustomStringConvertible {
    
    var description: String {
        return BinaryTreePrinter.treeString(self, using: { (heap) in
            return ("\(heap.nodeDescription)", heap.left, heap.right)
        })
    }
    
}
