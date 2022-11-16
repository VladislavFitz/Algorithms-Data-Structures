//
//  BinarySearchTreeTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 04/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

class BinarySearchTreeTests: XCTestCase {
    
    typealias TestTree = BinarySearchTree<Int>
    
    func generateTree(size: Int = 100) -> TestTree {
        
        let shuffledArray = Array(0..<size).shuffled()
                
        return BinarySearchTree(shuffledArray)!
    }
    
    func testCorrectness() {
        
        let tree = generateTree()
        
        var elements: [Int] = []
        var inOrderTraversal = InOrderTreeTraversal<TestTree>()
        inOrderTraversal.visit = { elements.append($0.element) }
        
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
        
        let tree = generateTree(size: 10)

        XCTAssertEqual(tree.findMin().element, 0)
    }
    
    func testFindMax() {
        
        let tree = generateTree(size: 10)

        XCTAssertEqual(tree.findMax().element, 9)
    }
    
    func testFindPrevious() {
        
        let tree = generateTree()
        
        let node = tree.findNode(for: 5)
        
        XCTAssertEqual(node?.previous()?.element, 4)

    }
    
    func testFindNext() {
        let tree = generateTree()
        
        let node = tree.findNode(for: 5)

        XCTAssertEqual(node?.next()?.element, 6)
    }
    
    func testRemove() {
        
        var inOrderTraversal = InOrderTreeTraversal<TestTree>()
        var elements: [Int] = []
        inOrderTraversal.visit = { elements.append($0.element) }

        let tree = generateTree(size: 10)
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

        tree.remove(5)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8, 9])
        
        tree.remove(9)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8])

        
        tree.remove(4)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 6, 7, 8])
        
        tree.remove(2)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 3, 6, 7, 8])

    }
    
    func testLeftTurn() {
        var preOrderTraversal = PreOrderTreeTraversal<TestTree>()
        var elements: [Int] = []
        preOrderTraversal.visit = { elements.append($0.element) }
        
        var tree = BinarySearchTree([3, 1, 5, 0, 2, 4, 6])!
        
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([3, 1, 0, 2, 5, 4, 6], elements)
        
        elements.removeAll()

        
        tree = tree.rotated(by: .left)
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([5, 3, 1, 0, 2, 4, 6], elements)
    }
    
    func testRightTurn() {
        var preOrderTraversal = PreOrderTreeTraversal<TestTree>()
        var elements: [Int] = []
        preOrderTraversal.visit = { elements.append($0.element) }
        
        var tree = BinarySearchTree([3, 1, 5, 0, 2, 4, 6])!
        
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([3, 1, 0, 2, 5, 4, 6], elements)
        
        elements.removeAll()
        
        tree = tree.rotated(by: .right)
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([1, 0, 3, 2, 5, 4, 6], elements)
    }
    
}
