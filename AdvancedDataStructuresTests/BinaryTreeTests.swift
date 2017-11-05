//
//  BinaryTreeTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 04/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import XCTest
import AdvancedDataStructures

class BinaryTreeTests: XCTestCase {
    
    func testCorrectness() {
        var shuffledArray = Array(0..<10)
        shuffledArray.shuffle()
        
        let treeArray = shuffledArray.map({ (key: $0, value: ()) })
        
        guard let tree = BinaryTree(array: treeArray) else {
            XCTFail()
            return
        }
        
        let treeString = BinaryTreePrinter.treeString(tree, using: { (tree) in
            return ("\(tree.key)", tree.left, tree.right)
        })
        
        var elements: [Int] = []
        var inOrderTraversal = InOrderTreeTraversal<Int, Void>()
        inOrderTraversal.visit = { elements.append($0.key) }
        
        inOrderTraversal.traverse(tree)
        
        XCTAssertTrue(elements.isSorted)
        
    }
    
    func testInsertion() {
        XCTAssertTrue(true)
    }
    
    func testSearch() {
        XCTAssertTrue(true)
    }
    
    func testFindMin() {
        XCTAssertTrue(true)
    }
    
    func testFindMax() {
        XCTAssertTrue(true)
    }
    
    func testFindPrevious() {
        XCTAssertTrue(true)
    }
    
    func testFindNext() {
        XCTAssertTrue(true)
    }
    
    func testRemove() {
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
