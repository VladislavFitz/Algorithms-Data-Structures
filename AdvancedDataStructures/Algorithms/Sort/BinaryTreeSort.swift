//
//  BinaryTreeSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class BinaryTreeSort<E: Comparable>: SortAlgorithm {
    
    typealias Element = E
    
    let input: [Element]
    var output: [Element] = []
    
    init(input: [Element]) {
        self.input = input
    }
    
    func perform() {

        let array = input
        
        if array.isEmpty {
            output = []
            return
        }
        
        let treeArray = array.map({ (key: $0, value: ()) })
        
        let tree = BinaryTree(array: treeArray)!
        
        var sortedArray: [Element] = []

        var inOrderTraversal = InOrderTreeTraversal<BinaryTree<Element, Void>>()
        inOrderTraversal.visit = { sortedArray.append($0.key) }
        inOrderTraversal.traverse(tree)

        output = sortedArray

    }
    
}
