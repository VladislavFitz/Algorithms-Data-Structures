//
//  AVLTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.10.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

enum AVLTree<Key: Comparable, Value>: BinaryTreeProtocol where Key: Equatable {
    
    typealias Content = NodeContent<Key, Value>
    
    case empty
    indirect case node(content: Content, left: AVLTree, right: AVLTree)
    
    /** Count of nodes in tree
    */
    
    var count: Int {
        switch self {
        case .empty:
            return 0
            
        case .node(content: _, left: let left, right: let right):
            return left.count + 1 + right.count
        }
    }
    
    /** Returns true if tree is leaf (tree without subtrees)
    */
    
    var isLeaf: Bool {
        switch self {
        case .node(content: _, left: .empty, right: .empty):
            return true
        default:
            return false
        }
    }
    
    /** Node value represented as NodeContent structure
    */
    
    var value: Content? {
        if case .node(content: let value, left: _, right: _) = self {
            return value
        } else {
            return nil
        }
    }
    
    /** Left subtree of tree
    */
    
    var leftBranch: AVLTree? {
        if case .node(content: _, left: let leftBranch, right: _) = self {
            return leftBranch
        } else {
            return nil
        }
    }
    
    /** Right subtree of tree
    */
    
    var rightBranch: AVLTree? {
        if case .node(content: _, left: _, right: let rightBranch) = self {
            return rightBranch
        } else {
            return nil
        }
    }
    
    /** Height of tree in nodes
    */
    
    var height: Int {
        switch self {
        case .empty:
            return 0
        case .node(content: _, left: let leftBranch, right: let rightBranch):
            return (max(leftBranch.height, rightBranch.height) + 1)
        }
    }
    
    /** Returns rotated tree
    */
    
    func rotated(by direction: RotationDirection) -> AVLTree {
        guard case .node(content: let value, left: let leftBranch, right: let rightBranch) = self else {
            return .empty
        }
        
        switch direction {
        case .left:
            if case .node(content: let rightBranchValue, left: let rightBranchLeft, right: let rightBranchRight) = rightBranch {
                let intermediateLeftBranch = AVLTree.node(content: value, left: leftBranch, right: rightBranchLeft)
                return .node(content: rightBranchValue, left: intermediateLeftBranch, right: rightBranchRight)
            }
            
        case .right:
            if case .node(content: let leftBranchValue, left: let leftBranchLeft, right: let lettBranchRight) = leftBranch {
                let intermediateRightBranch = AVLTree.node(content: value, left: lettBranchRight, right: rightBranch)
                return .node(content: leftBranchValue, left: leftBranchLeft, right: intermediateRightBranch)
            }
            
        }
        
        return self
    }
    
    /** Balance factor of AVL tree. Balance factor ∈ {–1,0,+1} for balanced AVL tree.
     */
    
    var balanceFactor: Int {
        return (rightBranch?.height ?? 0) - (leftBranch?.height ?? 0)
    }
    
    /** Returns balanced AVL tree
    */
    
    func balanced() -> AVLTree {
        
        switch self {
        case .empty:
            return self
            
        case .node(content: let value, left: let leftBranch, right: let rightBranch):
            
            switch balanceFactor {
            case 2:
                if rightBranch.balanceFactor < 0 {
                    let rotatedRightBranch = rightBranch.rotated(by: .right)
                    let intermediateTree = AVLTree.node(content: value, left: leftBranch, right: rotatedRightBranch)
                    return intermediateTree.rotated(by: .left)
                } else {
                    return self.rotated(by: .left)
                }
                
            case -2:
                
                if leftBranch.balanceFactor > 0 {
                    let rotatedLeftBranch = leftBranch.rotated(by: .left)
                    let intermediateTree = AVLTree.node(content: value, left: rotatedLeftBranch, right: rightBranch)
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
    
    func value(forKey key: Key) -> Value? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: let value, left: let leftBranch, right: let rightBranch):
            if key == value.key {
                return value.value
            } else if key < value.key {
                return leftBranch.value(forKey: key)
            } else {
                return rightBranch.value(forKey: key)
            }
        }
    }
    
    
    func insert(value: Value, forKey key: Key) -> AVLTree {
        
        switch self {
        case .empty:
            return .node(content: NodeContent(key: key, value: value), left: .empty, right: .empty)
            
        case .node(content: let currentValue, left: let leftBranch, right: let rightBranch):
            if currentValue.key < key {
                let newRightBranch = rightBranch.insert(value: value, forKey: key)
                return AVLTree.node(content: currentValue, left: leftBranch, right: newRightBranch).balanced()
            } else if currentValue.key > key {
                let newLeftBranch = leftBranch.insert(value: value, forKey: key)
                return AVLTree.node(content: currentValue, left: newLeftBranch, right: rightBranch).balanced()
            } else {
                return self
            }
        }
        
    }
    
    func findMin() -> AVLTree {
        switch self {
        case .node(content: _, left: .node, right: _):
            return leftBranch!.findMin()
        default:
            return self
        }
    }
    
    func findMax() -> AVLTree {
        switch self {
        case .node(content: _, left: _, right: .node):
            return rightBranch!.findMax()
        default:
            return self
        }
    }
    
    func removeValueFor(key: Key) -> AVLTree {
        
        func removeMin(tree: AVLTree) -> AVLTree {
            
            switch tree {
            case .empty:
                return self
            case .node(content: _, left: .empty, right: let right):
                return right
            case .node(content: let content, left: let left, right: let right):
                return AVLTree.node(content: content, left: removeMin(tree: left), right: right).balanced()
                
            }
            
        }
        
        switch self {
        case .empty:
            return self
            
        case .node(content: let content, left: let left, right: let right) where key < content.key:
            return AVLTree.node(content: content, left: left.removeValueFor(key: key), right: right)
            
        case .node(content: let content, left: let left, right: let right) where key > content.key:
            return AVLTree.node(content: content, left: left, right: right.removeValueFor(key: key))
            
        case .node(content: _, left: let left, right: .empty):
            return left
            
        case .node(content: _, left: let left, right: let right):
            let min = right.findMin()
            return AVLTree.node(content: min.value!, left: left, right: removeMin(tree: right)).balanced()
        }
        
    }
    
}

//MARK:- CustomStringConvertible

extension AVLTree: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .empty:
            return "nil"
        case .node(content: let value, left: let leftBranch, right: let rightBranch):
            return "\(value.key) : [ \(leftBranch) | \(rightBranch) ]"
        }
    }
    
}
