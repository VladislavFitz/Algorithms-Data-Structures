//
//  SearchInsertPositionTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 19/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class SearchInsertPositionTests: XCTestCase {

    func testExisting() {
        let sip = SearchInsertPosition(input: (nums: [1,3,5,6], target: 5))
        sip.perform()
        XCTAssertEqual(sip.output, 2)
    }
    
    func testNonExisting() {
        let sip = SearchInsertPosition(input: (nums: [1,3,5,6], target: 2))
        sip.perform()
        XCTAssertEqual(sip.output, 1)
    }
    
    func testLessThanFirst() {
        let sip = SearchInsertPosition(input: (nums: [1,3,5,6], target: 0))
        sip.perform()
        XCTAssertEqual(sip.output, 0)
    }
    
    func testBiggerThanLast() {
        let sip = SearchInsertPosition(input: (nums: [1,3,5,6], target: 7))
        sip.perform()
        XCTAssertEqual(sip.output, 4)
    }
    
    
    
}
