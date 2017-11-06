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

final class RedBlackTree<Key: Comparable, Value>: BinaryTreeProtocol {
    
    var key: Key?
    var value: Value?
    var color: Color
    weak var parent: RedBlackTree?
    var left: RedBlackTree?
    var right: RedBlackTree?
    
    init() {
        self.key = nil
        self.value = nil
        self.left = nil
        self.right = nil
        self.parent = nil
        self.color = .black
    }
    
    init(key: Key, value: Value, left: RedBlackTree?, right: RedBlackTree?) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.parent = nil
        self.color = .black
    }
    
    init(key: Key, value: Value, left: RedBlackTree?, right: RedBlackTree?, color: Color, parent: RedBlackTree? = .none) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.color = color
        self.parent = parent
    }
    
    func with(parent: RedBlackTree?) -> RedBlackTree {
        self.parent = parent
        return self
    }
    
    func with(color: Color) -> RedBlackTree {
        self.color = color
        return self
    }
    
    func with(left: RedBlackTree?) -> RedBlackTree {
        self.left = left
        return self
    }
    
    func with(right: RedBlackTree?) -> RedBlackTree {
        self.right = right
        return self
    }
    
    func with(key: Key, value: Value) -> RedBlackTree {
        self.key = key
        self.value = value
        return self
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
}

extension RedBlackTree {
    
    func value(forKey key: Key) -> Value? {
        return .none
    }
    
    /*
    func parentOfNode(for key: Key, parent: RedBlackTree? = .none) -> RedBlackTree? {
        guard let currentKey = self.key else { return .none }
        
        if currentKey < key {
            return right?.parentOfNode(for: key, parent: self)
        } else if currentKey > key {
            return left?.parentOfNode(for: key, parent: self)
        } else {
            return parent
        }
    }*/
    
    var brother: RedBlackTree? {
        guard let parent = self.parent else { return .none }
        
        if parent.left?.key == self.key {
            return parent.right
        } else {
            return parent.left
        }
        
    }
    
    var uncle: RedBlackTree? {
        return parent?.brother
    }
    
    func insert(value: Value, forKey key: Key) -> RedBlackTree {
        
        guard let currentKey = self.key else { return self }
        
        let result: RedBlackTree
        var shouldCheckBalance: Bool = false
        
        if key < currentKey {
            
            let updatedRight: RedBlackTree
            
            if let right = self.right {
                updatedRight = right.insert(value: value, forKey: key)
            } else {
                updatedRight = RedBlackTree(key: key, value: value, left: .none, right: .none, color: .red, parent: self)
                shouldCheckBalance = true
            }
            
            result = self.with(right: updatedRight)
            
        } else if key > key {
            
            let updatedLeft: RedBlackTree
            
            if let left = self.left {
                updatedLeft = left.insert(value: value, forKey: key)
            } else {
                updatedLeft = RedBlackTree(key: key, value: value, left: .none, right: .none, color: .red, parent: self)
                shouldCheckBalance = true
            }
            
            result = self.with(left: updatedLeft)
            
        } else {
            
            result = self.with(key: key, value: value)
            
        }
        
        if shouldCheckBalance && self.color == .red {
            
            if self.brother?.color == .red {
                self.color = .black
                self.brother?.color = .black
                self.parent?.color = .red
            } else {
                
                
                
            }
            
        } else {
            return result
        }
        
        
        /*
        switch self {
        case .empty:
            
            let content = NodeContent(key: key, value: value)
            return self//.node(content: content, color: .red, parent: self)
            
        case .node(content: let content, color: _, parent: _, left: let left, right: let right):
            
            let currentKey = content.key
            let currentValue = content.value
            let result: RedBlackTree

            if currentKey < key {
                result = .with(content: NodeContent(key: currentKey, value: currentValue), left: self.left, right: self.right?.insert(value: value, forKey: key))
            } else if currentKey > key {
                result = .with(content: NodeContent(key: currentKey, value: currentValue), left: self.left?.insert(value: value, forKey: key), right: self.right)
            } else {
                result = .with(content: NodeContent(key: key, value: value), left: self.left, right: self.right)
            }
            
            return result

        }
        */
        
        return self
    }
    
    func removeValueFor(key: Key) -> RedBlackTree {
        return self
    }
    
    func rotated(by direction: RotationDirection) -> RedBlackTree {
        return self
    }
    
}
