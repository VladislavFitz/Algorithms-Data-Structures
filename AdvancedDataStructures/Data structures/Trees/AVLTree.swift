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
            /*
             If balance factor == 2, that means that tree is misbalanced to right side.
             One should turn it left.
            */
            case 2:
                
                let intermediateTree: AVLTree
                
                /*
                 If balance factor of right subtree is negative, that means that one need a big left turn
                 So one need to turn right branch right previously
                */
                
                if right.balanceFactor < 0 {
                    let rotatedright = right.rotated(by: .right)
                    intermediateTree = AVLTree.node(key: key, value: value, left: left, right: rotatedright)
                } else {
                    intermediateTree = self
                }
                
                return intermediateTree.rotated(by: .left)
            /*
             If balance factor == -2, that means that tree is misbalanced to left side.
             One should turn it right.
             */
            case -2:
                
                let intermediateTree: AVLTree
                
                /*
                 If balance factor of left subtree is positive, that means that one need a big right turn
                 So one need to turn left branch left previously
                 */

                
                if left.balanceFactor > 0 {
                    let rotatedleft = left.rotated(by: .left)
                    intermediateTree = AVLTree.node(key: key, value: value, left: rotatedleft, right: right)
                } else {
                    intermediateTree = self
                }
                
                return intermediateTree.rotated(by: .right)
                
            default:
                return self
            }
        }
        
    }
    
    var nodeDescription: String {
        return "\(key) [\(balanceFactor)]"
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
        
        /**
         Returns tuple of min element of tree and tree without this min element
        */

        func extractMin(tree: AVLTree) -> (min: (key: Key, value: Value)?, tree: AVLTree) {
            
            switch tree {
                
            case .empty:
                return (min: .none, tree: self)
                
            case .node(key: let key, value: let value, left: .empty, right: .node):
                return (min: (key, value), tree: right!)
                
            case .node(key: let key, value: let value, left: let left, right: let right):
                let (minElement, updatedLeft) = extractMin(tree: left)
                return (min: minElement, tree: AVLTree.node(key: key, value: value, left: updatedLeft, right: right).balanced())
                
            }
            
        }
        
        switch self {
        case .empty:
            return self
            
        /*
            If searching key is lower than the key of current node, return tree with updated left branch
        */
            
        case .node(key: let currentKey, value: let currentValue, left: let left, right: let right) where key < currentKey:
            let updatedLeft = left.removeValue(for: key) ?? .empty
            return AVLTree.node(key: currentKey, value: currentValue, left: updatedLeft, right: right).balanced()
        
        /*
         If searching key is greater than the key of current node, return tree with updated right branch
        */

        case .node(key: let currentKey, value: let currentValue, left: let left, right: let right) where key > currentKey:
            let updatedRight = right.removeValue(for: key) ?? .empty
            return AVLTree.node(key: currentKey, value: currentValue, left: left, right: updatedRight).balanced()
            
        /*
             If searching key is equal to key of current node:
        */
        
        /*
             If right branch is empty, just return left branch
        */
        case .node(key: _, value: _, left: let left, right: .empty):
            return left
            
        /*
             Otherwise, extract min node from right branch, and replace current node by it
        */
            
        case .node(key: _, value: _, left: let left, right: let right):
            let (minElement, updatedRight) = extractMin(tree: right)
            guard let rightMin = minElement else { return left }
            return AVLTree.node(key: rightMin.key, value: rightMin.value, left: left, right: updatedRight).balanced()
        }
        
    }
    
}
