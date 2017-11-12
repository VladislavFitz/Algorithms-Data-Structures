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
    
    func generateTree(size: Int = 1000) -> RandomizedTree<Int, Void> {
        
        assert(size > 0)
        
        let shuffledArray = Array(0..<size).shuffled()
        
        var tree = RandomizedTree<Int, Void>(key: shuffledArray.first!, value: (), left: .none, right: .none)
        
        for key in shuffledArray.dropFirst() {
            tree = .insert((), for: key, into: tree)
        }
        
        return tree
        
    }
    
    func testCorrectness() {
        
        let tree = generateTree(size: 1000)
        
        var elements: [Int] = []
        var inOrderTraversal = InOrderTreeTraversal<RandomizedTree<Int, Void>>()
        inOrderTraversal.visit = { elements.append($0.key) }
        
        inOrderTraversal.traverse(tree)
        
        XCTAssertTrue(elements.isSorted)
        
    }
    
    func testInsertionAndRemoval() {
        
        let array = Array(0..<1000).shuffled()
        
        var tree = RandomizedTree<Int, Void>(key: array.first!, value: (), left: .none, right: .none)
        
        for key in array.dropFirst() {
            tree = .insert((), for: key, into: tree)
        }
        
        for key in array.shuffled() {
            XCTAssertTrue(tree.contains(key: key), "Tree doesn't contain \(key)")
        }
        
        for key in array.shuffled() {
            if let mutatedTree = RandomizedTree.removeValue(for: key, from: tree) {
                tree = mutatedTree
                XCTAssertFalse(tree.contains(key: key))
            }
        }
        
    }
    
}
