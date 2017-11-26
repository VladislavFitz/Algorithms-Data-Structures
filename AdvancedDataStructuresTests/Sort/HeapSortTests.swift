//
//  HeapSortTests.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 26/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class HeapSortTests: XCTestCase {
    
    func testCorrectness() {
        
        var shuffledArray = Array(0..<1000)
        shuffledArray.shuffle()
        
        let sort = HeapSort<Int>(input: shuffledArray)
        sort.perform()
        XCTAssertTrue(sort.output.isSorted)
        
    }
    
}
