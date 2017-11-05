//
//  BinaryTreeProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol BinaryTreeProtocol {
    
    associatedtype Key: Comparable
    associatedtype Value
    
    init()
    init(key: Key, value: Value, left: Self?, right: Self?)
    
    var key: Key? { get }
    var value: Value? { get }

    var left: Self? { get }
    var right: Self? { get }
    
    var height: Int { get }
    var count: Int { get }
    var isLeaf: Bool { get }
    
    subscript(key: Key) -> Value? { get }
    
    func value(forKey key: Key) -> Value?
    func insert(value: Value, forKey key: Key) -> Self
    func removeValueFor(key: Key) -> Self
    func rotated(by direction: RotationDirection) -> Self
    
    func checkCorrectness() -> Bool
}

extension BinaryTreeProtocol {
    
    static var none: Self {
        return Self()
    }
    
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
            return left?.value(forKey: key)
        } else {
            return right?.value(forKey: key)
        }

    }
    
    func rotated(by direction: RotationDirection) -> Self {
        
        switch direction {
        case .left:
            let lb: Self = .with(key: key!, value: value!, left: left, right: right?.left)
            return .with(key: right!.key!, value: right!.value!, left: lb, right: right?.right)
            
        case .right:
            let rb: Self = .with(key: key!, value: value!, left: left?.right, right: right)
            return .with(key: left!.key!, value: left!.value!,  left: left?.left, right: rb)
        }

    }
    
    func checkCorrectness() -> Bool {
        
        guard let key = self.key else {
            return true
        }
        
        if let leftKey = self.left?.key, leftKey >= key {
            return false
        }
        
        if let rightKey = self.right?.key, rightKey < key {
            return false
        }
        
        return (left?.checkCorrectness() ?? true) && (right?.checkCorrectness() ?? true)
    }
    
}
