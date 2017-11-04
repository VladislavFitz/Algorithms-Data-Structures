//
//  BubbleSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 26.10.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BubbleSort<Element: Comparable>: SortAlgorithm {
    
    func sort(_ array: [Element]) -> [Element] {
        
        var array = array
        
        var sorted: Bool = false
        
        while !sorted {
            
            sorted = true
            
            for index in 0..<array.endIndex-1 {
                
                if array[index] > array[index+1]  {
                    array.swapAt(index, index+1)
                    sorted = false
                }
                
            }
        }
        
        return array

    }

}
