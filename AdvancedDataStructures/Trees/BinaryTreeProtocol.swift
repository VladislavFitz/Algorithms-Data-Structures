//
//  BinaryTreeProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol BinaryTreeProtocol {
    
    associatedtype Key: Comparable, Equatable
    associatedtype Value
    associatedtype Content = NodeContent<Key, Value>
    
    var leftBranch: Self? { get }
    var rightBranch: Self? { get }
    var height: Int { get }
    var value: Value? { get }
    var key: Key? { get }
    var isLeaf: Bool { get }
    var count: Int { get }
    
    subscript(key: Key) -> Value? { get }
    
    func value(forKey key: Key) -> Value?
    func insert(value: Value, forKey key: Key) -> Self
    func removeValueFor(key: Key) -> Self
    func rotated(by direction: RotationDirection) -> Self
    
    func checkCorrectness() -> Bool
}

extension BinaryTreeProtocol {
    
    /** Nodes count
     */
    
    var count: Int {
        return (leftBranch?.count ?? 0) + (rightBranch?.count ?? 0) + 1
    }
    
    /** Height of tree in nodes
     */
    
    var height: Int {
        return max((leftBranch?.height ?? 0), (rightBranch?.height ?? 0)) + 1
    }
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
    }
    
    func value(forKey key: Key) -> Value? {
        
        guard let currentKey = self.key else { return .none }
        
        if key == currentKey {
            return self.value
        } else if key < currentKey {
            return leftBranch?.value(forKey: key)
        } else {
            return rightBranch?.value(forKey: key)
        }

    }
    
    func checkCorrectness() -> Bool {
        guard let value = self.value as? NodeContent<Key, Value> else {
            return true
        }
        
        if let leftBranchValue = leftBranch?.value as? NodeContent<Key, Value> , leftBranchValue.key >= value.key {
            return false
        }
        
        if let rightBranchValue = rightBranch?.value as? NodeContent<Key, Value> , rightBranchValue.key < value.key {
            return false
        }
        
        return (leftBranch?.checkCorrectness() ?? true) && (rightBranch?.checkCorrectness() ?? true)
    }
    
}
