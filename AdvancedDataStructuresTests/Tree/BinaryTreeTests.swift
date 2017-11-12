//
//  BinaryTreeTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 04/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

class BinaryTreeTests: XCTestCase {
    
    typealias TestTree = BinaryTree<Int, Void>
    
    func generateTree(size: Int = 100) -> TestTree {
        
        let shuffledArray = Array(0..<size).shuffled()
        
        let treeArray = shuffledArray.map({ (key: $0, value: ()) })
        
        return BinaryTree(array: treeArray)!
    }
    
    func testCorrectness() {
        
        let tree = generateTree()
        
        var elements: [Int] = []
        var inOrderTraversal = InOrderTreeTraversal<TestTree>()
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
        
        let tree = generateTree(size: 10)

        XCTAssertEqual(tree.findMin().key, 0)
    }
    
    func testFindMax() {
        
        let tree = generateTree(size: 10)

        XCTAssertEqual(tree.findMax().key, 9)
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
        
        var inOrderTraversal = InOrderTreeTraversal<TestTree>()
        var elements: [Int] = []
        inOrderTraversal.visit = { elements.append($0.key) }

        var tree = generateTree(size: 10)
//        print(tree)
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

        tree = tree.removeValue(for: 5)!
//        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8, 9])
        
        tree = tree.removeValue(for: 9)!
//        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 4, 6, 7, 8])

        
        tree = tree.removeValue(for: 4)!
//        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 2, 3, 6, 7, 8])
        
        tree = tree.removeValue(for: 2)!
//        print(tree)
        elements.removeAll()
        inOrderTraversal.traverse(tree)
        XCTAssertEqual(elements, [0, 1, 3, 6, 7, 8])

    }
    
    func testLeftTurn() {
        
        var preOrderTraversal = PreOrderTreeTraversal<TestTree>()
        var elements: [Int] = []
        preOrderTraversal.visit = { elements.append($0.key) }
        
        let treeArray = [3, 1, 5, 0, 2, 4, 6].map({ (key: $0, value: ()) })
        var tree = BinaryTree(array: treeArray)!
        
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
        preOrderTraversal.visit = { elements.append($0.key) }
        
        let treeArray = [3, 1, 5, 0, 2, 4, 6].map({ (key: $0, value: ()) })
        var tree = BinaryTree(array: treeArray)!
        
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([3, 1, 0, 2, 5, 4, 6], elements)
        
        elements.removeAll()
        
        tree = tree.rotated(by: .right)
        preOrderTraversal.traverse(tree)
        XCTAssertEqual([1, 0, 3, 2, 5, 4, 6], elements)

    }
    
}
