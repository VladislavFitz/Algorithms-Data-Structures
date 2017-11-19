//
//  ShellSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class ShellSort<E: Comparable>: SortAlgorithm {
    
    typealias Element = E
    
    let n: Int

    let input: [Element]
    var output: [Element] = []
    
    init(input: [Element], n: Int) {
        self.n = n
        self.input = input
    }
    
    func perform() {

        var mutableArray = input
        
        var step = n
    
        while step != 0 {
            
            for lastUnsortedIndex in stride(from: mutableArray.startIndex, to: mutableArray.endIndex, by: step) {
                
                var insertedIndex = lastUnsortedIndex
                
                for sortedIndex in stride(from: mutableArray.startIndex, to: lastUnsortedIndex, by: step).reversed() {
                    
                    if mutableArray[sortedIndex] > mutableArray[insertedIndex] {
                        mutableArray.swapAt(sortedIndex, insertedIndex)
                        insertedIndex = sortedIndex
                    } else {
                        break
                    }
                    
                }
                
            }
            
            step = step - 1

        }
        
        
        output = mutableArray

    }
    
}
