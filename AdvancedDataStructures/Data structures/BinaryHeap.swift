//
//  BinaryHeap.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 20.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryHeap<Element: Comparable> {
    
    private var elements: [Element] = []
    
    init<S: Sequence>(_ sequence: S) where S.Element == Element {
        
        for element in sequence {
            add(element)
        }
        
        
        
//        for element in (0...(elements.count/2)).reversed() {
//            heapify(fromElementAtIndex: element)
//        }

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
    
    private mutating func heapify(fromElementAtIndex elementIndex: Int) {
        
        var elementIndex = elementIndex
        var largestChildIndex = elementIndex
        
        while true {
            
            let currentElement = elements[largestChildIndex]
            
            if let leftChild = leftChildForElement(atIndex: largestChildIndex), leftChild > currentElement {
                largestChildIndex = 2 * elementIndex + 1
            }
            
            if let rightChild = rightChildForElement(atIndex: largestChildIndex), rightChild > currentElement {
                largestChildIndex = 2 * elementIndex + 2
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
    
    func leftChildForElement(atIndex index: Int) -> Element? {
        
        let leftElementIndex = 2 * index + 1
        
        if leftElementIndex < count {
            return elements[leftElementIndex]
        } else {
            return .none
        }
        
    }
    
    func rightChildForElement(atIndex index: Int) -> Element? {
        
        let rightElementIndex = 2 * index + 2
        
        if rightElementIndex < count {
            return elements[rightElementIndex]
        } else {
            return .none
        }
        
    }
    
}
