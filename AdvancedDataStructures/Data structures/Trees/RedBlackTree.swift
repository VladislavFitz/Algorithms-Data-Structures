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

/**
- Root and leaves are black
- Red node has black parent
- All paths from each node contain the same quantity of black nodes
– Black node may have black parent
*/

final class RedBlackTree<Key: Comparable, Value>: BinaryTreeWithParentProtocol {
    
    var key: Key
    var value: Value
    var left: RedBlackTree?
    var right: RedBlackTree?
    
    weak var parent: RedBlackTree?

    var color: Color

    init(key: Key, value: Value, left: RedBlackTree?, right: RedBlackTree?) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.parent = nil
        self.color = .black
    }
    
    init(key: Key, value: Value, left: RedBlackTree<Key, Value>?, right: RedBlackTree<Key, Value>?, parent: RedBlackTree<Key, Value>?) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.color = .black
        self.parent = parent
    }
    
    init(key: Key, value: Value, left: RedBlackTree?, right: RedBlackTree?, color: Color, parent: RedBlackTree? = .none) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.color = color
        self.parent = parent
    }
    
    var nodeDescription: String {
        return "\(key) [\(color)]"
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
    
}

extension RedBlackTree {
    
    func set(_ value: Value, for key: Key) -> RedBlackTree {
        
        let currentKey = self.key
        
        let result: RedBlackTree
        
        var shouldCheckBalance: Bool = false
        var uncleColor: Color = .black
        
        if key > currentKey  {
            
            let updatedRight: RedBlackTree
            
            if let right = self.right {
                updatedRight = right.set(value, for: key)
            } else {
                shouldCheckBalance = color == .red
                uncleColor = left?.color ?? .black
                updatedRight = RedBlackTree(key: key, value: value, left: .none, right: .none, color: .red, parent: self)
            }
            
            result = self.with(right: updatedRight)
            
        } else if key < currentKey {
            
            let updatedLeft: RedBlackTree
            
            if let left = self.left {
                updatedLeft = left.set(value, for: key)
            } else {
                shouldCheckBalance = color == .red
                uncleColor = right?.color ?? .black
                updatedLeft = RedBlackTree(key: key, value: value, left: .none, right: .none, color: .red, parent: self)
            }
            
            result = self.with(left: updatedLeft)
            
        } else {
            
            result = self.with(key: key, value: value)
            
        }
        
        guard shouldCheckBalance else  { return result }
        
        switch uncleColor {
        case .red:
            self.color = .black
            self.brother?.color = .black
            self.parent?.color = .red
            
        case .black:
            break
        }
        
        
        return result
        
    }
    
    func removeValue(for key: Key) -> Self? {
        return self
    }
    
}
