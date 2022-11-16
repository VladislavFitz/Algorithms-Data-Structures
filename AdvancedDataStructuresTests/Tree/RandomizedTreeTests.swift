//
//  RandomizedTreeTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 12/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

class RandomizedTreeTests: XCTestCase {
    
    func generateTree(size: Int = 1000) -> RandomizedTree<Int> {
        
        assert(size > 0)
        
        let shuffledArray = Array(0..<size).shuffled()
        
        var tree = RandomizedTree<Int>(element: shuffledArray.first!, left: .none, right: .none)
        
        for key in shuffledArray.dropFirst() {
            tree = .insert(key, into: tree)
        }
        
        return tree
        
    }
    
    func testCorrectness() {
        
        let tree = generateTree(size: 1000)
        
        var elements: [Int] = []
        var inOrderTraversal = InOrderTreeTraversal<RandomizedTree<Int>>()
        inOrderTraversal.visit = { elements.append($0.element) }
        
        inOrderTraversal.traverse(tree)
        
        XCTAssertTrue(elements.isSorted)
        
    }
    
    func testInsertionAndRemoval() {
        
        let array = Array(0..<1000).shuffled()
        
        var tree = RandomizedTree<Int>(element: array.first!, left: .none, right: .none)
        
        for element in array.dropFirst() {
            tree = .insert(element, into: tree)
        }
        
        for element in array.shuffled() {
            XCTAssertTrue(tree.contains(element), "Tree doesn't contain \(element)")
        }
        
        for element in array.shuffled() {
            if let mutatedTree = RandomizedTree.remove(element, from: tree) {
                tree = mutatedTree
                XCTAssertFalse(tree.contains(element))
            }
        }
        
    }
    
}
