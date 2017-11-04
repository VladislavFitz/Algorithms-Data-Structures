//
//  TreeVisitor.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 01.09.16.
//  Copyright © 2016 Fitc. All rights reserved.
//

import Foundation

protocol TreeTraversal {
    
    static func traverse<Tree: BinaryTreeProtocol>(_ tree: Tree)
    
}

struct PreOrderTreeTraversal: TreeTraversal {
    
    static func traverse<Tree: BinaryTreeProtocol>(_ tree: Tree) {
        
        if let value = tree.value {
            print(value)
        }
        
        if let leftBranch = tree.left {
            traverse(leftBranch)
        }
        
        if let rightBranch = tree.right {
            traverse(rightBranch)
        }
        
    }
    
}

struct InOrderTreeTraversal: TreeTraversal {
    
    static func traverse<Tree: BinaryTreeProtocol>(_ tree: Tree) {
        
        if let leftBranch = tree.left {
            traverse(leftBranch)
        }
        
        if let value = tree.value {
            print(value)
        }
        
        if let rightBranch = tree.right {
            traverse(rightBranch)
        }
        
    }
    
}

struct PostOrderTreeTraversal: TreeTraversal {
    
    static func traverse<Tree: BinaryTreeProtocol>(_ tree: Tree) {
        
        if let leftBranch = tree.left {
            traverse(leftBranch)
        }
        
        if let rightBranch = tree.right {
            traverse(rightBranch)
        }
        
        if let value = tree.value {
            print(value)
        }
        
    }
    
}


