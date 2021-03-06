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
        var tree = AVLTree<Int, Void>.empty
        
        array.forEach { key in
            tree = tree.set((), for: key)
            XCTAssertTrue(tree.isBalanced, "Not balanced: \n \(tree)")
        }
        
        for element in array where !tree.contains(key: element)  {
            XCTFail("Tree doesn't contain \(element) \n \(tree)")
            break
        }
        
    }
    
    func testRemoval() {
        
        let array = Array(0..<1000).shuffled()
        var tree = AVLTree<Int, Void>.empty

        array.forEach { key in
            tree = tree.set((), for: key)
        }
        
        for element in array.shuffled() {
            
            guard let updatedTree = tree.removeValue(for: element) else {
                break
            }
            
            tree = updatedTree
            XCTAssertFalse(tree.contains(key: element), "Tree contains: \(element) \n \(tree)")
            XCTAssertTrue(tree.isBalanced, "Not balanced: \n \(tree)")
            break
            
        }
        
    }
    
    
}
