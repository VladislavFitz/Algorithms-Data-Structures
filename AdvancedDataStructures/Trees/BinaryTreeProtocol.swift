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
    associatedtype Content = NodeContent<Key, Value>
    
    init()
    init(content: Content, left: Self?, right: Self?)
    
    var content: Content? { get }
    var left: Self? { get }
    var right: Self? { get }
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
    
    static var none: Self {
        return Self()
    }
    
    static func with(content: Content, left: Self?, right: Self?) -> Self {
        return Self(content: content, left: left, right: right)
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
            let lb: Self = .with(content: content!, left: left, right: right?.left)
            return .with(content: right!.content!, left: lb, right: right?.right)
            
        case .right:
            let rb: Self = .with(content: content!, left: left?.right, right: right)
            return .with(content: left!.content!, left: left?.left, right: rb)
        }

    }
    
    func checkCorrectness() -> Bool {
        guard let value = self.value as? NodeContent<Key, Value> else {
            return true
        }
        
        if let leftValue = left?.value as? NodeContent<Key, Value> , leftValue.key >= value.key {
            return false
        }
        
        if let rightValue = right?.value as? NodeContent<Key, Value> , rightValue.key < value.key {
            return false
        }
        
        return (left?.checkCorrectness() ?? true) && (right?.checkCorrectness() ?? true)
    }
    
}
