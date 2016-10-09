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
    
    func testSmallLeftTurn() {
        
        typealias Tree = AVLTree<Int, Int>
        typealias Content = Tree.Content
        
        let tree = Tree.node(
            content: Content(key: 5, value: 5),
            left: Tree.node(
                content: Content(key: 4, value: 4),
                left: .empty,
                right: .empty),
            right: Tree.node(
                content: Content(key: 7, value: 7),
                left: Tree.node(content: Content(key: 6, value: 6), left: .empty, right: .empty),
                right: Tree.node(content: Content(key: 8, value: 8), left: .empty, right: .empty))
        )
        
        let turnedTree = tree.rotated(by: .left)
        
        switch turnedTree {
        case .node(content: let content, left: let left, right: let right) where content.key == 7:
            
            switch left {
            case .node(content: let content, left: let left, right: let right) where content.key == 5:
                
                switch left {
                case .node(content: let content, left: .empty, right: .empty) where content.key == 4:
                    break
                default:
                    XCTFail()
                }
                
                switch right {
                case .node(content: let content, left: .empty, right: .empty) where content.key == 6:
                    break
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            
            switch right {
            case .node(content: let content, left: .empty, right: .empty) where content.key == 8:
                break
            default:
                XCTFail()
            }
            
        default:
            XCTFail()
        }
        
    }
    
    func testSmallRightTurn() {
        
        typealias Tree = AVLTree<Int, Int>
        typealias Content = Tree.Content
        
        let tree = Tree.node(
            content: Content(key: 5, value: 5),
            left: Tree.node(
                content: Content(key: 3, value: 3),
                left: Tree.node(content: Content(key: 2, value: 2), left: .empty, right: .empty),
                right: Tree.node(content: Content(key: 4, value: 4), left: .empty, right: .empty)),
            right: Tree.node(
                content: Content(key: 6, value: 6),
                left: .empty,
                right: .empty)
        )
        
        let turnedTree = tree.rotated(by: .right)
        
        switch turnedTree {
        case .node(content: let content, left: let left, right: let right) where content.key == 3:
            
            switch left {
            case .node(content: let content, left: _, right: _) where content.key == 2:
                break
                
            default:
                XCTFail()
            }
            
            switch right {
            case .node(content: let content, left: let left, right: let right) where content.key == 5:
                
                switch left {
                case .node(content: let content, left: .empty, right: .empty) where content.key == 4:
                    break
                default:
                    XCTFail()
                }
                
                switch right {
                case .node(content: let content, left: .empty, right: .empty) where content.key == 6:
                    break
                default:
                    XCTFail()
                }
                
            default:
                XCTFail()
            }
            
        default:
            XCTFail()
        }
    }
    
    func testBigLeftTurn() {
        XCTAssertTrue(true)

    }
    
    func testBigRightTurn() {
        XCTAssertTrue(true)

    }
    
}
