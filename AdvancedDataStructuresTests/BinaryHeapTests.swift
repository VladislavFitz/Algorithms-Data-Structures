//
//  BinaryHeapTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 20.11.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class BinaryHeapTests: XCTestCase {
    
    func testConstruction() {
        
        let array = Array(0..<200).shuffled()
        
        let binaryHeap = BinaryHeap(array)
        
        XCTAssertTrue(binaryHeap.isCorrect())
        
    }
    
    func testExtraction() {
        
        let array = Array(0..<200).shuffled()
        
        var binaryHeap = BinaryHeap(array)
        
        var extractedValues: [Int] = []
        
        while let extractedValue = binaryHeap.extract() {
            extractedValues.append(extractedValue)
        }
        
        XCTAssertTrue(Array(extractedValues.reversed()).isSorted)
        
    }
    
}
