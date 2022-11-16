//
//  AVLTreeTests.swift
//  AdvancedDataStructuresTests
//
//  Created by Vladislav on 09/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation
import XCTest
@testable import AdvancedDataStructures

class AVLTreeTests: XCTestCase {
    
    func testInsertion() {
        
        let array = Array(0..<1000).shuffled()
        var tree = AVLTree<Int>.empty
        
        array.forEach { element in
            tree = tree.insert(element)
            XCTAssertTrue(tree.isBalanced, "Not balanced: \n \(tree)")
        }
        
        for element in array where !tree.contains(element)  {
            XCTFail("Tree doesn't contain \(element) \n \(tree)")
            break
        }
        
    }
    
    func testRemoval() {
        
        let array = Array(0..<1000).shuffled()
        var tree = AVLTree<Int>.empty

        array.forEach { element in
            tree = tree.insert(element)
        }
        
        for element in array.shuffled() {
            
            guard let updatedTree = tree.remove(element) else {
                break
            }
            
            tree = updatedTree
            XCTAssertFalse(tree.contains(element), "Tree contains: \(element) \n \(tree)")
            XCTAssertTrue(tree.isBalanced, "Not balanced: \n \(tree)")
            break
            
        }
        
    }
    
    
}
