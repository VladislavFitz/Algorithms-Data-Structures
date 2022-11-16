//
//  BinaryTreeProtocol.swift
//  AdvancedDataStructures
//
//  Created by Vladislav on 06/11/2017.
//  Copyright © 2017 Fitc. All rights reserved.
//

import Foundation

protocol BinaryTreeProtocol: CustomStringConvertible {
  
  associatedtype Element: Comparable & Equatable
  
  init(element: Element, left: Self?, right: Self?)
  
  /// The element representing the root node
  var element: Element { get }
  
  /// The left subtree
  var left: Self? { get }
  
  /// The right subtree
  var right: Self? { get }
  
  /// Textual description of the root node
  var nodeDescription: String { get }
  
}

extension BinaryTreeProtocol {
  
  /// Binary tree factory function
  static func with(element: Element,
                   left: Self? = nil,
                   right: Self? = nil) -> Self {
    Self(element: element,
         left: left,
         right: right)
  }
  
  /// Nodes count
  var count: Int {
    (left?.count ?? 0) + (right?.count ?? 0) + 1
  }
  
  /// Height of tree in nodes
  var height: Int {
    return max((left?.height ?? 0), (right?.height ?? 0)) + 1
  }
  
  
  /// Returns the node with min element in the tree
  func findMin() -> Self {
    var minNode = self
    
    while let leftBranch = minNode.left {
      minNode = leftBranch
    }
    
    return minNode
  }
  
  /// Returns the node with max element in the tree
  func findMax() -> Self {
    var maxNode = self
    
    while let rightBranch = maxNode.right {
      maxNode = rightBranch
    }
    
    return maxNode
  }
  
  /// Returns true if the tree contains the given element
  func contains(_ element: Element) -> Bool {
    if element == self.element {
      return true
    }
    let branch = element > self.element ? right : left
    return branch?.contains(element) ?? false
  }
  
  /// Returns tree node corresponding to key.
  /// If element is not found returns nil.
  func findNode(for element: Element) -> Self? {
    if element == self.element {
      return self
    }
    let branch = element > self.element ? right : left
    return branch?.findNode(for: element)
  }
  
  /// Returns true if tree has no subtree
  var isLeaf: Bool {
    return left == nil && right == nil
  }
  
  /// Textual representation of the element
  var nodeDescription: String {
    return "\(element)"
  }
  
}
