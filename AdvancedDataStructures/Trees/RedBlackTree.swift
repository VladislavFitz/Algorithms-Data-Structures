//
//  RedBlackTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.03.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum Color {
    case red, black
}

enum RedBlackTree<Key: Comparable, Value>: BinaryTreeProtocol where Key: Equatable {
    
    typealias Content = NodeContent<Key, Value>
    
    case empty
    indirect case node(content: Content, color: Color, left: RedBlackTree, right: RedBlackTree)
    
    var leftBranch: RedBlackTree? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: _, color: _, left: let leftBranch, right: _):
            return leftBranch
        }
    }
    
    var rightBranch: RedBlackTree? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: _, color: _, left: _, right: let rightBranch):
            return rightBranch
        }
    }
    
    var key: Key? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: let content, color: _, left: _, right: _):
            return content.key
        }
    }
    
    var value: Value? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: let content, color: _, left: _, right: _):
            return content.value
        }
    }
    
    var isLeaf: Bool {
        switch self {
        case .node(content: _, color: _, left: .empty, right: .empty):
            return true
        default:
            return false
        }
    }
    
}

extension RedBlackTree {
    
    func value(forKey key: Key) -> Value? {
        return .none
    }
    
    func insert(value: Value, forKey key: Key) -> RedBlackTree {
        return self
    }
    
    func removeValueFor(key: Key) -> RedBlackTree {
        return self
    }
    
    func rotated(by direction: RotationDirection) -> RedBlackTree {
        return self
    }
    
}
