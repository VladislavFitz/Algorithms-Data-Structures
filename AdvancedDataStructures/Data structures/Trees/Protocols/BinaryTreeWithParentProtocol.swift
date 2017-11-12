//
//  BinaryTreeWithParentProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 11/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum ParentRelation {
    case root
    case leftSubtree
    case rightSubtree
}

protocol BinaryTreeWithParentProtocol: BinaryTreeProtocol {
    
    var parent: Self? { get }
    var parentRelation: ParentRelation { get }
    
    init(key: Key, value: Value, left: Self?, right: Self?, parent: Self?)
    
    func root() -> Self
    func next() -> Self?
    func previous() -> Self?
    
}

extension BinaryTreeWithParentProtocol {
    
    static func with(key: Key, value: Value, left: Self?, right: Self?, parent: Self?) -> Self {
        return Self(key: key, value: value, left: left, right: right, parent: parent)
    }
    
    var parentRelation: ParentRelation {
        
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
    
    func root() -> Self {
        var current = self
        
        while let parent = current.parent {
            current = parent
        }
        
        return current
    }
    
    
    func next() -> Self? {
        
        if let rightSubtree = self.right {
            return rightSubtree.findMin()
        }
        
        var node = self
        
        while let parent = node.parent, node.parentRelation == .rightSubtree {
            node = parent
        }
        
        return node.parent
        
    }
    
    func previous() -> Self? {
        
        if let leftSubtree = self.left {
            return leftSubtree.findMax()
        }
        
        var node = self
        
        while let parent = node.parent, node.parentRelation == .leftSubtree {
            node = parent
        }
        
        return node.parent
        
    }
    
    func rotated(by direction: RotationDirection) -> Self {
        
        switch direction {
            
        case .left:
            
            guard let rightBranch = self.right else { return self }
            
            let leftBranch: Self = .with(key: key, value: value, left: left, right: rightBranch.left, parent: rightBranch)
            return .with(key: rightBranch.key, value: rightBranch.value, left: leftBranch, right: rightBranch.right, parent: parent)
            
        case .right:
            
            guard let leftBranch = self.left else { return self }
            
            let rightBranch: Self = .with(key: key, value: value, left: leftBranch.right, right: right, parent: leftBranch)
            return .with(key: leftBranch.key, value: leftBranch.value,  left: leftBranch.left, right: rightBranch, parent: parent)
            
        }
        
    }
    
}

extension BinaryTreeWithParentProtocol {
    
    var brother: Self? {
        
        guard let parent = self.parent else { return .none }
        
        switch parentRelation {
        case .root:
            return .none
            
        case .leftSubtree:
            return parent.right
            
        case .rightSubtree:
            return parent.left
        }
        
    }

    var grandParent: Self? {
        return parent?.parent
    }
    
    var uncle: Self? {
        return parent?.brother
    }
    
    
}
