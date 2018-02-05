//
//  DSU.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 09.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

enum UnionFindError<Element: Hashable>: Error {
    case unexpectedElement(Element)
}

struct UnionFind<Element: Hashable> {
    
    private var elementsIndexes: [Element: Int] = [:]
    private var parent: [Int] = []
    
    init(sets: [[Element]] = []) {
        for set in sets {
            addSet(with: set, united: true)
        }
    }
    
    init(set: [Element], united: Bool = false) {
        addSet(with: set, united: united)
    }
    
    mutating func addSet(with element: Element) {
        let elementIndex = parent.count
        elementsIndexes[element] = elementIndex
        parent.append(elementIndex)
    }
    
    mutating func addSet(with elements: [Element], united: Bool = false) {
        if united {
            
            guard let firstElement = elements.first else { return }
            
            addSet(with: firstElement)
            
            for element in elements.dropFirst() {
                addSet(with: element)
                unite(element, with: firstElement)
            }
            
        } else {
            elements.forEach { addSet(with: $0) }
        }
    }
    
    private mutating func findParentIndex(ofElementWithIndex elementIndex: Int) -> Int? {
        
        let parentIndex = parent[elementIndex]
        
        if parentIndex == elementIndex {
            
            return elementIndex
            
        } else {
            
            if let parentOfParentIndex = findParentIndex(ofElementWithIndex: parentIndex) {
                
                parent[elementIndex] = parentOfParentIndex
                return parentOfParentIndex

            } else {
                return .none
            }
            
        }
        
    }
    
    private mutating func setID(of element: Element) -> Int? {
        
        guard let elementIndex = elementsIndexes[element] else { return .none }
        guard let parentIndex = findParentIndex(ofElementWithIndex: elementIndex) else { return .none }
        
        return parentIndex
        
    }
    
    private mutating func unite(_ lElementIndex: Int, _ rElementIndex: Int) {
        
        guard let lElementParentIndex = findParentIndex(ofElementWithIndex: lElementIndex) else { return }
        guard let rElementParentIndex = findParentIndex(ofElementWithIndex: rElementIndex) else { return }
        
        if arc4random() % 2 == 0 {
            parent[lElementParentIndex] = rElementParentIndex
        } else {
            parent[rElementParentIndex] = lElementParentIndex
        }
        
    }
    
    public mutating func unite(_ lElement: Element, with rElement: Element) {
        
        guard let lElementIndex = elementsIndexes[lElement] else { return }
        guard let rElementIndex = elementsIndexes[rElement] else { return }
        
        unite(lElementIndex, rElementIndex)
        
    }
    
    public mutating func areInSameSet(_ lElement: Element, _ rElement: Element) -> Bool {
        
        guard let lElementParentIndex = setID(of: lElement) else { return false }
        guard let rElementParentIndex = setID(of: rElement) else { return false }

        return lElementParentIndex == rElementParentIndex
        
    }
    
    public func contains(_ element: Element) -> Bool {
        return elementsIndexes[element] != nil
    }
    
    var count: Int {
        return elementsIndexes.count
    }
    
    var setCount: Int {
        return parent.enumerated().filter({ $0 == $1 }).count
    }
    
}

extension UnionFind: CustomDebugStringConvertible {
    
    var debugDescription: String {
        
        var copy = self
        
        let values = copy.elementsIndexes.map { (arg) -> (Element, Int) in
            let (element, index) = arg
            return (element, copy.findParentIndex(ofElementWithIndex: index)!)
        }.reduce(into: Dictionary<Int, [Element]>()) { (res, arg) in
            let (element, index) = arg
            if var arr = res[index] {
                arr.append(element)
                res[index] = arr
            } else {
                res[index] = [element]
            }
        }.map({ $0.value })
        
        return "\(values)"
    }
    
}
