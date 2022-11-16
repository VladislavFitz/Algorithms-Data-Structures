//
//  BinaryTree.swift
//  AdvancedDataStructures
//
//  Created by Vladislav Fitc on 24.10.17.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

final class BinaryTree<Element: Comparable & Equatable>: BinaryTreeWithParentProtocol {
  
  var element: Element
  
  private(set) var left: BinaryTree? {
    didSet {
      left?.parent = self
    }
  }
  
  private(set) var right: BinaryTree? {
    didSet {
      right?.parent = self
    }
  }
  
  weak var parent: BinaryTree?
  
  init(element: Element, left: BinaryTree?, right: BinaryTree?) {
    self.element = element
    self.left = left
    self.right = right
  }
  
  init(element: Element, left: BinaryTree? = .none, right: BinaryTree? = .none, parent: BinaryTree?) {
    self.element = element
    self.left = left
    self.right = right
    self.parent = parent
  }
  
  func insert(_ element: Element) {
    
    if element == self.element {
      
      self.element = element
      
    } else if element < self.element {
      
      if let leftBranch = self.left {
        leftBranch.insert(element)
      } else {
        self.left = BinaryTree(element: element,
                               parent: self)
      }
      
    } else {
      
      if let rightBranch = self.right {
        rightBranch.insert(element)
      } else {
        self.right = BinaryTree(element: element,
                                parent: self)
      }
      
    }
  }
  
  func remove(_ element: Element) {
    
    if element == self.element {
      
      switch (left, right) {
      case (.none, .none):
        
        switch parentRelation {
        case .leftSubtree:
          parent?.left = .none
          
        case .rightSubtree:
          parent?.right = .none
          
        case .root:
          break
        }
        
      case (let leftSubtree, .none):
        
        switch parentRelation {
        case .leftSubtree:
          parent?.left = leftSubtree
          
        case .rightSubtree:
          parent?.right = leftSubtree
          
        case .root:
          break
        }
        
      case (.none, let rightSubtree):
        
        switch parentRelation {
        case .leftSubtree:
          parent?.left = rightSubtree
          
        case .rightSubtree:
          parent?.right = rightSubtree
          
        case .root:
          break
        }
        
      case (.some, .some):
        let nextElement = self.next()!
        remove(nextElement.element)
        let nodeToRemove = findNode(for: self.element)
        nodeToRemove?.element = nextElement.element
      }
      
    } else if element < self.element {
      left?.remove(element)
    } else {
      right?.remove(element)
    }
    
  }
  
}
