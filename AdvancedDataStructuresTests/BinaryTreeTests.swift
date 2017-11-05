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
    
    func generateTree(count: Int = 10) -> BinaryTree<Int, Void> {
        let shuffledArray = [4, 5, 0, 3, 9, 1, 7, 2, 8, 6].shuffled()
        
        let treeArray = shuffledArray.map({ (key: $0, value: ()) })
        
        return BinaryTree(array: treeArray)!
    }
    
    func testCorrectness() {
        
        let tree = generateTree()
        
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
        
        let tree = generateTree()

        XCTAssertEqual(tree.min().key, 0)
    }
    
    func testFindMax() {
        
        let tree = generateTree()

        XCTAssertEqual(tree.max().key, 9)
    }
    
    func testFindPrevious() {
        
        let tree = generateTree()
        
        let node = tree.findNode(for: 5)
        
        XCTAssertEqual(node?.previous()?.key, 4)

    }
    
    func testFindNext() {
        let tree = generateTree()
        
        let node = tree.findNode(for: 5)

        XCTAssertEqual(node?.next()?.key, 6)
    }
    
    func testRemove() {
        
        var inOrderTraversal = InOrderTreeTraversal<Int, Void>()
        var elements: [Int] = []
        inOrderTraversal.visit = { elements.append($0.key) }

        var tree = generateTree()
        print(tree)
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

        tree = tree.removeValue(for: 5)!
        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8, 9])
        
        tree = tree.removeValue(for: 9)!
        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8])

        
        tree = tree.removeValue(for: 4)!
        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 6, 7, 8])
        
        tree = tree.removeValue(for: 2)!
        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 3, 6, 7, 8])

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
