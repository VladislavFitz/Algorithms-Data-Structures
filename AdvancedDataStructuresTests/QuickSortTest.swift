//
//  QuickSortTest.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import AdvancedDataStructures
import XCTest

class QuickSortTests: XCTestCase {
    
    func testCorrectness() {
        
        var shuffledArray = Array(0..<1000)
        shuffledArray.shuffle()
        
        let quickSort = QuickSort<Int>(getPivot: { array in
            let indexes = Array(array.startIndex..<array.endIndex)
            let pivotIndex = indexes[indexes.count/2]
            return array[pivotIndex]
        })
        
        let sortedArray = quickSort.sort(shuffledArray)
        
        XCTAssertTrue(sortedArray.isSorted)
        
    }
    
}
