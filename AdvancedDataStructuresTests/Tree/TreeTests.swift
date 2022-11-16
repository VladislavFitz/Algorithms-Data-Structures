//
//  TreeTests.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 25.08.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

class TreeTests: XCTestCase {
    
    func testInsertComplexity() {
                
        var tree = AVLTree<Int>.empty
        
        for element in (0..<1000).shuffled() {
            tree = tree.inserting(element)
        }
        
        XCTAssertLessThan(Double(tree.height), 1.45 * log2(Double(tree.count + 2)))
        XCTAssertTrue(BinaryTreeChecker.isCorrect(tree))
        
    }
    
    func testBalancing() {
        
        var tree = AVLTree<Int>.empty
        
        for element in (0..<50).shuffled() {
            tree = tree.inserting(element)
        }
        
        XCTAssertTrue(true)
        
    }
    
    func testSmallLeftTurn() {
        XCTAssertTrue(true)
    }
    
    func testSmallRightTurn() {
        XCTAssertTrue(true)
    }
    
    func testBigLeftTurn() {
        XCTAssertTrue(true)

    }
    
    func testBigRightTurn() {
        XCTAssertTrue(true)

    }
    
}
