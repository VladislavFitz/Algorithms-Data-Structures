//
//  TreeRotator.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 12/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

enum RotationDirection {
  case left, right
}

struct TreeRotator {
  
  static func rotate<T: BinaryTreeProtocol>(_ tree: T, _ direction: RotationDirection) -> T {
    
    switch direction {
      
    case .left:
      
      guard let rightBranch = tree.right else { return tree }
      
      let leftBranch: T = .with(element: tree.element, left: tree.left, right: rightBranch.left)
      return .with(element: rightBranch.element, left: leftBranch, right: rightBranch.right)
      
    case .right:
      
      guard let leftBranch = tree.left else { return tree }
      
      let rightBranch: T = .with(element: tree.element, left: leftBranch.right, right: tree.right)
      return .with(element: leftBranch.element,  left: leftBranch.left, right: rightBranch)
      
    }
    
  }
  
  static func rotate<T: BinaryTreeProtocol>(_ tree: T, _ directions: [RotationDirection]) -> T {
    
    var resultTree = tree
    
    for direction in directions {
      resultTree = rotate(resultTree, direction)
    }
    
    return resultTree
    
  }
  
}

extension BinaryTreeProtocol {
  
  func rotated(by direction: RotationDirection) -> Self {
    return TreeRotator.rotate(self, direction)
  }
  
}
