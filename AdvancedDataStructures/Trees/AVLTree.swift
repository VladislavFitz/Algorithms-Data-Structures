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
    
    init() {
        self = .empty
    }
    
    init(content: Content, left: AVLTree?, right: AVLTree?) {
        self = .node(content: content, left: left ?? .empty, right: right ?? .empty)
    }
    
    var content: Content? {
        switch self {
        case .empty:
            return .none
            
        case .node(content: let content, left: _, right: _):
            return content
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
    
    var value: Value? {
        if case .node(content: let content, left: _, right: _) = self {
            return content.value
        } else {
            return nil
        }
    }
    
    var key: Key? {
        if case .node(content: let content, left: _, right: _) = self {
            return content.key
        } else {
            return nil
        }
    }

    
    /** Left subtree of tree
    */
    
    var left: AVLTree? {
        if case .node(content: _, left: let left, right: _) = self {
            return left
        } else {
            return nil
        }
    }
    
    /** Right subtree of tree
    */
    
    var right: AVLTree? {
        if case .node(content: _, left: _, right: let right) = self {
            return right
        } else {
            return nil
        }
    }
    
    /** Balance factor of AVL tree. Balance factor ∈ {–1,0,+1} for balanced AVL tree.
     */
    
    var balanceFactor: Int {
        return (right?.height ?? 0) - (left?.height ?? 0)
    }
    
    /** Returns balanced AVL tree
    */
    
    func balanced() -> AVLTree {
        
        switch self {
        case .empty:
            return self
            
        case .node(content: let value, left: let left, right: let right):
            
            switch balanceFactor {
            case 2:
                if right.balanceFactor < 0 {
                    let rotatedright = right.rotated(by: .right)
                    let intermediateTree = AVLTree.node(content: value, left: left, right: rotatedright)
                    return intermediateTree.rotated(by: .left)
                } else {
                    return self.rotated(by: .left)
                }
                
            case -2:
                
                if left.balanceFactor > 0 {
                    let rotatedleft = left.rotated(by: .left)
                    let intermediateTree = AVLTree.node(content: value, left: rotatedleft, right: right)
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
    
    func insert(value: Value, forKey key: Key) -> AVLTree {
        
        switch self {
        case .empty:
            return .node(content: NodeContent(key: key, value: value), left: .empty, right: .empty)
            
        case .node(content: let currentValue, left: let left, right: let right):
            if currentValue.key < key {
                let newright = right.insert(value: value, forKey: key)
                return AVLTree.node(content: currentValue, left: left, right: newright).balanced()
            } else if currentValue.key > key {
                let newleft = left.insert(value: value, forKey: key)
                return AVLTree.node(content: currentValue, left: newleft, right: right).balanced()
            } else {
                return self
            }
        }
        
    }
    
    func findMin() -> AVLTree {
        switch self {
        case .node(content: _, left: .node, right: _):
            return left!.findMin()
        default:
            return self
        }
    }
    
    func findMax() -> AVLTree {
        switch self {
        case .node(content: _, left: _, right: .node):
            return right!.findMax()
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
            let content = NodeContent(key: min.key!, value: min.value!)
            return AVLTree.node(content: content, left: left, right: removeMin(tree: right)).balanced()
        }
        
    }
    
}

//MARK:- CustomStringConvertible

extension AVLTree: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .empty:
            return "nil"
        case .node(content: let value, left: let left, right: let right):
            return "\(value.key) : [ \(left) | \(right) ]"
        }
    }
    
}
