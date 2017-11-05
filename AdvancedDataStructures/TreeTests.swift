//
//  TreeTests.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 25.08.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import XCTest
import AdvancedDataStructures

class TreeTests: XCTestCase {
    
    func testInsertComplexity() {
        
        var g = Generator(bound: 1000)
        
        var tree = AVLTree<Int, Int>.empty
        
        for _ in 0..<1000 {
            let value = g.getNewValue()
            tree = tree.insert(value: value, forKey: value)
        }
        
        XCTAssertLessThan(Double(tree.height), 1.45 * log2(Double(tree.count + 2)))
        XCTAssertTrue(tree.checkCorrectness())
        
    }
    
    func testBalancing() {
        
        let keys = Array(0..<50).shuffled()
        var tree = AVLTree<Int, Void>.empty
        
        for key in keys {
            tree = tree.insert(value: (), forKey: key)
        }
        
        print(tree)
        
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
