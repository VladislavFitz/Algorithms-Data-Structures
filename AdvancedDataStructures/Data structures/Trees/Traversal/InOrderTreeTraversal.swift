//
//  InOrderTreeTraversal.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct InOrderTreeTraversal<Tree: BinaryTree>: TreeTraversal {
    
    var visit: (Tree) -> () = { print($0.element, terminator: " - ") }
    
    func traverse(_ tree: Tree) {

        if let leftBranch = tree.left {
            traverse(leftBranch)
        }
        
        visit(tree)

        if let rightBranch = tree.right {
            traverse(rightBranch)
        }
        
    }
    
}
