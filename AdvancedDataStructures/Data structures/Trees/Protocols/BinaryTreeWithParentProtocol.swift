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

protocol BinaryTreeWithParentProtocol: StatefulBinaryTree {
  
  var parent: Self? { get }
  
  init(element: Element, left: Self?, right: Self?, parent: Self?)
  
}

extension BinaryTreeWithParentProtocol {
  
  static func with(element: Element, left: Self?, right: Self?, parent: Self?) -> Self {
    return Self(element: element, left: left, right: right, parent: parent)
  }
  
  func rotated(by direction: RotationDirection) -> Self {
    
    switch direction {
      
    case .left:
      
      guard let rightBranch = self.right else { return self }
      
      let leftBranch: Self = .with(element: element,
                                   left: left,
                                   right: rightBranch.left,
                                   parent: rightBranch)
      return .with(element: rightBranch.element,
                   left: leftBranch,
                   right: rightBranch.right,
                   parent: parent)
      
    case .right:
      
      guard let leftBranch = self.left else { return self }
      
      let rightBranch: Self = .with(element: element,
                                    left: leftBranch.right,
                                    right: right,
                                    parent: leftBranch)
      return .with(element: leftBranch.element,
                   left: leftBranch.left,
                   right: rightBranch,
                   parent: parent)
      
    }
    
  }
  
}

extension BinaryTreeWithParentProtocol {
  
  var parentRelation: ParentRelation {
    
    
    guard let existingParent = parent else {
      return .root
    }
    
    if existingParent.left?.element == element {
      return .leftSubtree
    }
    
    if existingParent.right?.element == element {
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
