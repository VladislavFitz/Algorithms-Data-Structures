//
//  UnionFindTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav Fitc on 04/02/2018.
//  Copyright © 2018 Fitc. All rights reserved.
//

import Foundation
@testable import AdvancedDataStructures
import XCTest

class UnionFindTests: XCTestCase {
    
    func testConstruction() {
        
        var uf = UnionFind<String>(sets: [["A", "C"], ["B"]])
        
        XCTAssertTrue(uf.areInSameSet("A", "C"))
        XCTAssertFalse(uf.areInSameSet("B", "C"))
        XCTAssertFalse(uf.areInSameSet("A", "B"))
        
        XCTAssertEqual(uf.count, 3)
        XCTAssertEqual(uf.setCount, 2)
        
    }
    
}
