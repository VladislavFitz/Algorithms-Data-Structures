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
        
        let array = Array(0..<100).shuffled()
        
        let binaryHeap = BinaryHeap(array)
        
        XCTAssertTrue(binaryHeap.isCorrect())
        
    }
    
}
