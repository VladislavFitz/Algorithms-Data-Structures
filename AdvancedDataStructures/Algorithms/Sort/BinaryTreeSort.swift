//
//  BinaryTreeSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

struct BinaryTreeSort<Element: Comparable>: SortAlgorithm {
    
    func sort(_ array: [Element]) -> [Element] {
        
        if array.isEmpty {
            return []
        }
        
        let treeArray = array.map({ (key: $0, value: ()) })
        
        let tree = BinaryTree(array: treeArray)!
        
        var sortedArray: [Element] = []

        var inOrderTraversal = InOrderTreeTraversal<Element, Void>()
        inOrderTraversal.visit = { sortedArray.append($0.key) }
        inOrderTraversal.traverse(tree)

        return sortedArray

    }
    
}
