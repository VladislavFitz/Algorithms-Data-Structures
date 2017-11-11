//
//  AVLTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

enum AVLTree<Key, Value>: BinaryTreeProtocol where Key: Comparable {
    
    case empty
    indirect case node(key: Key, value: Value, left: AVLTree, right: AVLTree)
    
    init(key: Key, value: Value, left: AVLTree?, right: AVLTree?) {
        self = .node(key: key, value: value, left: left ?? .empty, right: right ?? .empty)
    }
    
    var key: Key {
        if case .node(key: let key, value: _, left: _, right: _) = self {
            return key
        } else {
            fatalError()
        }
    }
        
    var value: Value {
        if case .node(key: _, value: let value, left: _, right: _) = self {
            return value
        } else {
            fatalError()
        }
    }
    
    var left: AVLTree<Key, Value>? {
        if case .node(key: _, value: _, left: let left, right: _) = self {
            if case .empty = left {
                return nil
            } else {
                return left
            }
        } else {
            return nil
        }
    }
    
    var right: AVLTree<Key, Value>? {
        if case .node(key: _, value: _, left: _, right: let right) = self {
            if case .empty = right {
                return nil
            } else {
                return right
            }
        } else {
            return nil
        }
    }
    
    var isBalanced: Bool {
        return [-1, 0, 1].contains(balanceFactor)
    }
    
    /** Balance factor of AVL tree. Balance factor ∈ {–1,0,+1} for balanced AVL tree.
     */
    
    fileprivate var balanceFactor: Int {
        return (right?.height ?? 0) - (left?.height ?? 0)
    }
    
    /** Returns balanced AVL tree
    */
    
    fileprivate func balanced() -> AVLTree {
        
        switch self {
        case .empty:
            return self
            
        case .node(key: let key, value: let value, left: let left, right: let right):
            
            switch balanceFactor {
            case 2:
                if right.balanceFactor < 0 {
                    let rotatedright = right.rotated(by: .right)
                    let intermediateTree = AVLTree.node(key: key, value: value, left: left, right: rotatedright)
                    return intermediateTree.rotated(by: .left)
                } else {
                    return self.rotated(by: .left)
                }
                
            case -2:
                
                if left.balanceFactor > 0 {
                    let rotatedleft = left.rotated(by: .left)
                    let intermediateTree = AVLTree.node(key: key, value: value, left: rotatedleft, right: right)
                    return intermediateTree.rotated(by: .right)
                } else {
                    return self.rotated(by: .right)
                }
                
            default:
                return self
            }
        }
        
    }
    
}

//MARK:- Operations

extension AVLTree {
    
    func set(_ value: Value, for key: Key) -> AVLTree<Key, Value> {
        
        switch self {
        case .empty:
            return .node(key: key, value: value, left: .empty, right: .empty)
            
        case .node(key: let currentKey, value: let currentValue, left: let left, right: let right):
            
            if currentKey < key {
                
                let newright = right.set(value, for: key)
                return AVLTree.node(key: currentKey, value: currentValue, left: left, right: newright).balanced()
                
            } else if currentKey > key {
                
                let newleft = left.set(value, for: key)
                return AVLTree.node(key: currentKey, value: currentValue, left: newleft, right: right).balanced()
                
            } else {
                return self
            }
            
        }
    }
        
    func removeValue(for key: Key) -> AVLTree<Key, Value>? {

        func removeMin(tree: AVLTree) -> AVLTree {
            
            switch tree {
                
            case .empty:
                return self
                
            case .node(key: _, value: _, left: .empty, right: .node):
                return right!
                
            case .node(key: let key, value: let value, left: let left, right: let right):
                return AVLTree.node(key: key, value: value, left: removeMin(tree: left), right: right).balanced()
                
            }
            
        }
        
        switch self {
        case .empty:
            return self
            
        case .node(key: let currentKey, value: let value, left: let left, right: let right) where key < currentKey:
            return AVLTree.node(key: currentKey, value: value, left: left.removeValue(for: key)!, right: right)
            
        case .node(key: let currentKey, value: let value, left: let left, right: let right) where key > currentKey:
            return AVLTree.node(key: currentKey, value: value, left: left, right: right.removeValue(for: key)!)
            
        case .node(key: _, value: _, left: let left, right: .empty):
            return left
            
        case .node(key: _, value: _, left: let left, right: let right):
            let rightMinElement = right.findMin()
            return AVLTree.node(key: rightMinElement.key, value: rightMinElement.value, left: left, right: removeMin(tree: right)).balanced()
        }
        
    }
    
}

//MARK:- CustomStringConvertible

extension AVLTree: CustomStringConvertible {
    
    var description: String {
        
        return BinaryTreePrinter.treeString(self, using: { (tree) in
            return ("\(tree.key)", tree.left, tree.right)
        })
        
    }
    
}
