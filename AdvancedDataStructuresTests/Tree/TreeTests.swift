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
                
        var tree = AVLTree<Int, Void>.empty
        
        for element in Array(0..<1000).shuffled() {
            tree = tree.set((), for: element)
        }
        
        XCTAssertLessThan(Double(tree.height), 1.45 * log2(Double(tree.count + 2)))
        XCTAssertTrue(BinaryTreeVerifier.isCorrect(tree))
        
    }
    
    func testBalancing() {
        
        let keys = Array(0..<50).shuffled()
        var tree = AVLTree<Int, Void>.empty
        
        for key in keys {
            tree = tree.set((), for: key)
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
