//
//  InsertionSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct InsertionSort<Element: Comparable>: SortAlgorithm {
    
    func sort(_ array: [Element]) -> [Element] {
        
        var array = array
        
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
        
        return array
        
    }
    
}
