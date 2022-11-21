//
//  LCATests.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 20.11.2022.
//  Copyright © 2022 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

extension BinarySearchTree<Int>: ExpressibleByIntegerLiteral {
  
  convenience init(integerLiteral value: IntegerLiteralType) {
    self.init(element: value, left: nil, right: nil)
  }

}

class LCATests: XCTestCase {
  
  func testNaiveLCA() {
    
    /*
           10
        __/  \_
       6       12
      / \     /  \
     4   7  11    15
    / \   \      /
   2   5   9   14
              /
            13
     
     */
    
    let tree = BinarySearchTree<Int>(element: 10,
                                     left: .with(element: 6,
                                                 left: .with(element: 4,
                                                             left: 2,
                                                             right: 5),
                                                 right: .with(element: 7,
                                                              right: 9)),
                                     right: .with(element: 12,
                                                  left: 11,
                                                  right: .with(element: 15,
                                                               left: .with(element: 14,
                                                                           left: 13))))
    
    print(BinaryTreePrinter.treeString(tree) { node in
      ("\(node.element)", node.left, node.right)
    })
    var lca = LCANaiveAlgorithm(tree: tree, u: 9, v: 14)
    lca.perform()
    XCTAssertEqual(lca.output, 10)
    
    lca = LCANaiveAlgorithm(tree: tree, u: 5, v: 7)
    lca.perform()
    XCTAssertEqual(lca.output, 6)
    
    lca = LCANaiveAlgorithm(tree: tree, u: 13, v: 15)
    lca.perform()
    XCTAssertEqual(lca.output, 15)
    
    lca = LCANaiveAlgorithm(tree: tree, u: 7, v: 7)
    lca.perform()
    XCTAssertEqual(lca.output, 7)
    
    lca = LCANaiveAlgorithm(tree: tree, u: 20, v: 10)
    lca.perform()
    XCTAssertNil(lca.output)
    
  }
  
}
