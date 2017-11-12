//
//  BinaryTreeProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 06/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

protocol BinaryTreeProtocol {
    
    associatedtype Key: Comparable
    associatedtype Value
    
    init(key: Key, value: Value, left: Self?, right: Self?)
    
    var key: Key { get }
    var value: Value { get }
    
    var left: Self? { get }
    var right: Self? { get }
    
    var height: Int { get }
    var count: Int { get }
    
    var isLeaf: Bool { get }
    
    subscript(key: Key) -> Value? { get }
    
    func contains(key: Key) -> Bool
    
    func value(forKey key: Key) -> Value?
    func rotated(by direction: RotationDirection) -> Self
    
    func set(_ value: Value, for key: Key) -> Self
    func removeValue(for key: Key) -> Self?
    
    func findMin() -> Self
    func findMax() -> Self
    
}

extension BinaryTreeProtocol {
    
    static func with(key: Key, value: Value, left: Self?, right: Self?) -> Self {
        return Self(key: key, value: value, left: left, right: right)
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
    
    /** Returns tree if tree contains node with specified key
     */
    
    func contains(key: Key) -> Bool {
        
        let currentKey = self.key
        
        if currentKey == key {
            return true
        } else {
            let branch = key < currentKey ? left : right
            return branch?.contains(key: key) ?? false
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
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
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
    
    /** Returns tree node corresponding to key.
        If key is not found returns nil.
    */
    
    func findNode(for key: Key) -> Self? {

        if key == self.key {
            return self
        } else if key > self.key {
            return self.right?.findNode(for: key)
        } else {
            return self.left?.findNode(for: key)
        }

    }
    
    /** Returns true if tree has no subtree
     */
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
        
}

extension BinaryTreeProtocol {
    
    func rotated(by direction: RotationDirection) -> Self {
        
        switch direction {
            
        case .left:
            
            guard let rightBranch = self.right else { return self }
            
            let leftBranch: Self = .with(key: key, value: value, left: left, right: rightBranch.left)
            return .with(key: rightBranch.key, value: rightBranch.value, left: leftBranch, right: rightBranch.right)
            
        case .right:
            
            guard let leftBranch = self.left else { return self }
            
            let rightBranch: Self = .with(key: key, value: value, left: leftBranch.right, right: right)
            return .with(key: leftBranch.key, value: leftBranch.value,  left: leftBranch.left, right: rightBranch)
            
        }
        
    }
    
}
