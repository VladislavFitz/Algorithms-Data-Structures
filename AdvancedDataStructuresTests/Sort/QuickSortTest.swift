//
//  QuickSortTest.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 02.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class QuickSortTests: XCTestCase {
    
    func testCorrectness() {
        
        var shuffledArray = Array(0..<1000)
        shuffledArray.shuffle()
        
        let quickSort = QuickSort<Int>(input: shuffledArray, getPivot: { array in
            let indexes = Array(array.startIndex..<array.endIndex)
            let pivotIndex = indexes[indexes.count/2]
            return array[pivotIndex]
        })
        
        quickSort.perform()
        
        XCTAssertTrue(quickSort.output.isSorted)
        
    }
    
}
