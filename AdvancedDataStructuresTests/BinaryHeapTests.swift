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
    
    func testMinConstruction() {
        
        let array = Array(0..<200).shuffled()
        
        let binaryHeap = BinaryHeap(array, type: .min)
        
        XCTAssertTrue(binaryHeap.isCorrect())
        
    }
    
    func testExtraction() {
        
        let array = Array(0..<200).shuffled()
        
        var binaryHeap = BinaryHeap(array)
        
        var extractedValues: [Int] = []
        
        while let extractedValue = binaryHeap.pop() {
            extractedValues.append(extractedValue)
        }
        
        XCTAssertTrue(Array(extractedValues.reversed()).isSorted)
        
    }

    func testMinExtraction() {
        
        let array = Array(0..<200).shuffled()
        
        var binaryHeap = BinaryHeap(array, type: .min)
        
        var extractedValues: [Int] = []
        
        while let extractedValue = binaryHeap.pop() {
            extractedValues.append(extractedValue)
        }
        
        XCTAssertTrue(extractedValues.isSorted)
    }
    
    func testRemove() {
        
        let array = Array(0..<10).shuffled()

        var binaryHeap = BinaryHeap(array)

        while !binaryHeap.isEmpty {
            let index = Int(arc4random()) % binaryHeap.count
            let elementToRemove = binaryHeap.elements[index]
            binaryHeap.remove(elementToRemove)
            XCTAssertTrue(binaryHeap.isCorrect())
        }
        
    }
    
}
