//
//  IBinaryTreeProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 06/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum ParentRelation {
    case root
    case leftSubtree
    case rightSubtree
}

protocol IBinaryTreeProtocol {
    
    associatedtype Key: Comparable
    associatedtype Value
    
    init(key: Key, value: Value, left: Self?, right: Self?, parent: Self?)
    
    var key: Key { get }
    var value: Value { get }
    
    var left: Self? { get set }
    var right: Self? { get set }
    var parent: Self? { get }
    var parentRelation: ParentRelation { get }
    
    var height: Int { get }
    var count: Int { get }
    
    /** Returns true if tree is leaf (tree without subtrees)
     */
    var isLeaf: Bool { get }
    
    subscript(key: Key) -> Value? { get }
    
    func value(forKey key: Key) -> Value?
    func rotated(by direction: RotationDirection) -> Self
    
    func set(_ value: Value, for key: Key)
    func removeValue(for key: Key) -> Self?

    func checkCorrectness() -> Bool
    
    func root() -> Self
    
    func findMin() -> Self
    func findMax() -> Self
    
    func next() -> Self?
    func previous() -> Self?
    
}

extension IBinaryTreeProtocol {
    
    static func with(key: Key, value: Value, left: Self?, right: Self?, parent: Self?) -> Self {
        return Self(key: key, value: value, left: left, right: right, parent: parent)
    }
    
    var parentRelation: ParentRelation {
        
        if parent == nil {
            return .root
        }
        
        if parent?.left?.key == key {
            return .leftSubtree
        }
        
        if parent?.right?.key == key {
            return .rightSubtree
        }
        
        fatalError("Impossible position")
    }

    
    /** Nodes count
     */
    
    var count: Int {
        return (left?.count ?? 0) + (right?.count ?? 0) + 1
    }
    
    /** Height of tree in nodes
     */
    
    var height: Int {
        return max((left?.height ?? 0), (right?.height ?? 0)) + 1
    }
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
    }
    
    func value(forKey key: Key) -> Value? {
        
        if key == self.key {
            return self.value
        } else if key < self.key {
            return left?.value(forKey: key)
        } else {
            return right?.value(forKey: key)
        }
        
    }
    
    func rotated(by direction: RotationDirection) -> Self {
        
        switch direction {
            
        case .left:
            
            guard let rightBranch = self.right else { return self }
            
            let leftBranch: Self = .with(key: key, value: value, left: left, right: rightBranch.left, parent: rightBranch)
            return .with(key: rightBranch.key, value: rightBranch.value, left: leftBranch, right: rightBranch.right, parent: parent)
            
        case .right:
            
            guard let leftBranch = self.left else { return self }

            let rightBranch: Self = .with(key: key, value: value, left: leftBranch.right, right: right, parent: leftBranch)
            return .with(key: leftBranch.key, value: leftBranch.value,  left: leftBranch.left, right: rightBranch, parent: parent)
            
        }
        
    }
    
    func root() -> Self {
        var current = self
        
        while let parent = current.parent {
            current = parent
        }
        
        return current
    }

    
    func findMin() -> Self {
        
        var minNode = self
        
        while let leftBranch = minNode.left {
            minNode = leftBranch
        }
        
        return minNode
        
    }
    
    func findMax() -> Self {
        
        var maxNode = self
        
        while let rightBranch = maxNode.right {
            maxNode = rightBranch
        }
        
        return maxNode
        
    }
    
    func findNode(for key: Key) -> Self? {

        if key == self.key {
            return self
        } else if key > self.key {
            return self.right?.findNode(for: key)
        } else {
            return self.left?.findNode(for: key)
        }

    }

    func next() -> Self? {
        
        if let rightSubtree = self.right {
            return rightSubtree.findMin()
        }
        
        var node = self
        
        while let parent = node.parent, node.parentRelation == .rightSubtree {
            node = parent
        }
        
        return node.parent
        
    }
    
    func previous() -> Self? {
        
        if let leftSubtree = self.left {
            return leftSubtree.findMax()
        }
        
        var node = self
        
        while let parent = node.parent, node.parentRelation == .leftSubtree {
            node = parent
        }
        
        return node.parent
        
    }

    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    func checkCorrectness() -> Bool {
        
        if let leftKey = left?.key, leftKey >= key {
            return false
        }
        
        if let rightKey = right?.key, rightKey < key {
            return false
        }
        
        return (left?.checkCorrectness() ?? true) && (right?.checkCorrectness() ?? true)
    }
    
}
