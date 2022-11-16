//
//  BinaryTreeSort.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 05/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

class BinaryTreeSort<E: Comparable & Equatable>: SortAlgorithm {
  
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
    
    guard let tree = BinarySearchTree(array) else {
      output = []
      return
    }
    
    var sortedArray: [Element] = []
    
    var inOrderTraversal = InOrderTreeTraversal<BinarySearchTree<Element>>()
    inOrderTraversal.visit = { sortedArray.append($0.element) }
    inOrderTraversal.traverse(tree)
    
    output = sortedArray
    
  }
  
}
