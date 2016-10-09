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
    var value: Content? { get }
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
    
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
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
