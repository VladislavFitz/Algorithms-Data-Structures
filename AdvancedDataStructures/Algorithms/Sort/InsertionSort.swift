//
//  InsertionSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class InsertionSort<E: Comparable>: SortAlgorithm {
    
    typealias Element = E
    
    let input: [Element]
    var output: [Element] = []
    
    init(input: [Element]) {
        self.input = input
    }
    
    func perform() {

        var array = input
        
        for lastUnsortedIndex in 0..<array.endIndex {
            
            var insertedIndex = lastUnsortedIndex
            
            for sortedIndex in (array.startIndex..<lastUnsortedIndex).reversed() {
                
                if array[sortedIndex] > array[insertedIndex] {
                    array.swapAt(sortedIndex, insertedIndex)
                    insertedIndex = sortedIndex
                } else {
                    break
                }
                
            }
            
        }
        
        output = array
        
    }
    
}
