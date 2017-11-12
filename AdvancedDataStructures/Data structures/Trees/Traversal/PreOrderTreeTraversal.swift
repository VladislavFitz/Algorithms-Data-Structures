//
//  PreOrderTreeTraversal.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct PreOrderTreeTraversal<Tree: BinaryTreeProtocol>: TreeTraversal {
    
    var visit: (Tree) -> () = { print($0.key, terminator: " - ") }
    
    func traverse(_ tree: Tree) {

        visit(tree)
        
        if let leftBranch = tree.left {
            traverse(leftBranch)
        }
        
        if let rightBranch = tree.right {
            traverse(rightBranch)
        }
        
    }
    
}
