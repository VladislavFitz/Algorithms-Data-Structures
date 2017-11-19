//
//  CombSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class CombSort<E: Comparable>: SortAlgorithm {
    
    private let fakt: Double = 1.2473309
    
    typealias Element = E
    
    let input: [Element]
    var output: [Element] = []
    
    init(input: [Element]) {
        self.input = input
    }

    func perform() {

        var mutableArray = input
        
        var isSorted: Bool = false

        var step = mutableArray.count - 1
        
        while !isSorted {
            
            if step == 1 {
                isSorted = true
            }
            
            for index in 0..<mutableArray.endIndex where index + step < input.count {
            
                if mutableArray[index] > mutableArray[index + step]  {
                    mutableArray.swapAt(index, index + step)
                    isSorted = false
                }
                
            }
            
            if step > 1 {
                step = Int((Double(step)/fakt).rounded(.towardZero))
            }
            
        }
        
        output = mutableArray

    }

}
