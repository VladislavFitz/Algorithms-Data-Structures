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
    
    var uf = UnionFind()
    uf.makeSet(1)
    uf.makeSet(2)
    uf.makeSet(3)
    uf.unite(1, 3)
    
    XCTAssertTrue(uf.areJoint(1, 3))
    XCTAssertFalse(uf.areJoint(2, 3))
    XCTAssertFalse(uf.areJoint(1, 2))
    
    XCTAssertEqual(uf.count, 3)
    XCTAssertEqual(uf.setCount, 2)
    
  }
  
}
