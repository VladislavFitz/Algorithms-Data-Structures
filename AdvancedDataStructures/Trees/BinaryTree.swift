//
//  BinaryTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 24.10.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum NodePosition {
    case root
    case leftSubtree
    case rightSubtree
}

class BinaryTree<Key: Comparable, Payload> {
    
    let key: Key
    var payload: Payload
    var left: BinaryTree?
    var right: BinaryTree?
    weak var parent: BinaryTree?
    
    var nodePosition: NodePosition {
        
        if parent == nil {
            return .root
        }
        
        if parent?.left?.key == key {
            return .leftSubtree
        }
        
        if parent?.right?.key == key {
            return .rightSubtree
        }
        
        fatalError("Impossible position")
    }
    
    init(key: Key, payload: Payload, left: BinaryTree? = .none, right: BinaryTree? = .none, parent: BinaryTree? = .none) {
        self.key = key
        self.payload = payload
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    func value(for key: Key) -> Payload? {
        
        if key == self.key {
            return payload
        } else if key < self.key {
            return left?.value(for: key)
        } else {
            return right?.value(for: key)
        }
        
    }
    
    func set(_ value: Payload, for key: Key) {
        
        if key == self.key {
            self.payload = value
        } else if key < self.key {
            if let leftBranch = self.left {
                leftBranch.set(value, for: key)
            } else {
                self.left = BinaryTree(key: key, payload: value, parent: self)
            }
        } else {
            if let rightBranch = self.right {
                rightBranch.set(value, for: key)
            } else {
                self.right = BinaryTree(key: key, payload: value, parent: self)
            }
        }
        
    }
    
    func removeValue(for key: Key) {
        
        guard let parent = self.parent else { return }
        
        if key == self.key {
            
            switch (left, right) {
            case (.none, .none):
                
                switch nodePosition {
                case .leftSubtree:
                    parent.left = .none
                    
                case .rightSubtree:
                    parent.right = .none
                    
                case .root:
                    break
                }
                
            case (let leftSubtree, .none):
                
                switch nodePosition {
                case .leftSubtree:
                    parent.left = leftSubtree
                    
                case .rightSubtree:
                    parent.right = leftSubtree
                    
                case .root:
                    break
                }
                
            case (.none, let rightSubtree):
                
                switch nodePosition {
                case .leftSubtree:
                    parent.left = rightSubtree
                    
                case .rightSubtree:
                    parent.right = rightSubtree
                    
                case .root:
                    break
                }
                
            case (let leftSubtree, let rightSubtree):
                break
            }
            
        } else if key < self.key {
            left?.removeValue(for: key)
        } else if key > self.key {
            right?.removeValue(for: key)
        }
        
    }
    
    func rotated(by direction: RotationDirection) -> BinaryTree {
        
        switch direction {
        case .left:
            
            let leftBranch = BinaryTree(key: key, payload: payload, left: left, right: right?.left, parent: right)
            
            return BinaryTree(key: right!.key, payload: right!.payload, left: leftBranch, right: right!.right, parent: .none)
            
        case .right:
            
            let rightBranch = BinaryTree(key: key, payload: payload, left: left?.right, right: right, parent: left)
            
            return BinaryTree(key: left!.key, payload: left!.payload, left: left?.left, right: rightBranch, parent: .none)
            
        }
    }
    
}
