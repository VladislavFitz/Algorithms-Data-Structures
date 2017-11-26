//
//  HeapSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 26/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class HeapSort<E: Comparable>: SortAlgorithm {
    
    typealias Element = E
    
    let input: [Element]
    var output: [Element] = []
    
    init(input: [Element]) {
        self.input = input
    }
    
    func perform() {
        
        let array = input
        
        if array.isEmpty {
            output = []
            return
        }
        
        var heap = BinaryHeap(array)
        
        var sortedArray: [Element] = []
        
        while let element = heap.extract() {
            sortedArray.append(element)
        }
        
        output = sortedArray.reversed()
        
    }
    
}
