//
//  RandomizedTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 12/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

final class RandomizedTree<Key: Comparable, Value>: BinaryTreeProtocol {
    
    var key: Key
    var value: Value
    var left: RandomizedTree?
    var right: RandomizedTree?
    
    var size: Int
    
    init(key: Key, value: Value, left: RandomizedTree?, right: RandomizedTree?) {
        self.key = key
        self.value = value
        self.left = left
        self.right = right
        self.size = 1
    }
    
    func set(_ value: Value, for key: Key) -> RandomizedTree {
        return .insert(value, for: key, into: self)
    }
    
    func removeValue(for key: Key) -> RandomizedTree? {
        return .removeValue(for: key, from: self)
    }
    
    var nodeDescription: String {
        return "\(key) [\(size)]"
    }
    
    static func insert(_ value: Value, for key: Key, into tree: RandomizedTree?) -> RandomizedTree {
        
        guard let tree = tree else { return RandomizedTree(key: key, value: value, left: .none, right: .none)  }

        if Int(arc4random()) % tree.size + 1 == 0 {
            return insertRoot(value, for: key, into: tree)
        }
        
        if tree.key > key {
            tree.left = insert(value, for: key, into: tree.left)
        } else {
            tree.right = insert(value, for: key, into: tree.right)
        }
        
        fixSize(of: tree)
        
        return tree
        
    }
    
    static func removeValue(for key: Key, from tree: RandomizedTree?) -> RandomizedTree? {
        
        guard let tree = tree else { return .none }
        
        if key == tree.key {
            
            return join(tree.left, tree.right)
            
        } else if key < tree.key {
            
            tree.left = removeValue(for: key, from: tree.left)
            
        } else {
            
            tree.right = removeValue(for: key, from: tree.right)
            
        }
        
        return tree
        
    }
    
    //MARK: - Private functions
    
    private static func fixSize(of tree: RandomizedTree) {
        tree.size = tree.count
    }


    private static func insertRoot(_ value: Value, for key: Key, into tree: RandomizedTree?) -> RandomizedTree {
        
        guard let tree = tree else { return RandomizedTree.init(key: key, value: value, left: .none, right: .none)  }
        
        if tree.key == key {
            tree.value = value
            return tree
        } else if tree.key < key {
            return  insertRoot(value, for: key, into: tree.left).rotated(by: .right)
        } else {
            return insertRoot(value, for: key, into: tree.right).rotated(by: .left)
        }
        
    }
    
    private static func join(_ leftTree: RandomizedTree?, _ rightTree: RandomizedTree?) -> RandomizedTree? {
        
        guard let leftTree = leftTree else { return rightTree }
        guard let rightTree = rightTree else { return leftTree }
        
        if Int(arc4random()) % (leftTree.count + rightTree.count) < leftTree.count {
            
            leftTree.right = RandomizedTree.join(leftTree.right, rightTree)
            fixSize(of: leftTree)
            return leftTree
            
        } else {
            
            rightTree.left = RandomizedTree.join(leftTree, rightTree.left)
            fixSize(of: rightTree)
            return rightTree
            
        }
        
    }

}
