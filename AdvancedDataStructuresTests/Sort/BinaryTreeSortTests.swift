//
//  BinaryTreeSortTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class BinaryTreeSortTests: XCTestCase {
    
    func testCorrectness() {
        
        var shuffledArray = Array(0..<1000)
        shuffledArray.shuffle()
        
        let sortedArray = BinaryTreeSort<Int>().sort(shuffledArray)
        
        XCTAssertTrue(sortedArray.isSorted)
        
    }
    
}
